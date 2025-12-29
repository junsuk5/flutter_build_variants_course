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

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, profileImageUrl: $profileImageUrl)';
  }
}
