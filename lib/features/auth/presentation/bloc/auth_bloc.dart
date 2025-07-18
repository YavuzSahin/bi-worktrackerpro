import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/user.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class AuthLogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final String token;

  const AuthAuthenticated({
    required this.user,
    required this.token,
  });

  @override
  List<Object> get props => [user, token];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  final StorageService storageService;

  AuthBloc({
    required this.apiService,
    required this.storageService,
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final token = await storageService.getToken();
      final user = await storageService.getUser();
      
      if (token != null && user != null) {
        // Verify token is still valid by checking work status
        try {
          await apiService.getWorkStatus(token);
          emit(AuthAuthenticated(user: user, token: token));
        } catch (e) {
          // Token is invalid, clear storage
          await storageService.clearAuthData();
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final loginRequest = LoginRequest(
        username: event.username,
        password: event.password,
      );
      
      final response = await apiService.login(loginRequest);
      
      await storageService.saveAuthData(response.token, response.user);
      
      emit(AuthAuthenticated(
        user: response.user,
        token: response.token,
      ));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final token = await storageService.getToken();
      if (token != null) {
        await apiService.logout(token);
      }
    } catch (e) {
      // Ignore logout API errors
    } finally {
      await storageService.clearAuthData();
      emit(AuthUnauthenticated());
    }
  }
}