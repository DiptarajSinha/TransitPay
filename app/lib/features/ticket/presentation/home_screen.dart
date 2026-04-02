import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:app/features/ticket/application/providers/ticket_provider.dart';
import 'package:app/features/wallet/application/providers/wallet_provider.dart';
import 'package:app/features/auth/application/providers/auth_provider.dart';
import 'package:app/features/auth/presentation/role_selection_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final VoidCallback onTicketPurchased;
  
  const HomeScreen({super.key, required this.onTicketPurchased});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Mock Station Distances (km from a central point) in Kolkata
  final Map<String, double> stationDistances = {
    "Dum Dum": 0.0,
    "Belgachia": 2.5,
    "Shyambazar": 4.1,
    "Esplanade": 9.2,
    "Park Street": 10.5,
    "Rabindra Sadan": 11.5,
    "Kalighat": 14.8,
    "Tollygunge": 16.2,
    "Garia": 20.8,
    "Salt Lake Sector V": 12.0,
    "Howrah Station": 8.0,
    "Sealdah": 6.5,
    "Ruby Hospital": 18.2,
  };

  late final List<String> stations;

  String? _source;
  String? _destination;
  int _ticketCount = 1;
  bool _isLoading = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    stations = stationDistances.keys.toList();
  }

  double get _ticketFare {
    if (_source == null || _destination == null) return 0.0;
    if (_source == _destination) return 0.0;
    if (!stations.contains(_source) || !stations.contains(_destination)) return 0.0;
    
    final srcKm = stationDistances[_source] ?? 0.0;
    final destKm = stationDistances[_destination] ?? 0.0;
    
    final distance = (srcKm - destKm).abs();
    // Base fare ₹5 + ₹2 per km. Rounded strictly.
    final fare = 5.0 + (distance * 2.0);
    return fare.roundToDouble(); 
  }

  Future<void> _handlePurchase() async {
    if (_source == null || _destination == null || _source!.isEmpty || _destination!.isEmpty) {
      setState(() => _errorMsg = "Please enter boarding point and destination.");
      return;
    }
    if (!stations.contains(_source)) {
      setState(() => _errorMsg = "Source Not Found.");
      return;
    }
    if (!stations.contains(_destination)) {
      setState(() => _errorMsg = "Destination Not Found.");
      return;
    }
    if (_source == _destination) {
      setState(() => _errorMsg = "Source and destination cannot be identical.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    final totalFare = _ticketFare * _ticketCount;

    try {
      await ref.read(ticketProvider.notifier).buyTicket(
            source: _source!,
            destination: _destination!,
            cost: totalFare,
            quantity: _ticketCount,
          );
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$_ticketCount Ticket(s) Purchased Successfully!"),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      widget.onTicketPurchased();
      
      setState(() {
        _source = null;
        _destination = null;
        _ticketCount = 1;
      });
    } catch (e) {
      setState(() => _errorMsg = e.toString().replaceFirst("Exception: ", ""));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openStationPicker(bool isSource) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // allows taking up full screen for keyboard
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _StationSearchSheet(
           stations: stations,
           title: isSource ? "Select Boarding Point" : "Select Destination",
           onSelected: (st) {
              setState(() {
                if (isSource) { _source = st; } else { _destination = st; }
                 _errorMsg = null;
              });
           }
        );
      },
    );
  }

  Widget _buildStationSelector({
    required String hint,
    required IconData icon,
    required String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value ?? hint,
                style: TextStyle(
                  color: value == null ? Colors.white.withValues(alpha: 0.4) : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white54),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletAsync = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: Stack(
        children: [
          // Dynamic Header Gradient
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6366f1).withValues(alpha: 0.3),
                    const Color(0xFF10b981).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 4.seconds, begin: const Offset(0.9, 0.9), end: const Offset(1.2, 1.2)),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24, 
                right: 24, 
                top: 20, 
                bottom: 150 + MediaQuery.of(context).viewInsets.bottom
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48), // balance space
                      const Expanded(
                        child: Text(
                          "TransitPay",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white54),
                        onPressed: () async {
                           await ref.read(authProvider.notifier).signOut();
                           if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                                (route) => false,
                              );
                           }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Premium Hero Header
                  const Text(
                    "Where are we\ngoing today?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ).animate().fadeIn().slideY(begin: -0.1),
                  const SizedBox(height: 32),

                  // Top wallet bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Wallet Balance",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      walletAsync.when(
                        data: (wallet) => Text(
                          "₹${wallet.balance.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Color(0xFF10b981),
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ).animate().shimmer(duration: 2.seconds),
                        loading: () => const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                        error: (_, __) => const Text("Blocked", style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ).animate().fadeIn().slideX(begin: 0.1),

                  const SizedBox(height: 32),

                  // Booking Glass Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("TRIP DETAILS", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            const SizedBox(height: 24),
                            
                            // Source Button
                            _buildStationSelector(
                              hint: "Type or Select Boarding...",
                              icon: Icons.location_on_outlined,
                              value: _source,
                              onTap: () => _openStationPicker(true),
                            ),
                            
                            const SizedBox(height: 16),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Icon(Icons.swap_vert, color: Colors.white30),
                            ),
                            const SizedBox(height: 16),

                            // Destination Button
                            _buildStationSelector(
                              hint: "Type or Select Destination...",
                              icon: Icons.flag_outlined,
                              value: _destination,
                              onTap: () => _openStationPicker(false),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Ticket counter
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Tickets", style: TextStyle(color: Colors.white70, fontSize: 16)),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Explicit pure white override ensuring black buttons are fully apparent
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: _ticketCount > 1 ? () => setState(() => _ticketCount--) : null,
                                        behavior: HitTestBehavior.opaque,
                                        child: Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                           child: Icon(Icons.remove, color: _ticketCount > 1 ? Colors.black : Colors.black26, size: 24),
                                        ),
                                      ),
                                      Text(
                                        _ticketCount.toString(),
                                        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                                      ),
                                      GestureDetector(
                                        onTap: _ticketCount < 5 ? () => setState(() => _ticketCount++) : null,
                                        behavior: HitTestBehavior.opaque,
                                        child: Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                           child: Icon(Icons.add, color: _ticketCount < 5 ? Colors.black : Colors.black26, size: 24),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 32),
                            
                            // Cost Summary
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total Fare", style: TextStyle(color: Colors.white70, fontSize: 16)),
                                Text(
                                  "₹${(_ticketFare * _ticketCount).toStringAsFixed(2)}",
                                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                                ).animate(target: 1).scale(duration: 200.ms),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),

                  const SizedBox(height: 24),

                  if (_errorMsg != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        _errorMsg!,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ).animate().fadeIn(),

                  // Buy Button
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handlePurchase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366f1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "PURCHASE TICKETS",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                            ),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StationSearchSheet extends StatefulWidget {
  final List<String> stations;
  final String title;
  final ValueChanged<String> onSelected;

  const _StationSearchSheet({required this.stations, required this.title, required this.onSelected});

  @override
  State<_StationSearchSheet> createState() => _StationSearchSheetState();
}

class _StationSearchSheetState extends State<_StationSearchSheet> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filtered = widget.stations.where((s) => s.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Color(0xFF1a1a1a),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search Kolkata Stations...",
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filtered.isEmpty 
              ? Center(child: Text("Station Not Found", style: TextStyle(color: Colors.white.withValues(alpha: 0.5))))
              : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final st = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.train, color: Color(0xFF6366f1)),
                  title: Text(st, style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onSelected(st);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
