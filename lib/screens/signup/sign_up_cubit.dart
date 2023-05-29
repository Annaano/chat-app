import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/validation_services.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  void signUp() async {
    if (checkValidatorsOfTextField()) {
      emit(SignUpLoadingState(true));
      try {
        await AuthService.registration(emailController.text,
            passwordController.text, userNameController.text);
        emit(SignUpLoadingState(false));
        emit(SignUpNextMainScreenState());
      } catch (e) {
        emit(SignUpErrorMessageState(message: e.toString()));
      }
    } else {
      emit(SignUpShowErrorState());
    }
  }

  void nextLoginScreen() {
    emit(SignUpNextLoginPageState());
  }

  void onTextChanged() {
    if (isButtonEnabled != checkIfButtonEnabled()) {
      isButtonEnabled = checkIfButtonEnabled();
      emit(SignUpButtonEnableChangedState(isEnabled: isButtonEnabled));
    }
  }

  bool checkIfButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.isUsernameValid(userNameController.text) &&
        ValidationService.isEmailValid(emailController.text) &&
        ValidationService.isPasswordValid(passwordController.text) &&
        ValidationService.isConfirmPasswordValid(
            passwordController.text, confirmPasswordController.text);
  }
}
