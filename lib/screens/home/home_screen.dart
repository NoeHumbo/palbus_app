import 'dart:convert' as json;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:palbus_app/database/balance_requester.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScanResult scanResult;

  String _balance = '0.0';

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  getBalance() async {
    var response = await BalanceRequester.balance();
    var responseJSON = json.jsonDecode(response.body);
    setState(() => this._balance = responseJSON[0]['amount'].toString());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.42,
                left: MediaQuery.of(context).size.width * 0.70,
                child: Image.asset(
                  'assets/images/Imagen-2.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlineButton(
                        child: Text(
                          'Saldo: S/. $_balance',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blue,
                          width: 2,
                        ),
                        onPressed: () {},
                        splashColor: Colors.transparent,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 40,
                          right: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Image.asset(
                          'assets/images/monedas.png',
                          height: 60,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Seleccione un monto',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 15),
                          buildOutlineButton(0.80),
                          buildSizedBox(),
                          buildOutlineButton(1.00),
                          buildSizedBox(),
                          buildOutlineButton(1.50),
                          buildSizedBox(),
                          buildOutlineButton(2.00),
                          buildSizedBox(),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _scanQR() async {
    dynamic futureString;

    try {
      futureString = await BarcodeScanner.scan(
        options: ScanOptions(
          restrictFormat: selectedFormats,
          strings: const {'cancel': 'Cancelar'},
        ),
      );
    } catch (e) {
      futureString = e.toString();
    }

    if (futureString.rawContent != null) {
      Navigator.of(context).pushNamed('/payment');
    }
    // https://www.facebook.com/
  }

  SizedBox buildSizedBox() =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.03);

  RaisedButton buildOutlineButton(double value) {
    return RaisedButton(
      child: Text(
        'S/. ${value}0',
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey[600],
          fontWeight: FontWeight.normal,
        ),
      ),
      color: Colors.white,
      highlightColor: Colors.blue,
      elevation: 5,
      onPressed: _showDialog,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.25,
        vertical: MediaQuery.of(context).size.height * 0.03,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.blue[600],
              width: 1,
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 10),
          title: Text(
            '¿Está seguro de realizar este pago?',
            textAlign: TextAlign.center,
          ),
          actions: [
            RaisedButton(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.red, width: 2)
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: Colors.red),),
            ),
            SizedBox(width: 50),
            RaisedButton(
              color: Colors.lightGreen,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.pop(context);
                _scanQR();
              },
              child: Text('Aceptar'),
            ),
            SizedBox(width: 5),
          ],
        );
      },
    );
  }
}
