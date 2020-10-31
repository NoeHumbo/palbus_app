import 'package:flutter/material.dart';
import 'package:palbus_app/app.dart';

class RegistroUser extends StatefulWidget {
  @override
  _RegistroUserState createState() {
    return _RegistroUserState();
  }
}

class _RegistroUserState extends State<RegistroUser> {
  String nameValue;
  String lastnameValue;
  String passwordone;
  String passworstwo;

  RegExp emailregexp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/logo.png',
                height: 200,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/sombra.png'),
                    fit: BoxFit.none,
                    scale: 1.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
              child: Column(
                children: [
                  Text(
                    'Registro de Usuario',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nombres"),
                    onSaved: (value) {
                      nameValue = value;
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return "Completar nombre";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "e-mail"),
                    onSaved: (value) {
                      lastnameValue = value;
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return "Completar e-mail";
                      } else if (!emailregexp.hasMatch(value)) {
                        return "Ingrese un correo vàlido!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Escriba una contraseña',
                    ),
                    onSaved: (value) {
                      passwordone = value;
                    },
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Completar contraseña';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Vuelva a escribir la contraseña"),
                    onSaved: (value) {
                      passworstwo = value;
                    },
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return "Completar contraseña";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: RaisedButton(
                child: Text('Registrar',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    )),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();

                    /*setState(() {
                            _logueado = true;
                          });*/
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return App();
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
