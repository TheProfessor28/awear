import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../providers/device_discovery_provider.dart';
import 'sender_list_widget.dart';

// We need a provider to track "Seen Senders" for the table
final activeSendersProvider = StateProvider<Map<String, DateTime>>((ref) => {});

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceManagerProvider);
    final receiver = devices
        .where((d) => d.type == DeviceType.receiver)
        .firstOrNull;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Receiver Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Devices Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: receiver != null
                      ? Colors.green[100]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text("Receiver: "),
                    Text(
                      receiver != null ? "Connected" : "Disconnected",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: receiver != null
                            ? Colors.green[800]
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),

          // Table: Active Senders
          const Text(
            "Active Sender Devices",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Gap(10),

          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const SenderListWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
