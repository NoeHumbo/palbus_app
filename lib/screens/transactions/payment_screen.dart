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
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue[700], width: 3)),
                  margin: EdgeInsets.only(top: 100, right: 50, left: 50),
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
                          Text(
                            'Nombre',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Monto',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Empresa',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Fecha',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Hora',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 60,
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
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Image.asset('assets/images/logo-1.png'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
