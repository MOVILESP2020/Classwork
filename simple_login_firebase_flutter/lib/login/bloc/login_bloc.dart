import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:load_data_bloc/auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthProvider _auth = AuthProvider();
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async * {

    if (event is VerifyLoggedUser) {
        try {
            if (await _auth.userAlreadyLogged()) {
              yield LoginSucced();
            } else {
              yield LoginInitial();
            }
        } catch(e) {
          print(e);
          yield LoginError();
        }
    } else if (event is LoginWithGoogle) {
        try {
            await _auth.signInWithGoogle();
            yield LoginSucced();

        } catch(e) {
          print(e);
          yield LoginError();
        }
    } else if(event is LogOut) {
        try {
            await _auth.logout();
            yield LoginInitial();

        } catch(e) {
          print(e);
          yield LoginError();
        }
    }
  }
}
