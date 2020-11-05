import 'dart:convert' as json;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palbus_app/database/payment_requester.dart';
import 'package:palbus_app/services/formatters.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentArguments arguments;

  const PaymentScreen({Key key, this.arguments}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(id: arguments.id);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final int id;
  String name = ' ';
  double amount = 0.0;
  String transportCompany = ' ';
  DateTime date = DateTime.now();

  _PaymentScreenState({@required this.id});

  @override
  void initState() {
    super.initState();
    getPayment();
  }

  getPayment() async {
    var response = await PaymentRequester.getPayment(id.toString());
    var responseJSON = json.jsonDecode(response.body);
    var bus = json.jsonDecode(json.jsonEncode(responseJSON['bus']));
    setState(() {
      this.name = json
          .jsonDecode(json.jsonEncode(responseJSON['passenger']))['name']
          .toString();
      this.amount = responseJSON['amount'];
      this.transportCompany = json
          .jsonDecode(json.jsonEncode(bus['transport_company']))['name']
          .toString();
      this.date = DateTime.parse(responseJSON['created_at']); // formatter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/app'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      Text(
                        'BOLETA DE PAGO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'N° 00$id',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      buildText("Nombre:  $name"),
                      buildText('Monto:   $amount'),
                      buildText('Empresa: $transportCompany'),
                      buildText('Fecha:   ${Formatters.getFormatDate(date)}'),
                      buildText(
                        'Hora:    ${Formatters.getFormatDate(date, format: 'HH:mm')}',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            'Su pago se ha\nrealizado\ncorrectamente',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            heightFactor: 0.9,
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Image.asset('assets/images/logo-1.png'),
                ),
              ],
            ),
          ),
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

class PaymentArguments {
  final int id;
  PaymentArguments(this.id);
}
