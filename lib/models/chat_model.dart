import 'package:tqnia_chat/models/message_model.dart';
import 'package:tqnia_chat/models/user_model.dart';
import 'package:tqnia_chat/utils/vars.dart';

class ChatModel {
  String? id;
  List<String?>? userIDS;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<UserModel>? users;
  List<MessageModel>? messages;

  ChatModel({
    this.id,
    this.userIDS,
    this.createdAt,
    this.users,
    this.updatedAt,
    this.messages,
  });

  ChatModel.fromMap(Map<String, dynamic> m) {
    id = m[ChatVars.id];
    if (m[ChatVars.userIDS] != null) {
      userIDS = [];
      m[ChatVars.userIDS].forEach((userID) => userIDS?.add(userID));
    }
    createdAt = DateTime.parse(m[ChatVars.createdAt].toDate().toString());
    users = m[ChatVars.users];
    updatedAt = DateTime.parse(m[ChatVars.updatedAt].toDate().toString());
    if (m[ChatVars.messages] != null) {
      messages = [];
      m[ChatVars.messages].forEach((message) => messages?.add(message));
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
