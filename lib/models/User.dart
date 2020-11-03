class User {
  final String fullName;
  final String email;
  User({this.fullName, this.email});
  User.fromData(Map<String, dynamic> data)
      : fullName = data['fullName'],
        email = data['email'];
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
    };
  }
}
