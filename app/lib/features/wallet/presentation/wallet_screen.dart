import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../application/providers/wallet_provider.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  final List<double> topUpAmounts = [50.0, 100.0, 200.0, 500.0];
  double _selectedAmount = 100.0;
  bool _isLoading = false;
  
  final TextEditingController _customAmountController = TextEditingController();

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  Future<void> _processTopUp() async {
    double finalAmount = _selectedAmount;
    
    if (_customAmountController.text.isNotEmpty) {
      final parsed = double.tryParse(_customAmountController.text);
      if (parsed != null && parsed > 0) {
        finalAmount = parsed;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Please enter a valid amount."),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      // Simulate Stripe Network Delay
      await Future.delayed(const Duration(seconds: 2));
      
      await ref.read(walletProvider.notifier).topUp(finalAmount);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("₹${finalAmount.toStringAsFixed(2)} added successfully!"),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _customAmountController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Topup failed: ${e.toString().replaceAll('Exception: ', '')}"),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletAsync = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        title: const Text('WALLET', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Ambient Gradient
          Positioned(
            top: 100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10b981).withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF10b981).withValues(alpha: 0.15), blurRadius: 100, spreadRadius: 50)
                ],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).slideX(begin: 0.2, end: -0.2, duration: 5.seconds),

          SingleChildScrollView(
            padding: EdgeInsets.only(
               left: 24, 
               right: 24, 
               top: 12, 
               bottom: 150 + MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Balance Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.account_balance_wallet_outlined, size: 40, color: Colors.white.withValues(alpha: 0.5)),
                          const SizedBox(height: 16),
                          const Text("Available Balance", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          const SizedBox(height: 8),
                          walletAsync.when(
                            data: (wallet) => Text(
                              "₹${wallet.balance.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -1),
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (e, __) => Text(e.toString().contains("42501") ? "RLS Blocked" : "Error", style: const TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                          ).animate().shimmer(duration: 2.seconds),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn().slideY(begin: 0.1),

                const SizedBox(height: 40),

                const Text("SELECT TOP-UP AMOUNT", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const SizedBox(height: 16),

                // Amount grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: topUpAmounts.map((amt) {
                    final isSelected = _selectedAmount == amt && _customAmountController.text.isEmpty;
                    return InkWell(
                      onTap: () {
                         _customAmountController.clear();
                         setState(() => _selectedAmount = amt);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF10b981).withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF10b981) : Colors.white.withValues(alpha: 0.1),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "₹${amt.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF10b981) : Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                const SizedBox(height: 16),
                
                // Custom Amount Input
                TextField(
                   controller: _customAmountController,
                   keyboardType: const TextInputType.numberWithOptions(decimal: true),
                   style: const TextStyle(color: Colors.white, fontSize: 18),
                   onChanged: (val) {
                      setState(() {}); // refresh UI to unset preset active states
                   },
                   decoration: InputDecoration(
                     hintText: "Enter Custom Amount",
                     hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                     prefixIcon: Icon(Icons.currency_rupee, color: Colors.white.withValues(alpha: 0.5)),
                     filled: true,
                     fillColor: Colors.white.withValues(alpha: 0.08),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF10b981), width: 1.5)),
                   ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 48),

                // Mock Stripe Logic
                Text(
                  "Payments secured implicitly via Stripe Mock",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 12),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _processTopUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10b981),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "ADD ₹${_customAmountController.text.isNotEmpty ? _customAmountController.text : _selectedAmount.toStringAsFixed(0)}",
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                  ),
                ).animate().scale(delay: 400.ms),
              ],
            ),
          ),

          if (_isLoading)
            Container(
               color: Colors.black54,
               child: const Center(child: CircularProgressIndicator(color: Color(0xFF10b981))),
            ),
        ],
      ),
    );
  }
}
