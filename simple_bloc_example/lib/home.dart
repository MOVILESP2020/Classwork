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
      create: (context) {
        return HomeBloc();
      },
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is OnErrorReceived) {
            // scaffold
            // Scaffold.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text("${state.error}"),
            //   ),
            // );
            print("${state.error}");
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              BlocProvider.of<HomeBloc>(context).add(OnRequestUsersList());
            }
            if (state is OnSuccessDataReceived) {
              return Scaffold(
                body: ListView.builder(
                  itemCount: state.userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("${state.userList[index].name}"),
                      subtitle: Text("${state.userList[index].website}"),
                    );
                  },
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
