abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInProgress extends SignInState {}

class SignInSuccess extends SignInState {
  final String token;

  SignInSuccess(this.token);
}

class SignInFailure extends SignInState {
  final String message;

  SignInFailure(this.message);
}

class EmptyTokenState extends SignInState {}
