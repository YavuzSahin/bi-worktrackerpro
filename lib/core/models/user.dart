import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String language;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.language,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool get isAdmin => role == 'admin';
  bool get isEmployee => role == 'employee';

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        language,
        role,
        isActive,
        createdAt,
      ];
}

@JsonSerializable()
class LoginRequest extends Equatable {
  final String username;
  final String password;

  const LoginRequest({
    required this.username,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [username, password];
}

@JsonSerializable()
class LoginResponse extends Equatable {
  final String token;
  final User user;
  final String message;

  const LoginResponse({
    required this.token,
    required this.user,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  List<Object?> get props => [token, user, message];
}