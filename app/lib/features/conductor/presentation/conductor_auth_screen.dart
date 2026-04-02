import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:app/features/auth/application/providers/auth_provider.dart';
import 'package:app/features/conductor/presentation/conductor_home_screen.dart';

class ConductorAuthScreen extends ConsumerStatefulWidget {
  const ConductorAuthScreen({super.key});

  @override
  ConsumerState<ConductorAuthScreen> createState() => _ConductorAuthScreenState();
}

class _ConductorAuthScreenState extends ConsumerState<ConductorAuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isSignUp = false;
  bool _isLoading = false;
  String? _errorMsg;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMsg = "Please fill all fields.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      final notifier = ref.read(authProvider.notifier);
      if (_isSignUp) {
        await notifier.signUp(email, password, role: 'conductor');
      } else {
        await notifier.signIn(email, password, role: 'conductor');
      }
      
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConductorHomeScreen()),
      );
    } catch (e) {
      setState(() => _errorMsg = e.toString().replaceFirst("Exception: ", ""));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: Stack(
        children: [
          // Conductor Theme Gradients (Emerald/Teal blobs)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10b981).withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10b981).withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  )
                ],
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: 4.seconds, begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF06b6d4).withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF06b6d4).withValues(alpha: 0.15),
                    blurRadius: 120,
                    spreadRadius: 60,
                  )
                ],
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: 5.seconds, begin: const Offset(1.1, 1.1), end: const Offset(0.7, 0.7)),
          ),

          // Glassmorphism Form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.admin_panel_settings, color: Color(0xFF10b981), size: 48),
                        const SizedBox(height: 16),
                        Text(
                          _isSignUp ? "CONDUCTOR REGISTRATION" : "CONDUCTOR PORTAL",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isSignUp
                              ? "Register new conductor account"
                              : "Secure access for transit staff",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Error Message
                        if (_errorMsg != null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              _errorMsg!,
                              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                          const SizedBox(height: 20),
                        ],

                        // Email Field
                        _ConductorTextField(
                          controller: _emailController,
                          hint: "Staff Email",
                          icon: Icons.badge_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        _ConductorTextField(
                          controller: _passwordController,
                          hint: "Access PIN",
                          icon: Icons.lock_person_outlined,
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF10b981),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _isSignUp ? "INITIALIZE" : "VERIFY & ENTER",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Toggle Mode
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignUp = !_isSignUp;
                              _errorMsg = null;
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                          ),
                          child: Text(
                            _isSignUp
                                ? "Already a conductor? Sign In"
                                : "Add new conductor? Sign Up",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms, curve: Curves.easeOutQuart),
          ),
          
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConductorTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;

  const _ConductorTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
        prefixIcon: Icon(icon, color: const Color(0xFF10b981).withValues(alpha: 0.6)),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF10b981), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}
