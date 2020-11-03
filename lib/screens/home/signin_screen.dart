import 'dart:convert' as json;

import 'package:flutter/material.dart';
import 'package:palbus_app/database/auth_requester.dart';
import 'package:palbus_app/services/auth_passenger.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  final _signinFormKey = GlobalKey<FormState>();

  final _nameController = new TextEditingController();
  final _dniController = new TextEditingController();
  final _mobileNumberController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _passwordConfirmationController = new TextEditingController();

  bool _failedLogin = false;

  bool _passwordIsObscured = true;
  Color _eyeButtonColor = Colors.grey;
  bool _passwordConfIsObscured = true;
  Color _eyeButtonColorC = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black),
      // ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            child: Form(
              key: _signinFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo-1.png',
                      height: 230,
                      width: 230,
                    ),
                    Visibility(
                      visible: _failedLogin,
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            'Completar todos los campos',
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
                    buildNameField(),
                    formSeparator(),
                    buildDNIField(),
                    formSeparator(),
                    buildMobileNumberField(),
                    formSeparator(),
                    buildEmailField(),
                    formSeparator(),
                    buildPasswordField(context),
                    formSeparator(),
                    buildPasswordConfirmationField(context),
                    formSeparator(),
                    SizedBox(
                      width: double.infinity,
                      child: buildSigninButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox formSeparator() => SizedBox(height: 20);

  TextFormField buildNameField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) => value.isEmpty ? 'Debe ingresar su nombre' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Nombre',
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 14),
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
    );
  }

  TextFormField buildDNIField() {
    return TextFormField(
      controller: _dniController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar el número de su DNI';
        } else if (value.length != 8) {
          return 'DNI contiene 8 dígitos';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'DNI',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
    );
  }

  TextFormField buildMobileNumberField() {
    return TextFormField(
      controller: _mobileNumberController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar un número de celular';
        } else if (value.length != 9) {
          return 'Celular contiene 9 dígitos';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Celular',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
    );
  }

  TextFormField buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        return value.isEmpty ? 'Debe ingresar su contraseña' : null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Contraseña',
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
    );
  }

  TextFormField buildPasswordConfirmationField(BuildContext context) {
    return TextFormField(
      controller: _passwordConfirmationController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Debe ingresar su contraseña';
        } else if (value != _passwordController.text.trim()) {
          return 'Las contraseñas deben ser iguales';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Repetir contraseña',
        // labelStyle: InputTheme.labelTextStyle,
        suffixIcon: IconButton(
          onPressed: () {
            if (_passwordConfIsObscured) {
              setState(() {
                _passwordConfIsObscured = false;
                _eyeButtonColorC = Theme.of(context).primaryColor;
              });
            } else {
              setState(() {
                _passwordConfIsObscured = true;
                _eyeButtonColorC = Colors.grey;
              });
            }
          },
          icon: Icon(Icons.remove_red_eye, color: _eyeButtonColorC),
        ),
      ),
      style: TextStyle(fontSize: 14),
      obscureText: _passwordConfIsObscured,
    );
  }

  FlatButton buildSigninButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Registrarse',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        setState(() => this._failedLogin = false);
        if (_signinFormKey.currentState.validate()) {
          signInPassenger(context);
        }
      },
    );
  }

  signInPassenger(BuildContext context) async {
    var response = await AuthRequester.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      dni: _dniController.text.trim(),
      mobileNumber: _mobileNumberController.text.trim(),
      password: _passwordController.text.trim(),
      passwordConfirmation: _passwordConfirmationController.text.trim(),
    );
    if (response.statusCode == 201) {
      loginPassenger();
    } else {
      setState(() => this._failedLogin = true);
      this._passwordController.clear();
      this._passwordConfirmationController.clear();
    }
  }

  loginPassenger() async {
    var response = await AuthRequester.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    var responseJSON = json.jsonDecode(response.body);
    if (response.statusCode == 200) {
      AuthPassenger.logIn(
        context,
        responseJSON['token'],
        json.jsonDecode(responseJSON['passenger'])['name'],
      );
    }
  }
}
