import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges; // [NEW] Import Badges

import '../providers/user_provider.dart';
import '../../dashboard/providers/selection_providers.dart';
import '../../chat/providers/chat_providers.dart'; // [NEW] Import Chat Providers
import 'user_registration_dialog.dart';

class UserInformationWidget extends ConsumerWidget {
  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedUserIdProvider);
    final userList = ref.watch(userNotifierProvider).valueOrNull ?? [];

    if (selectedId == null) return const Center(child: Text("Select a User"));

    final user = userList.where((u) => u.id == selectedId).firstOrNull;
    if (user == null) return const Center(child: Text("User not found"));

    // [NEW] Watch Unread Messages for the Badge
    final unreadCountAsync = ref.watch(
      unreadMessageCountProvider(user.id.toString()),
    );
    final unreadCount = unreadCountAsync.valueOrNull ?? 0;

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Header ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Information",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              // --- Menu Button ---
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      builder: (_) => UserRegistrationDialog(userToEdit: user),
                    );
                  } else if (value == 'delete') {
                    _showDeleteConfirm(context, ref, user);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        Gap(10),
                        Text("Edit Info"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Gap(10),
                        Text("Delete User"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          const Gap(10),

          // --- Details List ---
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildInfoRow(
                    "Full Name",
                    "${user.lastName}, ${user.firstName}",
                  ),
                  _buildInfoRow("Student ID", user.studentId),
                  _buildInfoRow("Role", user.role),
                  _buildInfoRow("Year & Section", user.section),
                  _buildInfoRow(
                    "Date of Birth",
                    DateFormat('yyyy-MM-dd').format(user.dateOfBirth),
                  ),
                  const Gap(20),
                  const Text(
                    "Medical Info",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  _buildInfoRow("Height", "${user.height ?? '--'} cm"),
                  _buildInfoRow("Weight", "${user.weight ?? '--'} kg"),
                  _buildInfoRow("Blood Type", user.bloodType ?? '--'),
                  _buildInfoRow("Notes", user.medicalInfo ?? 'None'),
                  const Gap(20),
                  const Text(
                    "Device Connection",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  _buildInfoRow(
                    "Paired MAC",
                    user.pairedDeviceMacAddress ?? "Not Paired",
                  ),
                ],
              ),
            ),
          ),

          // --- Bottom Buttons (Chat & Pair) ---
          const Divider(),
          const Gap(10),

          Row(
            children: [
              // 1. Chat Button (Left Side)
              Expanded(
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -12, end: -5),
                  showBadge: unreadCount > 0,
                  badgeContent: Text(
                    unreadCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  child: SizedBox(
                    height: 50, // Force same height
                    width: double.infinity, // Fill Expanded
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero, // Compact for side-by-side
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text("Chat"),
                      onPressed: () {
                        ref
                            .read(userDetailViewModeProvider.notifier)
                            .set(UserDetailView.chat);
                      },
                    ),
                  ),
                ),
              ),

              const Gap(12), // Space between buttons
              // 2. Pair/Unpair Button (Right Side)
              Expanded(
                child: SizedBox(
                  height: 50, // Force same height
                  child: user.pairedDeviceMacAddress == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            ref.read(isPairingUserProvider.notifier).set(true);
                          },
                          icon: const Icon(Icons.link),
                          label: const Text("Pair"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      : OutlinedButton.icon(
                          onPressed: () async {
                            await ref
                                .read(userNotifierProvider.notifier)
                                .unpairUser(user.id);
                          },
                          icon: const Icon(Icons.link_off),
                          label: const Text("Unpair"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref, dynamic user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Delete User",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        content: Text(
          "Are you sure you want to delete ${user.firstName} ${user.lastName}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              ref.read(userNotifierProvider.notifier).deleteUser(user.id);
              ref.read(selectedUserIdProvider.notifier).clear();
              Navigator.pop(ctx);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
