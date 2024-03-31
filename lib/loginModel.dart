class AuthResponse {
  final bool success;
  final AuthResult result;

  AuthResponse({
    required this.success,
    required this.result,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      result: AuthResult.fromJson(json['result']),
    );
  }
}

class AuthResult {
  final String token;
  final String type;
  final User user;

  AuthResult({
    required this.token,
    required this.type,
    required this.user,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      token: json['token'],
      type: json['type'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final String userType;
  final List<dynamic> features; // Change dynamic to actual type if known
  final List<dynamic> privileges; // Change dynamic to actual type if known

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.userType,
    required this.features,
    required this.privileges,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      userType: json['userType'],
      features: json['features'],
      privileges: json['privileges'],
    );
  }
}
