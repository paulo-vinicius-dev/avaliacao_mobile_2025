class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImagePath,
  });

  final String id;
  String name;
  String email;
  String? profileImagePath;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImagePath: map['profileImagePath'],
    );
  }
}
