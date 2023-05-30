import 'package:get_it/get_it.dart';
import 'package:chat_app/screens/signup/sign_up_cubit.dart';
import 'package:chat_app/screens/login/login_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SignUpCubit());
  sl.registerFactory(() => LoginCubit());
  // sl.registerFactory(() => ResetPasswordCubit());
}
