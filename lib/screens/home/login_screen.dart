import 'package:flutter/material.dart';
import 'package:palbus_app/screens/home/auth_passenger.dart';
import 'dart:convert' as json;

import 'package:palbus_app/screens/home/login_requester.dart';

// class AnimatedLogo extends AnimatedWidget {
//   // Maneja los Tween estáticos debido a que estos no cambian.
//   static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
//   static final _sizeTween = Tween<double>(begin: 0.0, end: 150.0);

//   AnimatedLogo({Key key, Animation<double> animation})
//       : super(key: key, listenable: animation);

//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     return Opacity(
//       opacity: _opacityTween.evaluate(animation),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         height: _sizeTween.evaluate(animation), // Aumenta la altura
//         width: _sizeTween.evaluate(animation), // Aumenta el ancho
//         child: FlutterLogo(),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool _failedLogin = false; //visibility
  bool _isLoading = false;

  bool _isFullE = false;
  bool _isFullP = false;

  bool _passwordIsObscured = true;
  Color _eyeButtonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                child: Form(
                  key: _loginFormKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
                    child: Column(
                      children: <Widget>[
                        formSeparator(),
                        Image.asset(
                          'assets/images/logo-1.png',
                          height: 240,
                          width: 230,
                        ),
                        Visibility(
                          visible: _failedLogin,
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Center(
                              child: Text(
                                'Datos de Acceso Incorrectos',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        formSeparator(),
                        buildEmailField(),
                        formSeparator(),
                        buildPasswordField(context),
                        formSeparator(),
                        SizedBox(
                          width: double.infinity,
                          child: buildLoginButton(context),
                        ),
                        formSeparator(),
                        SizedBox(
                          width: double.infinity,
                          child: buildSignupButton(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Debe ingresar un email válido';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullE = true);
        } else if (value == "") {
          setState(() => _isFullE = false);
        }
      },
    );
  }

  TextFormField buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      validator: (passwordInput) {
        return passwordInput.isEmpty ? 'Debe ingresar su contraseña' : null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Contraseña',
        // labelStyle: InputTheme.labelTextStyle,
        suffixIcon: IconButton(
          onPressed: () {
            if (_passwordIsObscured) {
              setState(() {
                _passwordIsObscured = false;
                _eyeButtonColor = Theme.of(context).primaryColor;
              });
            } else {
              setState(() {
                _passwordIsObscured = true;
                _eyeButtonColor = Colors.grey;
              });
            }
          },
          icon: Icon(Icons.remove_red_eye, color: _eyeButtonColor),
        ),
      ),
      style: TextStyle(fontSize: 14),
      obscureText: _passwordIsObscured,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullP = true);
        } else if (value == "") {
          setState(() => _isFullP = false);
        }
      },
    );
  }

  FlatButton buildLoginButton(BuildContext context) {
    return FlatButton(
      color: _isFullE && _isFullP ? Colors.blue : Colors.grey[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Ingresar',
      ),
      onPressed: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        setState(() => this._failedLogin = false);
        if (_loginFormKey.currentState.validate()) {
          authenticatePassenger(context);
        }
      },
    );
  }

  FlatButton buildSignupButton(BuildContext context) {
    return FlatButton(
      splashColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).pushNamed('/signin');
      },
      child: Container(
        child: Column(
          children: [
            Text(
              "Crea una cuenta ahora",
              style: TextStyle(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox formSeparator() => SizedBox(height: 30);

  void authenticatePassenger(BuildContext context) async {
    var response = await LoginRequester.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    var responseJSON = json.jsonDecode(response.body);
    // final clientStore = context.read<ClientStore>();

    if (response.statusCode == 200) {
      AuthPassenger.logIn(
        context,
        responseJSON['token'],
        json.jsonDecode(responseJSON['passenger'])['name'],
      );
    } else if (response.statusCode == 401) {
      setState(() {
        this._failedLogin = true;
      });
      this._passwordController.clear();
    }
  }
}
