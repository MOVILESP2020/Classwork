import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:load_data_bloc/user/user.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnDataRequest) {
      try {
        List<User> _users = await _requestData();
        yield SuccessState(usersList: _users);
      } on RequestError catch (err) {
        yield ErrorState(error: "${err.error}");
      } on UnknownError catch (err) {
        yield ErrorState(error: "${err.error}");
      }
    }
  }

  Future<List<User>> _requestData() async {
    final _url = "https://jsonplaceholder.typicode.com/usrs";
    var _response = await http.get(_url);
    if (_response.statusCode == 200) {
      List<dynamic> _result = jsonDecode(_response.body);
      List<User> _users = _result.map((usr) => User.fromJson(usr)).toList();
      return _users;
    } else {
      throw RequestError(">>> Request error: ");
    }
  }
}

class RequestError implements Exception {
  final String error;

  RequestError(this.error);
}

class UnknownError implements Exception {
  final String error;

  UnknownError(this.error);
}
