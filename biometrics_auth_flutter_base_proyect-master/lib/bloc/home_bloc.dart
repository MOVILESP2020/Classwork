import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {

    if(event is DoneEvent) {
        yield HomeInitial();
    } else if(event is AuthenticationEvent) {
        if(! await _checkBiometrics()) {
            yield AuthenticationFailure(message: "No se encuentran sensores métricos");
        }
        if (await _authenticate()) {
          yield AuthenticationDone();
        } else {
          yield AuthenticationFailure(message: "Usuario desconocido");
        }
    } else if(event is LoadImageEvent) {
        yield LoadedImage(image : await _pickImage());
    } else if (event is LaunchUrlEvent) {
        try {
          await _launchURL(event.props[0]);
          yield UrlLaunched();
        } catch(e) {
          print(e);
          yield UrlLaunchError(message: 'No se pudo abrir la URL');
        }
    }
  } 
    
  
  Future<File> _pickImage() async {
    //recordar permiso en el manifest
    final File choosenImg = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85
    );
    return choosenImg;
  }

  Future<bool> _checkBiometrics() async {
    try {
        return await _localAuthentication.canCheckBiometrics;
    } catch(e) {
        print(e);
        return false;
    }
  }

    Future<bool> _authenticate() async {
    try {
        return await _localAuthentication.authenticateWithBiometrics(
          localizedReason: "Ponga la huella",
          stickyAuth: true,
          useErrorDialogs: true,
          );
    } catch(e) {
        print(e);
        return false;
    }
  }

  
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
