import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_providers.g.dart';

// 1. Get All Messages for a Specific User (For the Chat Screen)
@riverpod
Stream<List<QueryDocumentSnapshot>> chatMessages(
  ChatMessagesRef ref,
  String studentId,
) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(studentId)
      .collection('messages')
      .orderBy(
        'timestamp',
        descending: true,
      ) // Newest at bottom (or top depending on UI)
      .snapshots()
      .map((snapshot) => snapshot.docs);
}

// 2. Get Unread Count (For the Red Dot Badge in User List)
@riverpod
Stream<int> unreadMessageCount(UnreadMessageCountRef ref, String studentId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(studentId)
      .collection('messages')
      .where('sender', isEqualTo: 'student') // Only count messages FROM student
      .where('isRead', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}
