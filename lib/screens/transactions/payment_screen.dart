import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue[700], width: 3),
            ),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.10,
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 75, left: 25, right: 25, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'BOLETA DE PAGO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'N° 34570',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    buildText('Nombre'),
                    buildText('Monto'),
                    buildText('Empresa'),
                    buildText('Fecha'),
                    buildText('Hora'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.lightGreen,
                            size: 60,
                          ),
                        ),
                        Text(
                          'Su pago se ha realizado\ncorrectamente',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            heightFactor: 0.85,
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Image.asset('assets/images/logo-1.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
    );
  }
}
