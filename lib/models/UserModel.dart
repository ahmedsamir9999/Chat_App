class UserModel {

  String? name;
  String? email;
  String? password;

  UserModel({
      this.name, 
      this.email, 
      this.password,});

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}