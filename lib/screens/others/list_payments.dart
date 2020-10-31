import 'package:flutter/material.dart';

class ListPaymentsScreen extends StatefulWidget {
  @override
  _ListPaymentsScreenState createState() => _ListPaymentsScreenState();
}

class _ListPaymentsScreenState extends State<ListPaymentsScreen> {
  @override

  @override
  void initState() { 
    super.initState();
  }

  getPayments() {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Lista de recibos', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('10/10/2020 - 09:07 am'), Text('N° 123')],
            ),
            Text('Noe HUmbo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Super Star'), Text('Total S/ 10.00')],
            ),
          ],
        ),
      ),
    );
  }
}
