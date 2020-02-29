import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:login_bloc/user/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnRequestUsersList) {
      try {
        List<User> _userList = await _requestUsersData();
        yield OnSuccessDataReceived(userList: _userList);
      } on RequestError catch (error) {
        yield OnErrorReceived("Request error: $error");
      } on UnknownError catch (error) {
        yield OnErrorReceived("Unknown error: $error");
      }
    }
  }

  Future<List<User>> _requestUsersData() async {
    final _url = "https://jsonplaceholder.typicode.com/users";
    var _response = await http.get(_url);
    if (_response.statusCode == 200) {
      List<dynamic> _result = jsonDecode(_response.body);
      List<User> _users = _result.map((user) => User.fromJson(user)).toList();
      return _users;
    } else {
      throw RequestError("Incorrect reponse");
    }
  }
}

class RequestError implements Exception {
  final error;
  RequestError(this.error);
}

class UnknownError implements Exception {
  final error;
  UnknownError(this.error);
}
