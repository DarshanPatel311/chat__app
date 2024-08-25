class UserModel {
  String? name, phone, email, photoUrl,userToken;

  UserModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.photoUrl,required this.userToken});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      name: m1['name'],
      phone: m1['phone'],
      email: m1['email'],
      photoUrl: m1['photoUrl'],
      userToken: m1['userToken'],
    );
  }

  Map<String, String> toMap(UserModel user) {
    return {
      'name': user.name!,
      'email': user.email!,
      'photoUrl': user.photoUrl!,
      'phone':user.phone!,
      'userToken' : user.userToken!,
    };
  }
}
