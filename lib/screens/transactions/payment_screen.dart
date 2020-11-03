import 'dart:convert' as json;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palbus_app/database/payment_requester.dart';

class PaymentScreen extends StatefulWidget {
  final int id;

  const PaymentScreen({Key key, this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(id);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final int id;
  String name = '';
  String amount = '';
  String transportCompany = '';
  DateTime date = DateTime.now();

  _PaymentScreenState(this.id);

  @override
  void initState() {
    super.initState();
    getPayment();
  }

  getPayment() async {
    var response = await PaymentRequester.getPayment(id.toString());
    var responseJSON = json.jsonDecode(response.body);
    setState(() {
      this.name = responseJSON['passenger']['name'];
      this.amount = responseJSON['amount'];
      this.transportCompany = responseJSON['transport_company']['name'];
      this.date = responseJSON['created_at']; // formatter
    });
  }

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
                        'N° 34570',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      buildText('Nombre:  $name'),
                      buildText('Monto:   $amount'),
                      buildText('Empresa: $transportCompany'),
                      buildText('Fecha:   ${getFormatDate(date)}'),
                      buildText(
                          'Hora:    ${getFormatDate(date, format: 'HH:mm')}'),
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

  static getFormatDate(DateTime date, {String format = "dd MM yyyy"}) {
    var formatter = new DateFormat(format, 'es_PE');
    return formatter.format(date);
    // .split(' ')
    // .map((e) => e[0].toUpperCase() + e.substring(1).replaceFirst('.', ''))
    // .join(' ');
  }
}
