import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in_repository.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signInRepository) : super(SignInInitial());

  final SignInRepository _signInRepository;

  Future<void> signIn(String email, String password) async {
    emit(SignInProgress());
    final token = await _signInRepository.signIn(email, password);
    if (token == null) {
      emit(EmptyTokenState());
    } else {
      final success = await _signInRepository.saveToken(token);
      if (success) {
        emit(SignInSuccess(token));
      } else {
        emit(SignInFailure('Failed to save the token.'));
      }
    }
  }
}
