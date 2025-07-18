import "package:flutter/material.dart";
import "calculation.dart";

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  Calculation logic = Calculation();
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
      minimumSize: Size(logic.width * 0.22, logic.height * 0.12),
      backgroundColor: Color(0xFF1C1C1C),
    );
  }

  Widget button(String s1, s2, s3, op) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            setState(() {
              logic.display(s1);
            });
          },
          child: Text(s1, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            setState(() {
              logic.display(s2);
            });
          },
          child: Text(s2, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            if (s3 == "=") {
              setState(() {
                logic.calculation("=");
              });
            } else {
              setState(() {
                logic.display(s3);
              });
            }
          },
          child: Text(s3, style: textStyle()),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: buttonStyle(),
          onPressed: () {
            setState(() {
              logic.calculation(op);
            });
          },
          child: Text(op, style: textStyle()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            logic.width = MediaQuery.of(context).size.width;
            logic.height = MediaQuery.of(context).size.height;
          } else {
            logic.width = MediaQuery.of(context).size.width * 0.3;
            logic.height = MediaQuery.of(context).size.height;
          }
          return Scaffold(
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
                    width: logic.width * 0.95,
                    height: logic.height * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black87,
                    ),
                    child: Text(
                      logic.displaydigits,
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
                            logic.displaydigits = "";
                            logic.temp = 0;
                            logic.currentDigit = "";
                            logic.previousDigit = "";
                            logic.operator = "";
                          });
                        },
                        child: Text("AC", style: textStyle()),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () {
                          setState(() {
                            logic.clear();
                          });
                        },
                        child: Text("C", style: textStyle()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
