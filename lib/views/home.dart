import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();
  String resultado = 'Informe seus dados';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _controllerPeso.text = '';
                _controllerAltura.text = '';
                resultado = 'Informe seus dados';
                FocusScope.of(context).requestFocus(FocusNode());
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 150,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerPeso,
                  decoration:
                      InputDecoration(hintText: 'Peso (Kg)', labelText: 'Peso'),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Digite seu peso';
                    }
                    double value = double.parse(text);
                    if (value > 0 && value <= 150) {
                      return null;
                    }
                    return 'Digite um peso válido.';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerAltura,
                  decoration: InputDecoration(
                      hintText: 'Altura (m)', labelText: 'Altura'),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Digite sua altura';
                    }
                    double value = double.parse(text);
                    if (value >= 0.5 && value <= 2.4) {
                      return null;
                    }
                    return 'Digite um valor de altura válido em metros';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: FlatButton(
                      color: Colors.green,
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            resultado = getImc(
                                double.parse(_controllerPeso.text),
                                double.parse(_controllerAltura.text));
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        });
                      }),
                ),
              ),
              Text(
                resultado,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getImc(double peso, double altura) {
    double imc = peso / (altura * altura);
    print(imc);
    String resposta;
    if (imc < 18.6) {
      resposta = 'Abaixo do Peso';
    } else if (imc >= 18.6 && imc <= 24.9) {
      resposta = 'Peso Ideal (IMC: ${imc.toStringAsFixed(2)})';
    } else if (imc >= 25 && imc <= 29.9) {
      resposta = 'Levemente acima do Peso (IMC: ${imc.toStringAsFixed(2)})';
    } else if (imc >= 30 && imc <= 34.9) {
      resposta = 'Obesidade grau I (IMC: ${imc.toStringAsFixed(2)})';
    } else if (imc >= 35 && imc <= 39.9) {
      resposta = 'Obesidade grau II (IMC: ${imc.toStringAsFixed(2)})';
    } else if (imc >= 40) {
      resposta = 'Obesidade grau III (IMC: ${imc.toStringAsFixed(2)})';
    }
    return resposta;
  }
}
