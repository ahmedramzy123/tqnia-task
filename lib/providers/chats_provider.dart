import 'package:tqnia_chat/models/chat_model.dart';
import 'package:tqnia_chat/models/message_model.dart';
import 'package:tqnia_chat/models/user_model.dart';
import 'package:tqnia_chat/utils/auth_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ChatsProvider extends ChangeNotifier {
  final AuthClient _auth = AuthClient.instance;
  List<ChatModel>? chats;
  ChatModel? chat;
  List<UserModel>? users;

  Future<void> getChatOrCreate(UserModel otherUser) async {
    chat = null;
    notifyListeners();
    chat = await _auth.getChatOrCreate(otherUser);
    chats ??= [];
    chat?.messages ??= [];
    if (!(chats?.contains(chat) ?? false)) {
      chats?.add(chat ?? ChatModel());
    }
    notifyListeners();
  }

  Future<void> getUsers() async {
    users = await _auth.getUsers();
    final FirebaseAuth auth = FirebaseAuth.instance;
    users?.removeWhere((user) => user.id == auth.currentUser?.uid);
    notifyListeners();
  }

  Future<void> getChats() async {
    chats = null;
    notifyListeners();
    chats = await _auth.getChats();
    for (ChatModel chat in chats ?? []) {
      chat.messages = await getChatMessages(chat.id ?? '');
    }
    notifyListeners();
  }

  Future<List<MessageModel>> getChatMessages(String chatId) async {
    return await _auth.getChatMessages(chatId);
  }
}
