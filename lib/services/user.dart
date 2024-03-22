class User {
  User({
    required this.data,
  });

  Data data;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmedpassword,
  });

  String name;
  String username;
  String email;
  String password;
  String confirmedpassword;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json["email"],
      name: json["name"],
      username: json["username"],
      password: json["password"],
      confirmedpassword: json["confirmedpassword"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "confirmedpassword": confirmedpassword,
      };
}
