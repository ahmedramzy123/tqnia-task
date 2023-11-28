import 'package:tqnia_chat/utils/cache_helper.dart';
import 'package:tqnia_chat/utils/vars.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? countryCode;
  String? imageUrl;
  String? token;
  String? imagePath;
  bool? online;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.countryCode,
      this.token,
      this.imageUrl,
      this.imagePath});

  UserModel.fromMap(Map<String, dynamic> m) {
    id = m[UserVars.id];
    email = m[UserVars.email];
    name = m[UserVars.name] ?? m['firstName'];
    phone = m[UserVars.phone];
    token = "token";
    countryCode = m[UserVars.countryCode];
    imageUrl = m[UserVars.imageURL];
    imagePath = m[UserVars.imagePath];
    online = m[UserVars.online];
  }

  Map<String, dynamic> toMap() {
    return {
      UserVars.email: email,
      UserVars.name: name,
      UserVars.phone: phone,
      "token":CacheHelper.getDataString(key: "token"),
      UserVars.countryCode: countryCode,
      UserVars.imageURL: imageUrl ?? '',
      UserVars.imagePath: imagePath ?? '',
      UserVars.online: online ?? false,
    };
  }
}
