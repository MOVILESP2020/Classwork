part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class SuccessState extends HomeState {
  final List<User> usersList;

  SuccessState({@required this.usersList});
  @override
  List<Object> get props => [usersList];
}

class ErrorState extends HomeState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
