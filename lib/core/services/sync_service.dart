import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:english_words/english_words.dart';
import '../serial/serial_packet.dart';

class SyncService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Silent Admin Login
  // The desktop app logs in as 'admin' so it has permission to write data
  Future<void> loginAsAdmin() async {
    try {
      if (_auth.currentUser == null) {
        await _auth.signInWithEmailAndPassword(
          email: "admin@awear.system",
          password: "admin123", // Hardcoded for this specific clinic setup
        );
        print("SYNC: Admin Logged In");
      }
    } catch (e) {
      print("SYNC: Admin login failed: $e");
    }
  }

  // 2. Register Student in Cloud
  // Returns a generated password (e.g. "happy-lion")
  Future<String> registerUserInCloud(String studentId, String fullName) async {
    // Generate a friendly 2-word password
    final password = generateWordPairs().take(2).join('-').toLowerCase();

    // Create the document.
    // Note: We are NOT creating a Firebase Auth user for the student yet.
    // The student will use this 'generatedPassword' to authenticate against this document.
    await _db.collection('users').doc(studentId).set({
      'name': fullName,
      'generatedPassword': password,
      'role': 'student',
      'lastActive': FieldValue.serverTimestamp(),
      'isOnline': false,
    });

    return password;
  }

  // 3. Upload Vital (Throttled)
  // Call this only once per minute
  Future<void> uploadVital(String studentId, SerialPacket packet) async {
    try {
      await _db
          .collection('users')
          .doc(studentId)
          .collection('vitals')
          .doc('latest')
          .set({
            'hr': packet.heartRate,
            'oxy': packet.oxygen,
            'temp': packet.temperature,
            'stress': packet.stress,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print("SYNC: Upload failed: $e");
    }
  }

  // 4. Send Message (Admin -> Student)
  Future<void> sendAdminMessage(String studentId, String message) async {
    await _db.collection('users').doc(studentId).collection('messages').add({
      'sender': 'admin',
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false, // Mobile app will listen to this
    });
  }

  // 5. Mark Messages as Read (When Admin opens chat)
  Future<void> markMessagesAsRead(String studentId) async {
    final query = await _db
        .collection('users')
        .doc(studentId)
        .collection('messages')
        .where('sender', isEqualTo: 'student')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in query.docs) {
      doc.reference.update({'isRead': true});
    }
  }
}
