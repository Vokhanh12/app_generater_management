import 'dart:async';

import 'package:app_generator_management/core/enum/enums.dart';
import 'package:app_generator_management/repositories/auth_repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/custom_error.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInState.initial()) {
    on<SignInWithCredential>(_mapSignInWithCredentialToState);
  }

  FutureOr<void> _mapSignInWithCredentialToState(
      SignInWithCredential event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: SignInStatus.submitting));

    try {
      await authRepository
          .logInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((value) {
        if (value) {
          emit(state.copyWith(status: SignInStatus.success));
        } else {
          emit(state.copyWith(status: SignInStatus.error, error: CustomError(message: "Đăng nhập thất bại")));
        }


      });
    } catch (e) {
      emit(state.copyWith(
          status: SignInStatus.error,
          error: CustomError(message: e.toString())));
    }
  }
}
