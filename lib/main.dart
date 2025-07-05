import "package:flutter/material.dart";

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String displaydigits = "";
  String currentDigit = "";
  String previousDigit = "";
  String operator = "";
  double temp = 0;

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minimumSize: const Size(100, 100),
      backgroundColor: Color(0xFF1C1C1C),
    );
  }

  void display(String digit) {
    setState(() {
      currentDigit += digit;
      displaydigits = previousDigit + operator + currentDigit;
      if (displaydigits.length > 12) {
        displaydigits = displaydigits.substring(0, 12);
      }
    });
  }

  void calculation(String op) {
    setState(() {
      if (previousDigit.isEmpty) {
        previousDigit = currentDigit;
        currentDigit = "";
        if (op != "=") {
          operator = op;
        } else {
          operator = "";
        }
      } else if (currentDigit.isNotEmpty &&
          previousDigit.isNotEmpty &&
          operator.isEmpty) {
        previousDigit += currentDigit;
        operator = op;
        currentDigit = "";
      } else if (currentDigit.isEmpty) {
        if (op != "=") {
          operator = op;
        } else {
          operator = "";
        }
      } else {
        switch (operator) {
          case "+":
            temp = double.parse(previousDigit) + double.parse(currentDigit);
            break;
          case "-":
            temp = double.parse(previousDigit) - double.parse(currentDigit);
            break;
          case "*":
            temp = double.parse(previousDigit) * double.parse(currentDigit);
            break;
          case "/":
            temp = double.parse(previousDigit) / double.parse(currentDigit);
            break;
          default:
            temp = 0;
            break;
        }

        previousDigit = temp.toString();
        currentDigit = "";
        if (op != "=") {
          operator = op;
        } else {
          operator = "";
        }
      }
    });
    displaydigits = previousDigit + operator + currentDigit;
    if (displaydigits.length > 12) {
      displaydigits = displaydigits.substring(0, 12);
    }
  }

  Widget button(String s1, s2, s3, op) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            display(s1);
          },
          child: Text(s1, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            display(s2);
          },
          child: Text(s2, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            if (s3 == "=") {
              calculation("=");
            } else {
              display(s3);
            }
          },
          child: Text(s3, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            calculation(op);
          },
          child: Text(op, style: textStyle()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Color(0xFF2E2E2E),
          appBar: AppBar(
            title: Text(
              "Calculator",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 55, 52, 52),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.black87,
                  ),
                  child: Text(
                    displaydigits,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                button("7", "8", "9", "/"),
                SizedBox(height: 10),
                button("4", "5", "6", "*"),
                SizedBox(height: 10),
                button("1", "2", "3", "-"),
                SizedBox(height: 10),
                button(".", "0", "=", "+"),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: buttonStyle(),
                      onPressed: () {
                        setState(() {
                          displaydigits = "";
                          temp = 0;
                          currentDigit = "";
                          previousDigit = "";
                          operator = "";
                        });
                      },
                      child: Text("AC", style: textStyle()),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: buttonStyle(),
                      onPressed: () {
                        setState(() {
                          if (displaydigits.isNotEmpty) {
                            displaydigits = displaydigits.substring(
                              0,
                              displaydigits.length - 1,
                            );
                            if (currentDigit.isNotEmpty) {
                              currentDigit = currentDigit.substring(
                                0,
                                currentDigit.length - 1,
                              );
                            } else if (operator.isNotEmpty) {
                              operator = "";
                            } else if (previousDigit.isNotEmpty) {
                              previousDigit = previousDigit.substring(
                                0,
                                previousDigit.length - 1,
                              );
                            }
                          }
                        });
                      },
                      child: Text("C", style: textStyle()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
