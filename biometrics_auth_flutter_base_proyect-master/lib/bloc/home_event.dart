part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadImageEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class AuthenticationEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class DoneEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class LaunchUrlEvent extends HomeEvent {
  final String url;
  LaunchUrlEvent({@required this.url});
    @override
  List<Object> get props => [url];
}
