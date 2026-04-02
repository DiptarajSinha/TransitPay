import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/features/conductor/data/models/conductor_shift.dart';
import 'package:app/features/conductor/data/repositories/conductor_repository.dart';
import 'package:app/features/conductor/application/providers/conductor_repository_provider.dart';
import 'package:app/features/auth/application/providers/auth_provider.dart';
import 'package:app/core/widgets/searchable_dropdown.dart';
import 'package:app/features/conductor/presentation/qr_scanner_screen.dart';
import 'package:app/features/conductor/presentation/pin_verification_screen.dart';

class ConductorHomeScreen extends ConsumerStatefulWidget {
  const ConductorHomeScreen({super.key});

  @override
  ConsumerState<ConductorHomeScreen> createState() => _ConductorHomeScreenState();
}

class _ConductorHomeScreenState extends ConsumerState<ConductorHomeScreen> {
  String? _selectedRoute;
  String? _selectedVehicle;
  String? _source;
  String? _destination;
  bool _isLoading = false;
  bool _hasActiveShift = false;
  ConductorShift? _activeShift;
  String? _errorMsg;

  // Mock data – in real app fetch from Supabase
  final List<String> _routes = ['Route 101', 'Route 102', 'Route 103', 'Route 201', 'Route 202'];
  final List<String> _vehicles = ['WB-01-A-1234', 'WB-01-B-5678', 'WB-02-C-9012', 'WB-03-D-3456'];

  @override
  void initState() {
    super.initState();
    _checkActiveShift();
  }

  Future<void> _checkActiveShift() async {
    final shift = await ref.read(conductorRepositoryProvider).getActiveShift();
    if (mounted) {
      setState(() {
        _hasActiveShift = shift != null;
        _activeShift = shift;
        if (shift != null) {
          _selectedRoute = "Route ${shift.routeNo}";
          _selectedVehicle = shift.vehicleNo;
          _source = shift.source;
          _destination = shift.destination;
        }
      });
    }
  }

  Future<void> _startShift() async {
    if (_selectedRoute == null || _selectedVehicle == null || _source == null || _destination == null) {
      setState(() => _errorMsg = 'Select route, vehicle, source and destination');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });
    try {
      final user = ref.read(authProvider).valueOrNull;
      if (user == null) throw Exception('Auth session missing');
      
      final routeString = _selectedRoute?.split(' ').last ?? '101';
      final routeInt = int.tryParse(routeString) ?? 101;
      
      await ref.read(conductorRepositoryProvider).startShift(
        conductorId: user.id,
        routeNo: routeInt,
        vehicleNo: _selectedVehicle!,
        source: _source,
        destination: _destination,
        originalFileName: 'shift_start.png',
        imageBytes: Uint8List(0),
      );
      
      await _checkActiveShift();
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shift started successfully!'), backgroundColor: Color(0xFF10b981)),
      );
    } catch (e) {
      String msg = e.toString().replaceFirst('Exception: ', '');
      if (msg.contains('row-level security policy')) {
        msg = 'Database Access Denied (RLS Violation).';
      }
      setState(() => _errorMsg = msg);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _endShift() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(conductorRepositoryProvider).endShift();
      await _checkActiveShift();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shift ended successfully!'), backgroundColor: Color(0xFF6366f1)),
      );
    } catch (e) {
      setState(() => _errorMsg = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _ensureShift(VoidCallback onValid) {
    if (_hasActiveShift) {
      onValid();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          title: const Text("No Active Shift", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text("You must activate a shift with route and vehicle details before verifying tickets.", style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Color(0xFF6366f1))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: Stack(
        children: [
          // Conductor Gradient Theme (Indigo/Gold Accent)
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6366f1).withValues(alpha: 0.15),
                    const Color(0xFF6366f1).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 5.seconds, begin: const Offset(1.0, 1.0), end: const Offset(1.3, 1.3)),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                        tooltip: 'Back to Role Selection',
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Conductor\nDashboard",
                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, height: 1.1, letterSpacing: -1),
                  ).animate().fadeIn().slideX(begin: -0.1),
                  
                  const SizedBox(height: 40),
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _hasActiveShift ? "SHIFT ACTIVE" : "START NEW SHIFT", 
                              style: TextStyle(color: _hasActiveShift ? const Color(0xFF10b981) : Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 2)
                            ),
                            const SizedBox(height: 32),
                            
                            SearchableDropdown(
                              items: _routes,
                              label: "ROUTE SELECTION",
                              value: _selectedRoute,
                              onChanged: _hasActiveShift ? (String? _) {} : (String? v) => setState(() => _selectedRoute = v),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            SearchableDropdown(
                              items: _vehicles,
                              label: "VEHICLE SELECTION",
                              value: _selectedVehicle,
                              onChanged: _hasActiveShift ? (String? _) {} : (String? v) => setState(() => _selectedVehicle = v),
                            ),
                            
                            const SizedBox(height: 24),

                            Row(
                              children: [
                                Expanded(
                                  child: SearchableDropdown(
                                    items: const ['Howrah', 'Sealdah', 'Esplanade', 'Salt Lake', 'Garia'],
                                    label: "SOURCE",
                                    value: _source,
                                    onChanged: _hasActiveShift ? (String? _) {} : (String? v) => setState(() => _source = v),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: SearchableDropdown(
                                    items: const ['Howrah', 'Sealdah', 'Esplanade', 'Salt Lake', 'Garia'],
                                    label: "DESTINATION",
                                    value: _destination,
                                    onChanged: _hasActiveShift ? (String? _) {} : (String? v) => setState(() => _destination = v),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 32),
                            
                            if (_errorMsg != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(_errorMsg!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
                              ),
                            
                            SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : (_hasActiveShift ? _endShift : _startShift),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _hasActiveShift ? Colors.redAccent.withValues(alpha: 0.8) : const Color(0xFF6366f1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: _isLoading
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                    : Text(_hasActiveShift ? 'END SHIFT' : 'ACTIVATE SHIFT', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 40),
                  
                  const Text("TICKET VERIFICATION", style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _VerificationButton(
                          label: "QR SCANNER",
                          icon: Icons.qr_code_scanner,
                          color: const Color(0xFF10b981),
                          onTap: () => _ensureShift(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const QrScannerScreen()))),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _VerificationButton(
                          label: "MANUAL PIN",
                          icon: Icons.vpn_key_outlined,
                          color: const Color(0xFF6366f1),
                          onTap: () => _ensureShift(() => Navigator.push(context, MaterialPageRoute(builder: (_) => const PinVerificationScreen()))),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 40),
                  
                  TextButton.icon(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signOut();
                      if (context.mounted) Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout, color: Colors.white30, size: 20),
                    label: const Text("END SESSION", style: TextStyle(color: Colors.white30, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _VerificationButton({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
