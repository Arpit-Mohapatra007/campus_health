import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String text;
  final Timestamp timestamp;

  MessageModel({required this.senderId, required this.text, required this.timestamp});

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'senderId': senderId, 'text': text, 'timestamp': timestamp};
  }
}

class ChatRoomModel {
  final String id;
  final String studentId;
  final String studentName;
  final String doctorId;
  final String doctorName;
  final String lastMessage;
  final Timestamp lastMessageTime;

  ChatRoomModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.doctorId,
    required this.doctorName,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatRoomModel(
      id: id,
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? 'Unknown',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? 'Doctor',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'] ?? Timestamp.now(),
    );
  }
}