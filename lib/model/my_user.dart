class MyUser {
  static const String collectionName = "users";

  String? id;
  String? firstName;
  String? email;

  MyUser({this.id, this.email, this.firstName});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data["id"],
          firstName: data["fullName"],
          email: data["email"],
        );

  Map<String, dynamic> toFireStore() {
    return {"id": id, "fullName": firstName, "email": email};
  }
}
