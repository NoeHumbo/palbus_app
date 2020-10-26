import 'package:flutter/material.dart';
import 'package:palbus_app/screens/home/home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   static Route<dynamic> route() {
//     return MaterialPageRoute(
//       builder: (context) => LoginScreen(),
//     );
//   }

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> animation;

//   GlobalKey<FormState> _key = GlobalKey();

//   RegExp emailRegExp =
//       new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
//   RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
//   // ignore: unused_field
//   String _correo;
//   // ignore: unused_field
//   String _contrasena;
//   String mensaje = '';

//   bool _logueado = false;

//   initState() {
//     super.initState();
//     controller = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
//     controller.forward();
//   }

//   dispose() {
//     // Es importante SIEMPRE realizar el dispose del controller.
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _logueado ? HomeScreen() : loginForm(),
//       //body: loginForm(),
//     );
//   }

//   Widget loginForm() {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 100.0,
//               ),
//               Flexible(
//                 flex: 2,
//                 child: SafeArea(
//                   child: FractionallySizedBox(
//                     widthFactor: 0.7,
//                     child: Image.asset('assets/images/logo-1.png'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: 300.0, //size.width * .6,
//             child: Form(
//               key: _key,
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     validator: (text) {
//                       if (text.length == 0) {
//                         return "Este campo correo es requerido";
//                       } else if (!emailRegExp.hasMatch(text)) {
//                         return "El formato para correo no es correcto";
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.emailAddress,
//                     maxLength: 50,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       hintText: 'Ingrese su Correo',
//                       labelText: 'Correo',
//                       counterText: '',
//                       icon: Icon(Icons.email,
//                           size: 32.0, color: Colors.blue[800]),
//                     ),
//                     onSaved: (text) => _correo = text,
//                   ),
//                   TextFormField(
//                     obscureText: true,
//                     validator: (text) {
//                       if (text.length == 0) {
//                         return "Este campo contraseña es requerido";
//                       } else if (text.length <= 5) {
//                         return "Su contraseña debe ser al menos de 5 caracteres";
//                       } else if (!contRegExp.hasMatch(text)) {
//                         return "El formato para contraseña no es correcto";
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.text,
//                     maxLength: 20,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       hintText: 'Ingrese su Contraseña',
//                       labelText: 'Contraseña',
//                       counterText: '',
//                       icon:
//                           Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
//                     ),
//                     onSaved: (text) => _contrasena = text,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       if (_key.currentState.validate()) {
//                         _key.currentState.save();
//                         //Aqui se llamaria a su API para hacer el login
//                         setState(() {
//                           _logueado = true;
//                         });
//                         Navigator.of(context).pushReplacementNamed('/app');
//                       }
//                     },
//                     icon: Icon(
//                       Icons.arrow_forward,
//                       size: 42.0,
//                       color: Colors.blue[800],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  bool _failedLogin = false; //visibility
  bool _isLoading = false;

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
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Image.asset(
                            'assets/images/logo-1.png',
                          ),
                        ),
                        Visibility(
                          visible: _failedLogin,
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Center(
                              child: Text(
                                'Datos de Acceso Incorrectos',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.red[800]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        formSeparator(),
                        buildUsernameField(),
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

  TextFormField buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      validator: (usernameInput) {
        return usernameInput.isEmpty ? 'Debe ingresar su correo' : null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Email',
        // labelStyle: InputTheme.labelTextStyle,
      ),
      style: TextStyle(fontSize: 14),
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
    );
  }

  FlatButton buildLoginButton(BuildContext context) {
    return FlatButton(
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Ingresar',
        // style: BtnSuccessTheme.btnTextStyle,
      ),
      onPressed: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        setState(() {
          this._failedLogin = false;
        });
        if (_loginFormKey.currentState.validate()) {
          setState(() => _isLoading = true);
          Navigator.of(context).pushReplacementNamed('/app');
          // authenticateClient(context);
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

  // void authenticateClient(BuildContext context) async {
  //   var response = await AuthenticationRequester.login(
  //     _usernameController.text,
  //     _passwordController.text,
  //   );
  //   var responseJSON = json.jsonDecode(response.body);

  //   final clientStore = context.read<ClientStore>();

  //   if (response.statusCode == 200) {
  //     AuthClient.logIn(
  //       context,
  //       responseJSON['token'],
  //       json.jsonDecode(responseJSON['client'])['name'],
  //     );
  //     clientStore.setClientName(
  //       json.jsonDecode(responseJSON['client'])['name'],
  //     );
  //     setState(() => _isLoading = false);
  //   } else if (response.statusCode == 401) {
  //     setState(() {
  //       this._failedLogin = true;
  //       this._isLoading = false;
  //     });
  //     this._passwordController.clear();
  //   }
  // }
}
