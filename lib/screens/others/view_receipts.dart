import 'dart:ui';

import 'package:flutter/material.dart';

class ViewReceipts extends StatefulWidget {
  @override
  _ViewReceiptsState createState() => _ViewReceiptsState();
}

class _ViewReceiptsState extends State<ViewReceipts> {
  @override
  Widget build(BuildContext context) {
    final recibos = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD3E8FD),
            Color(0xFFF2F6F9),
          ],
          begin: FractionalOffset(1.0, 0.1),
          end: FractionalOffset(1.0, 0.9),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration:
                          InputDecoration(hintText: "Día", counterText: ''),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration:
                          InputDecoration(hintText: "Mes", counterText: ''),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration:
                          InputDecoration(hintText: "Año", counterText: ''),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 40.0, right: 40.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 12.0,
                      right: 12.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(112, 112, 112, 100),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    // height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '10/10/2020 - 09:07am',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'N° 123',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Juan Perez',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Super Star',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                            Text(
                              'Total: S/.  10.00',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(112, 112, 112, 100)),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    // height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('10/10/2020 - 03:51pm',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 14)),
                            Text('N° 195',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 14)),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Juan Perez',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Super Star',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18)),
                            Text('Total: S/.  10.00',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    final img_credit_card = Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/credit-card-1.png'),
        ),
      ),
    );

    final img_bus = Container(
      width: 220.0,
      height: 220.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/Imagen-1.png'))),
    );

    final recibos_credit_card = Stack(
      alignment: Alignment(0.55, 0.85),
      children: [recibos, img_credit_card],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ver Recibos',
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Arial",
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFD3E8FD),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment(-2.10, 0.80),
          children: [recibos_credit_card, img_bus],
        ),
      ),
    );
  }
}
