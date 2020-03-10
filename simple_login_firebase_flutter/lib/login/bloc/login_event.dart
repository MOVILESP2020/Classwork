part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithEmail extends LoginEvent {
  final String username;
  final String password;
  LoginWithEmail({@required this.username, @required this.password});
  
  @override
  List<Object> get props => null;

}

class LoginWithGoogle extends LoginEvent {
  final String username;
  final String password;
  LoginWithGoogle({@required this.username, @required this.password});
  
  @override
  List<Object> get props => null;
}

class LogOut extends LoginEvent {
  @override
  List<Object> get props => null;
}

class VerifyLoggedUser extends LoginEvent {
  @override
  List<Object> get props => null;
}