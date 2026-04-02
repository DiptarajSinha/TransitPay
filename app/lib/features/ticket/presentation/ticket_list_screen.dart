import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:app/features/ticket/application/providers/ticket_provider.dart';
import 'package:app/features/ticket/data/models/ticket_isar.dart';
import 'package:app/features/ticket/presentation/ticket_screen.dart';

class TicketListScreen extends ConsumerWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(ticketProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF030303),
      body: SafeArea(
        child: Column(
          children: [
            // Modern Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                children: [
                   const Text(
                     "My Tickets",
                     style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                   ),
                   const Spacer(),
                   Container(
                     padding: const EdgeInsets.all(8),
                     decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                     ),
                     child: const Icon(Icons.confirmation_num_outlined, color: Colors.white, size: 28),
                   )
                ],
              ).animate().fadeIn(),
            ),
            
            Expanded(
              child: ticketsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF6366f1))),
                error: (e, _) => Center(child: Text(e.toString(), style: const TextStyle(color: Colors.red))),
                data: (tickets) {
                  if (tickets.isEmpty) return const Center(child: Text("No tickets found. Grab one!", style: TextStyle(color: Colors.white54, fontSize: 16)));

                  final sortedTickets = [...tickets];
                  sortedTickets.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                  final active = sortedTickets.where((t) => DateTime.now().isBefore(t.createdAt.add(const Duration(hours: 12)))).toList();
                  final expired = sortedTickets.where((t) => DateTime.now().isAfter(t.createdAt.add(const Duration(hours: 12)))).toList();

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    children: [
                      if (active.isNotEmpty) ...[
                        const Text("ACTIVE", style: TextStyle(color: Color(0xFF10b981), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        const SizedBox(height: 16),
                        ...active.map((t) => _TicketCard(ticket: t, isExpired: false)).toList(),
                        const SizedBox(height: 24),
                      ],
                      if (expired.isNotEmpty) ...[
                        const Text("EXPIRED", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        const SizedBox(height: 16),
                        ...expired.map((t) => _TicketCard(ticket: t, isExpired: true)).toList(),
                      ]
                    ],
                  );
                }
              ),
            ),
          ]
        )
      )
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketIsar ticket;
  final bool isExpired;

  const _TicketCard({required this.ticket, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TicketScreen(ticketId: ticket.id))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isExpired ? Colors.white.withValues(alpha: 0.02) : Colors.white.withValues(alpha: 0.05),
          border: Border.all(color: isExpired ? Colors.transparent : Colors.white.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isExpired ? Colors.white10 : const Color(0xFF6366f1).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.qr_code, color: isExpired ? Colors.white30 : const Color(0xFF6366f1)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ticket.source} → ${ticket.destination}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: isExpired ? Colors.white30 : Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        ticket.verified ? "VERIFIED" : (isExpired ? "EXPIRED" : "ACTIVE"),
                        style: TextStyle(
                          color: ticket.verified ? const Color(0xFF10b981) : (isExpired ? Colors.white24 : const Color(0xFF6366f1)),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!isExpired)
                        const Text(
                          "• TAP TO VIEW",
                          style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: isExpired ? Colors.white10 : Colors.white24),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1),
    );
  }
}

