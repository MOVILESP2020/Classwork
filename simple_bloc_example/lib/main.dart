import 'package:flutter/material.dart';
import 'package:login_bloc/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isTextHidden = true;
  TextEditingController _passwordTextController;
  TextEditingController _usernameTextController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // username tf
                TextFormField(
                  controller: _usernameTextController,
                  decoration: InputDecoration(
                    hintText: "Usuario",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Ingrese usuario";
                    else
                      return null;
                  },
                ),
                // password tf
                TextFormField(
                  controller: _passwordTextController,
                  obscureText: _isTextHidden,
                  decoration: InputDecoration(
                    hintText: "Contrasena",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isTextHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isTextHidden = !_isTextHidden;
                        });
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Ingrese contrasena";
                    else
                      return null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  child: Text("Ingresar"),
                  color: Colors.cyan,
                  onPressed: _openHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openHome() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
      );
    } else
      return Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Rellenar formulario"),
        ),
      );
  }
}
// flutter pub run build_runner watch
// flutter pub run build_runner build
