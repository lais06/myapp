import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String input = '';
  String result = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'Limpar') {
        input = '';
        result = '';
      } else if (value == '=') {
        try {
          result = _calcularResultado(input);
        } catch (e) {
          result = 'Erro';
        }
      } else {
        input += value;
      }
    });
  }

  String _calcularResultado(String expressao) {
    try {
      // Simples cálculo substituindo os operadores
      String formatted = expressao.replaceAll('x', '*').replaceAll('÷', '/');
      double eval = double.parse(
          (double.parse(formatted.split('*').fold('1', (a, b) => (double.parse(a) * double.parse(b)).toString()))).toString());
      return eval.toString();
    } catch (e) {
      return 'Erro';
    }
  }

  Widget buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.purple[100],
      ),
      body: Column(
        children: [
          // Tela de entrada e resultado
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 24, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          // Grade de botões
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('+'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('x'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('÷'),
                  buildButton('='),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton('Limpar'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}