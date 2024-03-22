class Session {
  final String token;
  final int expiresIn;
  final DateTime createAt;

  Session({
    required this.token,
    required this.expiresIn,
    required this.createAt,
  });

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'],
      expiresIn: json['expiresIn'],
      createAt: DateTime.parse(json['createAt'],)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token' : token,
      'expiresIn' : expiresIn,
      'createAt' : createAt.toIso8601String(),
    };
  }
}
