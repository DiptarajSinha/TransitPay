import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:app/features/conductor/application/providers/conductor_provider.dart';
import 'package:app/features/conductor/presentation/pin_verification_screen.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    formats: [BarcodeFormat.qrCode],
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 🛰️ Handle QR Detection
  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing || !mounted) return;

    final barcode = capture.barcodes.firstOrNull;
    final rawValue = barcode?.rawValue;

    if (rawValue == null || rawValue.isEmpty) return;

    final ticketId = rawValue; // ✅ FIX: UUID STRING (NOT int)

    setState(() => _isProcessing = true);

    try {
      await _controller.stop();
    } catch (_) {}

    try {
      await ref
          .read(conductorProvider.notifier)
          .verifyTicket(ticketId: ticketId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('TICKET VERIFIED'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('FAILED: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() => _isProcessing = false);

      try {
        await _controller.start();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('SCAN TICKET'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          /// 📷 CAMERA
          MobileScanner(controller: _controller, onDetect: _onDetect),

          /// 🎯 SCAN BOX
          const _ScannerOverlay(),

          /// 📝 INSTRUCTION
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Align QR inside frame',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),

          /// 🔁 PIN FALLBACK
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: _isProcessing
                    ? null
                    : () async {
                        await _controller.stop();

                        if (!mounted) return;

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PinVerificationScreen(),
                          ),
                        );

                        await _controller.start();
                      },
                child: const Text(
                  'ENTER PIN INSTEAD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),

          /// ⏳ LOADING
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

/// 🎯 Overlay
class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
