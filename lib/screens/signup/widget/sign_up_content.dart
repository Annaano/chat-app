import 'package:chat_app/core/const/color_consts.dart';
import 'package:chat_app/core/const/text_consts.dart';
import 'package:chat_app/core/const/photo_consts.dart';
import 'package:chat_app/core/services/validation_services.dart';
import 'package:chat_app/screens/signup/sign_up_cubit.dart';
import 'package:chat_app/widgets/buttons.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConsts.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              _getMainData(context),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpLoadingState) {
                    if (state.isShow) {
                      return _getLoading();
                    }
                  } else if (state is SignUpNextMainScreenState ||
                      state is SignUpErrorMessageState) {
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMainData(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _getTitle(),
            const SizedBox(height: 20),
            _getForm(context),
            const SizedBox(height: 40),
            _getSignUpButton(context),
            const SizedBox(height: 40),
            _getHaveAccountText(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  Widget _getTitle() {
    return Column(children: [
      SizedBox(width: 56, height: 56, child: Image.asset(PathConsts.user)),
      const SizedBox(
        height: 16,
      ),
      const Text(
        TextConsts.signUpTitle,
        style: TextStyle(
          color: ColorConsts.textBlack,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }

  Widget _getForm(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (_, currState) => currState is SignUpShowErrorState,
      builder: (context, state) {
        return Column(
          children: [
            Form(
              key: _formKey,
              child: AppTextField(
                title: TextConsts.username,
                placeholder: TextConsts.userNamePlaceholder,
                controller: cubit.userNameController,
                textInputAction: TextInputAction.next,
                errorText: TextConsts.usernameErrorText,
                isError: state is SignUpShowErrorState
                    ? !ValidationService.isUsernameValid(
                        cubit.userNameController.text)
                    : false,
                onTextChanged: () {
                  cubit.onTextChanged();
                },
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConsts.email,
              placeholder: TextConsts.emailPlaceholder,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: cubit.emailController,
              errorText: TextConsts.emailErrorText,
              isError: state is SignUpShowErrorState
                  ? !ValidationService.isEmailValid(cubit.emailController.text)
                  : false,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConsts.password,
              placeholder: TextConsts.passwordPlaceholder,
              obscureText: true,
              isError: state is SignUpShowErrorState
                  ? !ValidationService.isPasswordValid(
                      cubit.passwordController.text)
                  : false,
              textInputAction: TextInputAction.next,
              controller: cubit.passwordController,
              errorText: TextConsts.passwordErrorText,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              title: TextConsts.confirmPassword,
              placeholder: TextConsts.confirmPasswordPlaceholder,
              obscureText: true,
              isError: state is SignUpShowErrorState
                  ? !ValidationService.isConfirmPasswordValid(
                      cubit.passwordController.text,
                      cubit.confirmPasswordController.text)
                  : false,
              controller: cubit.confirmPasswordController,
              errorText: TextConsts.confirmPasswordErrorText,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getSignUpButton(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Button(
            title: TextConsts.signUpTitle,
            isEnabled: state is SignUpButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                cubit.signUp();
              }
            },
          );
        },
      ),
    );
  }

  Widget _getHaveAccountText(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return RichText(
      text: TextSpan(
        text: TextConsts.alreadyHaveAccount,
        style: const TextStyle(
          color: ColorConsts.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: " ${TextConsts.login}",
            style: const TextStyle(
              color: ColorConsts.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                cubit.nextLoginScreen();
              },
          ),
        ],
      ),
    );
  }
}
