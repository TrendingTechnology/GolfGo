class User {
  final String imagePath;
  final String name;
  final String email;
  final String clubMembership;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.clubMembership,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? clubMembership,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        clubMembership: clubMembership ?? this.clubMembership,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        clubMembership: json['clubMembership']
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'clubMembership': clubMembership
      };
}
