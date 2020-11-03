import 'dart:convert' as json;

import 'package:flutter/material.dart';
import 'package:palbus_app/database/auth_requester.dart';
import 'package:palbus_app/database/balance_requester.dart';
import 'package:palbus_app/services/auth_passenger.dart';
import 'package:palbus_app/services/passenger_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final estiloSubTitulo = TextStyle(fontSize: 16.0, color: Colors.grey);

  String passengerName = ' ';

  String _mobileNumber = ' ';
  String _email = ' ';
  String _balance = '0.0';

  @override
  void initState() {
    super.initState();
    getPassengerName();
    getPassenger();
    getBalance();
  }

  getPassengerName() async {
    String name = await PassengerPreferences.getPassengerName();
    setState(() => passengerName = name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _crearImagen(context),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Saldo Disponible:\nS/ $_balance',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Datos del Usuario',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/edit_passenger'),
                            )
                          ],
                        ),
                        Text('$passengerName', style: estiloSubTitulo),
                        Text("$_email", style: estiloSubTitulo),
                        Text('$_mobileNumber', style: estiloSubTitulo),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        _buildButton('Recargar Saldo', goToRecharge),
                        _buildButton('Ver Recibos', goToListPayments),
                        _buildButton('Eliminar Cuenta', _deleteAccount),
                        _buildButton('Cerrar Sesión', _logout),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Logomitad.png',
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/componente.png'),
            fit: BoxFit.none,
            scale: 1.5,
          ),
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: MediaQuery.of(context).size.height * 0.101,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset(
                "assets/images/Avatar.png",
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildButton(String texto, f) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          texto,
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ),
      onTap: f,
    );
  }

  _logout() => AuthPassenger.logOut(context);

  _deleteAccount() => AuthPassenger.destroy(context);

  getPassenger() async {
    var response = await AuthRequester.passenger();
    var responseJSON = json.jsonDecode(response.body);
    print('HOLAAAAAAAA');
    print(response.body);
    setState(() {
      this._email = responseJSON['email'];
      this._mobileNumber = responseJSON['mobile_number'];
    });
  }

  getBalance() async {
    var response = await BalanceRequester.balance();
    var responseJSON = json.jsonDecode(response.body);
    setState(() => this._balance = responseJSON[0]['amount'].toString());
  }

  goToListPayments() => Navigator.of(context).pushNamed('/list_payments');
  goToRecharge() => Navigator.of(context).pushNamed('/recharge');
}
