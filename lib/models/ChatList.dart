import 'package:intl/intl.dart';

class ChatList {
  final int? id;
  final String? username;
  final String? lastMessage;
  final String? seenAt;
  final String? sentAt;

  const ChatList(
      {this.id, this.username, this.lastMessage, this.seenAt, this.sentAt});

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
        id: json['id'],
        username: json['sender_obj']['username'],
        lastMessage: json['message'],
        seenAt: json['seen_at'],
        sentAt: json['created_at']);
  }

  @override
  String toString() {
    return username ?? "";
  }
}
