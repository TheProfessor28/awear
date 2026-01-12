import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../providers/device_discovery_provider.dart';

class PairDevicesScreen extends ConsumerWidget {
  const PairDevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(deviceManagerProvider);
    final devices = devicesAsync.valueOrNull ?? [];

    final receiver = devices
        .where((d) => d.type == DeviceType.receiver)
        .firstOrNull;
    final sender = devices
        .where((d) => d.type == DeviceType.sender)
        .firstOrNull;

    // Listen to pairing status for the Snack Bar
    ref.listen(pairingStatusProvider, (previous, next) {
      if (next == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Paired Successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    // Check if pairing is possible
    final canPair = receiver != null && sender != null;

    // Check if ALREADY paired
    // Logic: Sender exists AND Receiver exists AND Sender says "I am paired to Receiver"
    final bool isAlreadyPaired =
        canPair && (sender.pairedToMac == receiver.macAddress);

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.link, size: 64, color: Colors.blue),
          const Gap(24),
          const Text(
            "Hardware Pairing",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Connect both devices via USB to pair them.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const Gap(32),

          _statusRow("Receiver", receiver),
          const Gap(12),
          _statusRow("Sender", sender),

          const Gap(48),

          // THE BUTTON
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: canPair
                  ? () {
                      ref
                          .read(deviceManagerProvider.notifier)
                          .pairSender(receiver.macAddress);
                    }
                  : null,
              child: const Text("PAIR DEVICES"),
            ),
          ),

          // THE "ALREADY PAIRED" TEXT
          if (isAlreadyPaired) ...[
            const Gap(12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                Gap(8),
                Text(
                  "Already Paired!",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusRow(String label, ConnectedDevice? dev) {
    final isConnected = dev != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            Icon(
              isConnected ? Icons.check_circle : Icons.cancel,
              color: isConnected ? Colors.green : Colors.grey,
              size: 16,
            ),
            const Gap(8),
            Text(
              isConnected ? "Connected" : "Disconnected",
              style: TextStyle(
                color: isConnected ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
