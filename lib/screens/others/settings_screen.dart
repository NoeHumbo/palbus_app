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
          Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height*0.10,
                right: 0,
                child: Image.asset(
                  "assets/images/Logomitad.png",
                  height: MediaQuery.of(context).size.height * 0.38,
                  fit: BoxFit.cover,
                  ),
              ),
            Column(children: [
              _crearTitulo(),
              _crearAcciones(),]
              ,)
            ],
          )
        ],
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.32,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/componente.png"),
            fit: BoxFit.none,
            scale: 1.6,
          ),
        ),
        //color: Colors.blue,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 94,
            child: Image.asset(
            "assets/images/Avatar.png",
            scale: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    return Container(
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Datos del Usuario', style: estiloTitulo),
                    IconButton(
                        icon: Icon(
                          Icons.create,
                          color: Colors.blue,
                          size: 20.0,
                        ),
                        onPressed: () {})
                  ],
                ),
                Text('$passengerName', style: estiloSubTitulo),
                Text("juanperez@gmail.com", style: estiloSubTitulo),
                Text('987654321', style: estiloSubTitulo),
              ],
            ),
          ),
        ],
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
            //Icon(Icons.star, color: Colors.red, size: 30.0),
            //Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  _buildButton(String texto, f) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(texto,style: TextStyle(color: Colors.blue, fontSize: 15),),
      ),
      onTap: f,

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
