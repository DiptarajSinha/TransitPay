import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:app/features/conductor/presentation/conductor_home_screen.dart';
import 'package:app/features/conductor/presentation/conductor_auth_screen.dart';
import 'package:app/features/ticket/presentation/rider_main_screen.dart';
import 'package:app/features/auth/presentation/auth_screen.dart';
import '../application/providers/auth_provider.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isCheckingAutoLogin = true;

  @override
  void initState() {
    super.initState();
    _checkInitialAuth();
  }

  Future<void> _checkInitialAuth() async {
    // Wait for providers to initialize
    await Future.delayed(const Duration(milliseconds: 100));
    final authState = ref.read(authProvider);

    if (authState.valueOrNull != null) {
      // User is logged in! Auto-execute biometrics and enter correct portal.
      await _handleNavigation(autoMode: true);
    } else {
      if (mounted) setState(() => _isCheckingAutoLogin = false);
    }
  }

  Future<void> _handleNavigation({bool autoMode = false, String? forcedRole}) async {
    final user = ref.read(authProvider).valueOrNull;
    
    // User is logged out
    if (user == null) {
      if (!mounted) return;
      // If forcedRole is conductor, go to conductor auth
      if (forcedRole == 'conductor') {
         Navigator.push(context, MaterialPageRoute(builder: (_) => const ConductorAuthScreen()));
      } else {
         Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen()));
      }
      return;
    }

    // Role detection
    final role = user.userMetadata?['role'] ?? 'rider';
    
    // User is logged in -> Execute Biometrics
    bool authenticated = false;
    try {
      final isAvailable = await auth.canCheckBiometrics || await auth.isDeviceSupported();
      
      if (isAvailable) {
        authenticated = await auth.authenticate(
          localizedReason: 'Scan fingerprint to authenticate ${role == 'conductor' ? 'Conductor' : 'Rider'} access',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ),
        );
      } else {
        authenticated = true; 
      }
    } catch (e) {
      authenticated = false;
      if (!mounted) return;
      if (!autoMode) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Biometric Auth Error: $e')),
        );
      }
    }

    if (authenticated && mounted) {
      if (role == 'conductor') {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ConductorHomeScreen()));
      } else {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiderMainScreen()));
      }
    } else {
      if (mounted) setState(() => _isCheckingAutoLogin = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A), // Sleek Dark Background
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.8),
            radius: 1.5,
            colors: [
              const Color(0xFF1A1D2E),
              const Color(0xFF0F111A),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _isCheckingAutoLogin
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(color: Color(0xFF6366f1)),
                        const SizedBox(height: 16),
                        const Text("Restoring session...", style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LOGO & NAME
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6366f1).withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/icon.png',
                              height: 80,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_bus, color: Colors.white, size: 80),
                            ),
                          ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack).fadeIn(),
                          
                          const SizedBox(height: 24),
                          const Text(
                            'TransitPay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                          
                          const Text(
                            'Smart Travel, Simpler Life',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ).animate().fadeIn(delay: 600.ms),
                        ],
                      ),

                      const SizedBox(height: 80),

                      // ROLE SELECTION CARDS
                      _buildRoleCard(
                        title: "Rider",
                        subtitle: "Book tickets & enjoy the ride",
                        icon: Icons.person_outline_rounded,
                        color: const Color(0xFF6366f1),
                        onTap: () => _handleNavigation(forcedRole: 'rider'),
                      ).animate().fadeIn(delay: 800.ms).slideX(begin: -0.2),

                      if (authState.valueOrNull == null) ...[
                        const SizedBox(height: 20),
                        _buildRoleCard(
                          title: "Conductor",
                          subtitle: "Manage trips & verify tickets",
                          icon: Icons.verified_user_outlined,
                          color: Colors.teal,
                          onTap: () => _handleNavigation(forcedRole: 'conductor'),
                        ).animate().fadeIn(delay: 1000.ms).slideX(begin: 0.2),
                      ],
                      
                      const Spacer(),
                      const Text(
                        "v1.0.0",
                        style: TextStyle(color: Colors.white10, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.2), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

