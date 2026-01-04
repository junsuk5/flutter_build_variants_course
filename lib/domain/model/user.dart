class User {
  final String id;
  final String email;
  final String name;
  final String profileImageUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, profileImageUrl: $profileImageUrl)';
  }
}
