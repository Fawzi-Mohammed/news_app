part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.errorMessage,
    this.user,
    this.status = RequestStatusEnum.initial,
  });

  final String? errorMessage;
  final UserModel? user;
  final RequestStatusEnum status;

  @override
  List<Object?> get props => [errorMessage, user, status];
  AuthState copyWith({
    String? errorMessage,
    UserModel? user,
    RequestStatusEnum? status,
  }) {
    return AuthState(
      errorMessage: errorMessage,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
