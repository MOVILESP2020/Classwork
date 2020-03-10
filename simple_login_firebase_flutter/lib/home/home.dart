import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocListener<HomeBloc, HomeState>(listener: (context, state) {
        if (state is ErrorState) {
          print("Error: ${state.error}");
        }
      }, child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            BlocProvider.of<HomeBloc>(context).add(OnDataRequest());
          }
          if (state is SuccessState) {
            return Scaffold(
              body: ListView.builder(
                itemCount: state.usersList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("${state.usersList[index].name}"),
                    subtitle: Text("${state.usersList[index].website}"),
                  );
                },
              ),
            );
          }
          return Scaffold(body: CircularProgressIndicator());
        },
      )),
    );
  }
}
