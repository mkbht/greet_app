class Profile {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;

  const Profile(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.dateOfBirth});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
    );
  }
}
