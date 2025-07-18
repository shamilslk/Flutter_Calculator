class Calculation {
  double width = 0;
  double height = 0;
  String displaydigits = "";
  String currentDigit = "";
  String previousDigit = "";
  String operator = "";
  double temp = 0;

  void display(String digit) {
    currentDigit += digit;
    displaydigits = previousDigit + operator + currentDigit;
    if (displaydigits.length > 12) {
      displaydigits = displaydigits.substring(0, 12);
    }
  }

  void calculation(String op) {
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
    displaydigits = previousDigit + operator + currentDigit;
    if (displaydigits.length > 12) {
      displaydigits = displaydigits.substring(0, 12);
    }
  }

  void clear() {
    if (displaydigits.isNotEmpty) {
      displaydigits = displaydigits.substring(0, displaydigits.length - 1);
      if (currentDigit.isNotEmpty) {
        currentDigit = currentDigit.substring(0, currentDigit.length - 1);
      } else if (operator.isNotEmpty) {
        operator = "";
      } else if (previousDigit.isNotEmpty) {
        previousDigit = previousDigit.substring(0, previousDigit.length - 1);
      }
    }
  }
}
