import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String? name;
  String? photo;
  String? mail;

  UserData({
    required this.name,
    required this.photo,
    required this.mail,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['photo'] = photo;
    data['mail'] = mail;

    return data;
  }

  static fromFirebase(User? user) {
    return user != null
        ? UserData(
            name: user.displayName ?? "",
            photo: user.photoURL ?? "",
            mail: user.email ?? "",
          )
        : [];
  }
}
