import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    dynamic equation = '0';
    dynamic result = '0';
    dynamic expression = '';
    dynamic equationFontSize = 38.0;
    dynamic resultFontSize = 48.0;

    buttonPressed(buttonText) {
      setState(() {
        if (buttonText == 'C') {
          equation = '0';
          result = '0';
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == '<') {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equation = '0';
          }
        } else if (buttonText == '=') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          expression = equation;
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'something went wrong';
          }
        } else {
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      });
    }

    Widget buildButton(
        String buttonText, double buttonHeight, Color buttonColor) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shadowColor: MaterialStateProperty.all(Colors.red),
                elevation: MaterialStateProperty.all(1.5),
                splashFactory: InkRipple.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.green.shade100),
                minimumSize: MaterialStateProperty.all(Size(85,
                    MediaQuery.of(context).size.height * 0.11 * buttonHeight)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))),
            onPressed: () => buttonPressed(buttonText),
            child: Text(buttonText)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            equation,
            style: TextStyle(color: Colors.black, fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text(
            result,
            style: TextStyle(color: Colors.black, fontSize: resultFontSize),
          ),
        ),
        const Expanded(child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                buildButton('C', 0.90, Colors.red.shade200),
                buildButton('1', 0.90, Colors.grey.shade200),
                buildButton('4', 0.90, Colors.grey.shade200),
                buildButton('7', 0.90, Colors.grey.shade200),
                buildButton('0', 0.90, Colors.grey.shade200),
              ],
            ),
            Column(
              children: [
                buildButton('<', 0.90, Colors.white),
                buildButton('2', 0.90, Colors.grey.shade200),
                buildButton('5', 0.90, Colors.grey.shade200),
                buildButton('8', 0.90, Colors.grey.shade200),
                buildButton('00', 0.90, Colors.grey.shade200),
              ],
            ),
            Column(
              children: [
                buildButton('/', 0.90, Colors.white),
                buildButton('3', 0.90, Colors.grey.shade200),
                buildButton('6', 0.90, Colors.grey.shade200),
                buildButton('9', 0.90, Colors.grey.shade200),
                buildButton('.', 0.90, Colors.grey.shade200),
              ],
            ),
            Column(
              children: [
                buildButton('*', 0.90, Colors.white),
                buildButton('+', 0.90, Colors.grey.shade200),
                buildButton('-', 0.90, Colors.grey.shade200),
                buildButton('=', 1.85, Colors.grey.shade200),
              ],
            )
          ],
        )
      ]),
    );
  }
}
