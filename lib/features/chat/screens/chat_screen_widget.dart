import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../core/providers.dart'; // for syncService
import '../../users/providers/user_provider.dart';
import '../../dashboard/providers/selection_providers.dart';
import '../providers/chat_providers.dart';

class ChatScreenWidget extends ConsumerStatefulWidget {
  const ChatScreenWidget({super.key});

  @override
  ConsumerState<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends ConsumerState<ChatScreenWidget> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(selectedUserIdProvider);
    final userList = ref.watch(userNotifierProvider).valueOrNull ?? [];

    // If no user selected, show empty
    if (selectedId == null) return const Center(child: Text("Select a User"));

    final user = userList.where((u) => u.id == selectedId).firstOrNull;
    if (user == null) return const SizedBox();

    // Watch messages from Firestore
    final messagesAsync = ref.watch(
      chatMessagesProvider(selectedId.toString()),
    );

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // --- HEADER ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chat with ${user.firstName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "Admin Mode",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // Switch back to Vitals view
                    ref
                        .read(userDetailViewModeProvider.notifier)
                        .set(UserDetailView.vitals);
                  },
                ),
              ],
            ),
          ),

          // --- MESSAGE LIST ---
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("Error: $e")),
              data: (snapshots) {
                if (snapshots.isEmpty) {
                  return const Center(child: Text("No messages yet. Say Hi!"));
                }

                // Mark messages as read since we are viewing them
                // We use a post-frame callback to avoid build-cycle errors
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(syncServiceProvider)
                      .markMessagesAsRead(selectedId.toString());
                });

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true, // Show newest at bottom
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshots.length,
                  itemBuilder: (context, index) {
                    final doc = snapshots[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final isMe = data['sender'] == 'admin';
                    final text = data['text'] ?? '';
                    // Timestamp handling (it might be null briefly on local write)
                    final ts = data['timestamp'];
                    final timeStr = ts != null
                        ? DateFormat('hh:mm a').format((ts as dynamic).toDate())
                        : "...";

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        constraints: const BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[600] : Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isMe
                                ? const Radius.circular(12)
                                : Radius.zero,
                            bottomRight: isMe
                                ? Radius.zero
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              timeStr,
                              style: TextStyle(
                                fontSize: 10,
                                color: isMe ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // --- INPUT AREA ---
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(selectedId.toString()),
                  ),
                ),
                const Gap(8),
                IconButton.filled(
                  onPressed: () => _sendMessage(selectedId.toString()),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String userId) {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    ref.read(syncServiceProvider).sendAdminMessage(userId, text);
    _msgController.clear();
  }
}
