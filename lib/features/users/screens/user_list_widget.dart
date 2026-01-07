import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../dashboard/providers/selection_providers.dart';
import '../../dashboard/providers/view_mode_provider.dart';
import '../providers/user_provider.dart';
import 'user_registration_dialog.dart';

class UserListWidget extends ConsumerWidget {
  const UserListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the database for changes
    final userState = ref.watch(userNotifierProvider);
    // 2. Watch who is currently selected (to highlight the card)
    final selectedId = ref.watch(selectedUserIdProvider);
    // 3. Watch the current View Mode (to highlight the Devices button)
    final viewMode = ref.watch(dashboardViewModeProvider);

    return Column(
      children: [
        // --- Header Section ---
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const UserRegistrationDialog(),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Register User"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                ),
              ),
              const Gap(8),

              // --- DEVICES BUTTON ---
              OutlinedButton.icon(
                onPressed: () {
                  // 1. Clear any selected user so the UI state is clean
                  ref.read(selectedUserIdProvider.notifier).clear();

                  // 2. Switch the AppShell to "Devices Mode"
                  ref
                      .read(dashboardViewModeProvider.notifier)
                      .setMode(DashboardMode.devices);
                },
                // Highlight this button if we are currently in Devices Mode
                style: viewMode == DashboardMode.devices
                    ? OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue[50],
                        side: const BorderSide(color: Colors.blue),
                      )
                    : null,
                icon: const Icon(Icons.usb),
                label: const Text("Devices"),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // --- List Section ---
        Expanded(
          child: userState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
            data: (users) {
              if (users.isEmpty) {
                return const Center(child: Text("No users registered yet."));
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final isSelected = user.id == selectedId;

                  return Card(
                    elevation: isSelected ? 4 : 0,
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : null,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(
                        "${user.lastName}, ${user.firstName}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${user.role} • ${user.yearLevel}"),
                      trailing: Text(
                        user.section,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      // --- USER TAP ---
                      onTap: () {
                        // 1. Reset Column 3 States (Clean Slate)
                        // Stop showing "Pair User" screen
                        ref.read(isPairingUserProvider.notifier).set(false);
                        // Stop showing "Graph" (Default to User Info)
                        ref.read(selectedVitalProvider.notifier).clear();

                        // 2. Select the User (Data)
                        ref
                            .read(selectedUserIdProvider.notifier)
                            .select(user.id);

                        // 3. Switch Mode (Layout)
                        // This triggers the AppShell rebuild. By doing this LAST,
                        // we ensure the other flags are already safe.
                        ref
                            .read(dashboardViewModeProvider.notifier)
                            .setMode(DashboardMode.users);
                      },
                      leading: CircleAvatar(child: Text(user.firstName[0])),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
