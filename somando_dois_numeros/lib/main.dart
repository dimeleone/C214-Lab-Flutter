import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  int _result = 0;

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  void _calculateSum() {
    setState(() {
      int firstNumber = int.tryParse(_firstNumberController.text) ?? 0;
      int secondNumber = int.tryParse(_secondNumberController.text) ?? 0;
      _result = firstNumber + secondNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Somando Dois Números',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Somando Dois Números'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _firstNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Primeiro número',
                ),
              ),
              TextField(
                controller: _secondNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Segundo número',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateSum,
                child: Text('Calcular'),
              ),
              SizedBox(height: 16),
              Text(
                'Resultado: $_result',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _firstNumberController.clear();
                    _secondNumberController.clear();
                    _result = 0;
                  });
                },
                child: Text('Nova somatória'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
