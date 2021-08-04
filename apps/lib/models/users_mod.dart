class TblUser {
  String typename;
  List<Users> users;

  TblUser({
    required this.typename,
    required this.users,
  });

  factory TblUser.fromJson(Map<String, dynamic> json) {
    return TblUser(
      typename: json["__typename"],
      users: List<Users>.from(json["tbl_users"].map((x) => Users.fromJson(x))),
    );
  }
}

class Users {
  String typename;
  String email;
  int id;
  String password;
  String username;

  Users({
    required this.typename,
    required this.email,
    required this.id,
    required this.password,
    required this.username,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        typename: json["__typename"],
        email: json["email"],
        id: json["id"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "email": email,
        "id": id,
        "password": password,
        "username": username,
      };
}
