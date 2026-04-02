// File location: features/conductor/presentation/pin_verification_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/features/conductor/application/providers/conductor_provider.dart';

class PinVerificationScreen extends ConsumerStatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  ConsumerState<PinVerificationScreen> createState() =>
      _PinVerificationScreenState();
}

class _PinVerificationScreenState extends ConsumerState<PinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  
  // UI States
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _routeNo;
  String? _vehicleNo;
  String? _error;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  /// 🚀 Handshake & Verification Logic
  Future<void> _submit() async {
    final pin = _pinController.text.trim();

    if (pin.length != 4) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await ref.read(conductorProvider.notifier).verifyTicketByPin(pin: pin);

      if (!mounted) return;

      final shift = ref.read(conductorProvider).value;

      setState(() {
        _isLoading = false;
        _isSuccess = true;
        _routeNo = shift?.routeNo.toString() ?? '-';
        _vehicleNo = shift?.vehicleNo ?? '-';
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _error = 'Verification failed: Invalid PIN';
      });

      _pinController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 1. SUCCESS STATE (Highest Priority Layer)
    if (_isSuccess) {
      return Scaffold(
        backgroundColor: Colors.green.shade700,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.white),
              const SizedBox(height: 24),
              const Text(
                'TICKET VERIFIED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Route: $_routeNo',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Vehicle: $_vehicleNo',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 🛡️ 2. INPUT STATE (Standard UI)
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        title: const Text('MANUAL ENTRY'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the 4-digit security PIN from the customer ticket.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 40),

            /// 🔢 PIN Input
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              autofocus: true,
              maxLength: 4,
              obscureText: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (_) => _isLoading ? null : _submit(),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: const Color(0xFF111111),
                hintText: '••••',
                hintStyle: const TextStyle(color: Colors.white10, letterSpacing: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF6366f1), width: 2),
                ),
              ),
            ),

            // ❌ Error UI
            if (_error != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
              ),
            ],

            const SizedBox(height: 48),

            /// 🚀 Action Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366f1),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : const Text(
                        'VERIFY TICKET',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 1.5),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}