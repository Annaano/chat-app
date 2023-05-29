part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class SignUpButtonEnableChangedState extends SignUpState {
  final bool isEnabled;

  SignUpButtonEnableChangedState({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpShowErrorState extends SignUpState {
  @override
  List<Object?> get props => throw [identityHashCode(this)];
}

class SignUpErrorMessageState extends SignUpState {
  final String message;

  SignUpErrorMessageState({required this.message});

  @override
  List<Object?> get props => [identityHashCode(message)];
}

class SignUpNextMainScreenState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpNextLoginPageState extends SignUpState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class SignUpLoadingState extends SignUpState {
  final bool isShow;

  SignUpLoadingState(this.isShow);

  @override
  List<Object?> get props => [identityHashCode(isShow)];
}
