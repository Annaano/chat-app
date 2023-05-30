import 'package:chat_app/core/const/color_consts.dart';
import 'package:chat_app/core/const/text_consts.dart';
import 'package:chat_app/core/services/validation_services.dart';
import 'package:chat_app/screens/login/login_cubit.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/widgets/buttons.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConsts.white,
        child: Stack(
          children: [
            _getMainData(context),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return _getLoading();
                } else if (state is LoginErrorState ||
                    state is LoginNextMainScreenState) {
                  return const SizedBox();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMainData(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getHeader(),
              _getForm(context),
              const SizedBox(height: 20),
              _getForgotPasswordButton(context),
              const SizedBox(height: 25),
              _getLoginButton(context),
              const SizedBox(height: 40),
              _getDoNotHaveAccountText(context),
              const SizedBox(height: 10),
              _goBack(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoading() {
    return const AppLoading();
  }

  Widget _getHeader() {
    return Column(
      children: [
        SizedBox(
            width: 350,
            height: 350,
            child: Image.asset('assets/images/login.png')),
        Center(
          child: Text(
            TextConsts.loginFromSignUp,
            style: const TextStyle(
              color: ColorConsts.mainColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getForm(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              hintText: TextConsts.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              labelText: TextConsts.emailLoginLabelText,
              controller: cubit.emailController,
              errorText: TextConsts.emailErrorText,
              isError: state is LoginShowErrorState
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
              controller: cubit.passwordController,
              errorText: TextConsts.passwordErrorText,
              isError: state is LoginShowErrorState
                  ? !ValidationService.isPasswordValid(
                      cubit.passwordController.text)
                  : false,
              obscureText: true,
              onTextChanged: () {
                cubit.onTextChanged();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getForgotPasswordButton(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(right: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              TextConsts.forgotPassword,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConsts.mainColor,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        cubit.resetPassword();
      },
    );
  }

  Widget _getLoginButton(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Button(
            title: TextConsts.signInTitle,
            isEnabled: state is LoginButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              cubit.login();
            },
          );
        },
      ),
    );
  }

  Widget _getDoNotHaveAccountText(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConsts.doNotHaveAnAccount,
          style: const TextStyle(
            color: ColorConsts.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: " ${TextConsts.doNotHaveAnAccountSignUp}",
              style: const TextStyle(
                color: ColorConsts.mainColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  cubit.nextRegistrationScreen();
                },
            ),
          ],
        ),
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
