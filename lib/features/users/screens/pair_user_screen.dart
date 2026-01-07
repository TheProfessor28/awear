import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../devices/screens/devices_screen.dart';
import '../providers/user_provider.dart';
import '../../dashboard/providers/selection_providers.dart';

class PairUserScreen extends ConsumerWidget {
  const PairUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUserId = ref.watch(selectedUserIdProvider);
    final activeSenders = ref.watch(activeSendersProvider);
    final users = ref.watch(userNotifierProvider).valueOrNull ?? [];

    // Filter logic: Show devices that are NOT paired to ANY user
    // (Or allow overriding? Usually unique pairing is better).
    final pairedMacs = users.map((u) => u.pairedDeviceMacAddress).toSet();
    final availableMacs = activeSenders.keys
        .where((mac) => !pairedMacs.contains(mac))
        .toList();

    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          AppBar(
            title: const Text("Select Device"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // ADDED: Cancel Button
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                // Go back to Info
                ref.read(isPairingUserProvider.notifier).set(false);
              },
            ),
          ),
          Expanded(
            child: availableMacs.isEmpty
                ? const Center(child: Text("No new devices active."))
                : ListView.builder(
                    itemCount: availableMacs.length,
                    itemBuilder: (context, index) {
                      final mac = availableMacs[index];
                      return ListTile(
                        leading: const Icon(Icons.watch),
                        title: Text(mac),
                        subtitle: const Text("Active Now"),
                        onTap: () {
                          if (selectedUserId != null) {
                            // 1. Pair
                            ref
                                .read(userNotifierProvider.notifier)
                                .pairUserWithDevice(selectedUserId, mac);
                            // 2. Return to Info Screen automatically
                            ref.read(isPairingUserProvider.notifier).set(false);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
