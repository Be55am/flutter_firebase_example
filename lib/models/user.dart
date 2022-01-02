class User {
  final String uid;
  final String? email;

  User({required this.uid, this.email});

  @override
  String toString() {
    return 'User{uid: $uid, email: $email}';
  }
}
