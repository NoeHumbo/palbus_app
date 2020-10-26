import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  
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
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/componente.png"),
            fit: BoxFit.none,
            scale: 1.3,
          ),
        ),
        //color: Colors.blue,
        child: Image.asset(
          "assets/images/Avatar.png",
          //height: 300.0,
          fit: BoxFit.none,
          scale: 1,
        ),
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Saldo Disponible: S/ 10.00',
                      style: estiloSubTitulo,
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
                  Text('Juan Perez', style: estiloSubTitulo),
                  Text("juanperez@gmail.com", style: estiloSubTitulo),
                  Text('987654321', style: estiloSubTitulo),
                ],
              ),
            ),

            //Icon(Icons.create, color: Colors.blue, size: 30.0),
            //Text('41', style: TextStyle(fontSize: 20.0))
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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _accion('Recargar Saldo'),
                    _accion('Ver Recibos'),
                    _accion('Eliminar Cuenta'),
                    _accion('Cerrar Sesion'),
                  ],
                ),
              ),
            ),

            Image.asset(
              "assets/images/Logomitad.png",
              height: 220.0,
              fit: BoxFit.cover,
            )
            //Icon(Icons.star, color: Colors.red, size: 30.0),
            //Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  Widget _accion(String texto) {
    return Column(
      children: <Widget>[
        SizedBox(height: 9.0),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }
}
