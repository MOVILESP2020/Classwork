part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class OnSuccessDataReceived extends HomeState {
  final List<User> userList;

  OnSuccessDataReceived({@required this.userList});
  @override
  List<Object> get props => [userList];
}

class OnErrorReceived extends HomeState {
  final String error;

  OnErrorReceived(this.error);
  @override
  List<Object> get props => [error];
}
