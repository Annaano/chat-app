import 'package:chat_app/core/const/color_consts.dart';
import 'package:chat_app/core/const/text_consts.dart';

import 'package:chat_app/core/services/validation_services.dart';
import 'package:chat_app/screens/signup/sign_up_cubit.dart';
import 'package:chat_app/screens/main_screen.dart';
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
            _getTitle(),
            const SizedBox(height: 10),
            _getForm(context),
            const SizedBox(height: 40),
            _getSignUpButton(context),
            const SizedBox(height: 25),
            _getHaveAccountText(context),
            const SizedBox(height: 10),
            _goBack(context),
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
      Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset('assets/images/signup.jpg')),
      ),
      const Text(
        TextConsts.signUpTitle,
        style: TextStyle(
          color: ColorConsts.mainColor,
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
                hintText: TextConsts.username,
                labelText: TextConsts.userNameLabelText,
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
              hintText: TextConsts.email,
              labelText: TextConsts.emailLabelText,
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
              hintText: TextConsts.password,
              labelText: TextConsts.passwordLabelText,
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
              hintText: TextConsts.confirmPassword,
              labelText: TextConsts.confirmPasswordLabelText,
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
            title: TextConsts.continueButton,
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
        text: TextConsts.joined,
        style: const TextStyle(
          color: ColorConsts.textBlack,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: " ${TextConsts.loginFromSignUp}",
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

  Widget _goBack(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConsts.returnBack,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(MainScreen.routeName);
            },
        ),
      ),
    );
  }
}
