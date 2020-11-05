import 'package:flutter/material.dart';
import 'package:palbus_app/database/recharge_requester.dart';

class RechargeScreen extends StatefulWidget {
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _amountController = new TextEditingController();
  final _cardController = new TextEditingController();
  final _deadDateController = new TextEditingController();
  final _cvvController = new TextEditingController();

  bool _failedLogin = false;
  bool _isLoading = false;

  bool _isFullE = false;
  bool _isFullP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Recargar saldo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                child: Form(
                  key: _loginFormKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
                    child: Column(
                      children: <Widget>[
                        formSeparator(),
                        Visibility(
                          visible: _failedLogin,
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Center(
                              child: Text(
                                'Datos de Acceso Incorrectos',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        formSeparator(),
                        buildAmountField(),
                        formSeparator(),
                        buildCardField(),
                        formSeparator(),
                        buildDeadDateField(),
                        formSeparator(),
                        buildCVVField(),
                        formSeparator(),
                        SizedBox(
                          width: double.infinity,
                          child: buildLoginButton(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  TextFormField buildAmountField() {
    return TextFormField(
      controller: _amountController,
      validator: (value) {
        if (value.isEmpty || int.parse(value) == 0) {
          return 'El monto debe ser mayor a 0';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Monto',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullE = true);
        } else if (value == "") {
          setState(() => _isFullE = false);
        }
      },
    );
  }

  TextFormField buildCVVField() {
    return TextFormField(
      controller: _cvvController,
      validator: (value) {
        if (value.isEmpty) {
          return 'El código CVV no puede ser vacío';
        } else if (value.length != 3) {
          return 'El código CVV tiene solo 3 dígitos';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'CVV',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullE = true);
        } else if (value == "") {
          setState(() => _isFullE = false);
        }
      },
    );
  }

  TextFormField buildCardField() {
    return TextFormField(
      controller: _cardController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Número de tarjeta inválido';
        } else if (value.length != 16) {
          return 'Número de tarjeta contiene 16 dígitos';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Número de tarjeta',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullE = true);
        } else if (value == "") {
          setState(() => _isFullE = false);
        }
      },
    );
  }

  TextFormField buildDeadDateField() {
    return TextFormField(
      controller: _deadDateController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Fecha de vencimiento no puede ser vacía';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Fecha de Vencimiento',
      ),
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() => _isFullE = true);
        } else if (value == "") {
          setState(() => _isFullE = false);
        }
      },
    );
  }

  FlatButton buildLoginButton(BuildContext context) {
    return FlatButton(
      color: _isFullE && _isFullP ? Colors.blue : Colors.grey[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        'Recargar saldo',
      ),
      onPressed: () {
        FocusNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        setState(() => this._failedLogin = false);
        if (_loginFormKey.currentState.validate()) {
          createRecharge();
        }
      },
    );
  }

  SizedBox formSeparator() => SizedBox(height: 30);

  void createRecharge() async {
    var response = await RechargeRequester.createRecharge(
      amount: _amountController.text.trim(),
    );
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/app');
    } else {
      setState(() => this._failedLogin = true);
    }
  }
}
