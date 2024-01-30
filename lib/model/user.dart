class User {
  final int? id;
  final String username;
  final String email;
  final String password;

  const User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  // Factory constructor to create a Booking object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return "{'id': $id, 'username': $username, 'email': $email, 'password': $password}";
  }
}
