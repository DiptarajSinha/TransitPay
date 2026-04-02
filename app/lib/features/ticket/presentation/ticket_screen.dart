import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:intl/intl.dart';
import 'package:app/features/ticket/application/providers/single_ticket_provider.dart';
import 'package:app/features/ticket/data/models/ticket_isar.dart';

class TicketScreen extends ConsumerStatefulWidget {
  final String ticketId;

  const TicketScreen({super.key, required this.ticketId});

  @override
  ConsumerState<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends ConsumerState<TicketScreen> {
  @override
  void initState() {
    super.initState();
    _enableSecurity();
  }

  Future<void> _enableSecurity() async {
    if (kIsWeb) return;
    await ScreenProtector.protectDataLeakageOn();
    await ScreenProtector.preventScreenshotOn();
  }

  Future<void> _disableSecurity() async {
    if (kIsWeb) return;
    await ScreenProtector.protectDataLeakageOff();
    await ScreenProtector.preventScreenshotOff();
  }

  @override
  void dispose() {
    Future.microtask(_disableSecurity);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketAsync = ref.watch(singleTicketProvider(widget.ticketId));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TRANSIT PASS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 14)),
        centerTitle: true,
      ),
      body: ticketAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, _) => Center(child: Text(e.toString(), style: const TextStyle(color: Colors.red))),
        data: (ticket) {
          if (ticket == null) return const Center(child: Text("Ticket Not Found", style: TextStyle(color: Colors.white)));
          return _BoardingPassContent(ticket: ticket);
        },
      ),
    );
  }
}

class _BoardingPassContent extends StatelessWidget {
  final TicketIsar ticket;
  const _BoardingPassContent({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TOP SECTION (Flight Info Style)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildFlightInfo("FROM", ticket.source)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.directions_bus, color: Colors.black, size: 24),
                        ),
                        Expanded(child: _buildFlightInfo("TO", ticket.destination, crossAxisAlignment: CrossAxisAlignment.end)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGridInfo("DATE", "${ticket.createdAt.toLocal().day} ${DateFormat('MMM').format(ticket.createdAt.toLocal()).toUpperCase()} ${ticket.createdAt.toLocal().year}"),
                        _buildGridInfo("TIME", DateFormat('hh:mm a').format(ticket.createdAt.toLocal())),
                        _buildGridInfo("PASSENGERS", ticket.passengerCount.toString()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildGridInfo("FARE", "₹${ticket.totalPrice.toStringAsFixed(2)}"),
                        () {
                          final isExpired = DateTime.now().isAfter(ticket.createdAt.add(const Duration(hours: 12)));
                          return _buildGridInfo(
                            "STATUS", 
                            isExpired ? "EXPIRED" : (ticket.verified ? "VERIFIED" : "ACTIVE"), 
                            textColor: isExpired ? Colors.red : (ticket.verified ? Colors.green : Colors.blue)
                          );
                        }(),
                        _buildGridInfo("PIN", ticket.pin, isBold: true),
                      ],
                    ),
                  ],
                ),
              ),

              // PERFORATION
              const _TicketPerforation(),

              // BOTTOM SECTION (QR & Manual Entry)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text("BOARDING QR CODE", style: TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: QrImageView(
                        data: ticket.id,
                        size: 200,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "PRESENT TO CONDUCTOR FOR SCANNING\nOR PROVIDE PIN MANUALLY",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black26, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 16),
                    if (ticket.verified) ...[
                       const Divider(),
                       const SizedBox(height: 8),
                       _buildInlineInfo("ROUTE", ticket.routeNo ?? "N/A"),
                       _buildInlineInfo("VEHICLE", ticket.vehicleNo ?? "N/A"),
                       _buildInlineInfo("VERIFIED AT", ticket.verifiedAt != null ? DateFormat('hh:mm a').format(ticket.verifiedAt!.toLocal()) : "N/A"),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightInfo(String label, String value, {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: const TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          value.toUpperCase(), 
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.2),
          softWrap: true,
        ),
      ],
    );
  }

  Widget _buildGridInfo(String label, String value, {Color textColor = Colors.black, bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: textColor, fontSize: 14, fontWeight: isBold ? FontWeight.w900 : FontWeight.bold)),
      ],
    );
  }

  Widget _buildInlineInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black38, fontSize: 11, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _TicketPerforation extends StatelessWidget {
  const _TicketPerforation();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
          height: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                (constraints.constrainWidth() / 10).floor(),
                (index) => const SizedBox(width: 5, height: 1, child: DecoratedBox(decoration: BoxDecoration(color: Colors.black12))),
              ),
            );
          }),
        ),
        SizedBox(
          width: 10,
          height: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
