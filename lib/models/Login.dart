class Login {
  final String type;
  final String token;

  const Login({
    required this.type,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      type: json['type'],
      token: json['token'],
    );
  }
}
