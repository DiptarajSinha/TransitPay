import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/features/ticket/presentation/home_screen.dart';
import 'package:app/features/ticket/presentation/ticket_list_screen.dart';
import 'package:app/features/wallet/presentation/wallet_screen.dart';

class RiderMainScreen extends ConsumerStatefulWidget {
  const RiderMainScreen({super.key});

  @override
  ConsumerState<RiderMainScreen> createState() => _RiderMainScreenState();
}

class _RiderMainScreenState extends ConsumerState<RiderMainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(onTicketPurchased: () => _onTabTapped(1)),
      const TicketListScreen(),
      const WalletScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      resizeToAvoidBottomInset: false, // Prevent Floating Nav Bar overlapping inputs
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          
          // Floating Animated Native Bar
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem("HOME", 0),
                      _buildNavItem("TICKETS", 1),
                      _buildNavItem("WALLET", 2),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? const Color(0xFF10b981) : Colors.white54;
    
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
           color: Colors.transparent, // no background colors for text-only minimalism
           boxShadow: isSelected ? [
              BoxShadow(
                 color: color.withValues(alpha: 0.1),
                 blurRadius: 10,
                 spreadRadius: 2,
              )
           ] : [],
        ),
        child: Text(
           label, 
           style: TextStyle(
              color: color, 
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500, 
              fontSize: isSelected ? 15 : 13, 
              letterSpacing: 1.5,
           ),
        ),
      ),
    );
  }
}
