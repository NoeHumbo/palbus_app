import 'package:flutter/material.dart';
import 'package:palbus_app/services/passenger_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  String passengerName = '';

  @override
  void initState() {
    super.initState();
    getPassengerName();
  }

  getPassengerName() async {
    String name = await PassengerPreferences.getPassengerName();
    setState(() => passengerName = name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _crearImagen(context),
          _crearTitulo(),
          _crearAcciones(),
        ],
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.27,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/componente.png"),
            fit: BoxFit.none,
            scale: 1.4,
          ),
        ),
        //color: Colors.blue,
        child: Image.asset(
          "assets/images/Avatar.png",
          fit: BoxFit.none,
          scale: 1,
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Saldo Disponible: S/ 100.00',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Datos del Usuario', style: estiloTitulo),
                      IconButton(
                          icon: Icon(
                            Icons.create,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          onPressed: () {})
                    ],
                  ),
                  SizedBox(height: 7.0),
                  Text('$passengerName', style: estiloSubTitulo),
                  Text("juanperez@gmail.com", style: estiloSubTitulo),
                  Text('987654321', style: estiloSubTitulo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildButton('Recargar Saldo', () {}),
                    _buildButton('Ver Recibos', () {}),
                    _buildButton('Eliminar Cuenta', _deleteAccount),
                    _buildButton('Cerrar Sesión', _logout),
                  ],
                ),
              ),
            ),

            Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/Logomitad.png",
                height: MediaQuery.of(context).size.height * 0.27,
                fit: BoxFit.cover,
              ),
            )
            //Icon(Icons.star, color: Colors.red, size: 30.0),
            //Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  FlatButton _buildButton(String texto, f) {
    return FlatButton(
      onPressed: f,
      child: Text(
        texto,
        style: TextStyle(fontSize: 15.0, color: Colors.blue),
      ),
      splashColor: Colors.transparent,
    );
  }

  _logout() {
    // logout
    Navigator.of(context).pushReplacementNamed('/login');
  }

  _deleteAccount() {
    // destroy
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
