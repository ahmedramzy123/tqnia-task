import 'package:tqnia_chat/models/chat_model.dart';
import 'package:tqnia_chat/models/message_model.dart';
import 'package:tqnia_chat/models/user_model.dart';
import 'package:tqnia_chat/utils/auth_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  ChatModel chat;
  ChatProvider(this.chat);

  final AuthClient _auth = AuthClient.instance;

  Future<void> sendMessage(MessageModel message, UserModel otherUser) async {
    chat.messages?.add(message);
    notifyListeners();
    await _auth.sendMessage(message, otherUser, chat.id ?? '');
  }

  Stream<QuerySnapshot> getMessages() {
    return _auth.getMessages(chat.id ?? '');
  }
}
