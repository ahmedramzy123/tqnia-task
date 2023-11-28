import 'package:tqnia_chat/models/user_model.dart';
import 'package:tqnia_chat/utils/auth_client.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ChatUserProvider extends ChangeNotifier {
  UserModel user;
  ChatUserProvider(this.user);

  final AuthClient _auth = AuthClient.instance;

  Future<void> getUserById() async {
    user = await _auth.getUserById(user.id!);
    notifyListeners();
  }
}
