
import java.util.Stack;

String input = "";
String postfix = "";
String result = "";

void setup() {
  size(700, 400);
  textSize(20);
}

void draw() {
  background(245);

  fill(30);
  textSize(26);
  text("Infix to Postfix Calculator", 30, 45);

  textSize(18);
  text("Enter an expression:", 30, 95);

  // 입력창
  fill(255);
  stroke(100);
  rect(30, 110, 640, 45, 8);

  fill(20);
  textSize(20);
  text(input + (frameCount % 60 < 30 ? "|" : ""), 42, 139);

  fill(80);
  textSize(14);
  text("Example: (12 + 3) * 4 - 6 / 2", 30, 180);
  text("Press ENTER to calculate, BACKSPACE to erase.", 30, 205);

  stroke(200);
  line(30, 230, 670, 230);

  fill(30);
  textSize(18);
  text("Postfix: " + postfix, 30, 275);
  text("Result: " + result, 30, 320);
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    calculate();
  } else if (key == BACKSPACE) {
    if (input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    }
  } else if (key == DELETE) {
    input = "";
    postfix = "";
    result = "";
  } else if ((key >= '0' && key <= '9')
          || key == '+' || key == '-'
          || key == '*' || key == '/'
          || key == '(' || key == ')'
          || key == '.') {
    input += key;
  }

  if (key != ENTER && key != RETURN) {
    result = "";
    postfix = "";
  }
}

// 계산 실행
void calculate() {
  if (input.trim().length() == 0) {
    result = "Please enter an expression.";
    postfix = "";
    return;
  }

  try {
    postfix = infixToPostfix(input);
    double answer = evaluatePostfix(postfix);

    // 정수는 소수점 없이, 소수는 그대로 표시
    if (Double.isFinite(answer)
        && answer == Math.floor(answer)
        && Math.abs(answer) < 1.0e15) {
      result = String.valueOf((long) answer);
    } else {
      result = String.valueOf(answer);
    }

  } catch (Exception e) {
    postfix = "";
    result = "Invalid expression!";
  }
}

// 중위표기식 -> 후위표기식
String infixToPostfix(String exp) {
  Stack<Character> ops = new Stack<Character>();
  String output = "";
  int i = 0;

  while (i < exp.length()) {
    char ch = exp.charAt(i);

    if (Character.isWhitespace(ch)) {
      i++;
      continue;
    }

    // 여러 자리 숫자 및 소수
    if (Character.isDigit(ch) || ch == '.') {
      String number = "";
      int dotCount = 0;

      while (i < exp.length()
          && (Character.isDigit(exp.charAt(i))
          || exp.charAt(i) == '.')) {

        if (exp.charAt(i) == '.') {
          dotCount++;
        }

        number += exp.charAt(i);
        i++;
      }

      if (dotCount > 1
          || number.equals(".")) {
        throw new RuntimeException("Invalid number");
      }

      output += number + " ";
      continue;
    }

    // 여는 괄호
    if (ch == '(') {
      ops.push(ch);
    }

    // 닫는 괄호
    else if (ch == ')') {
      while (!ops.empty() && ops.peek() != '(') {
        output += ops.pop() + " ";
      }

      if (ops.empty()) {
        throw new RuntimeException("Mismatched parentheses");
      }

      ops.pop();
    }

    // 연산자
    else if (isOperator(ch)) {
      while (!ops.empty()
          && ops.peek() != '('
          && precedence(ops.peek()) >= precedence(ch)) {
        output += ops.pop() + " ";
      }

      ops.push(ch);
    }

    else {
      throw new RuntimeException("Invalid character");
    }

    i++;
  }

  while (!ops.empty()) {
    if (ops.peek() == '(') {
      throw new RuntimeException("Mismatched parentheses");
    }

    output += ops.pop() + " ";
  }

  return output.trim();
}

// 연산자인지 확인
boolean isOperator(char ch) {
  return ch == '+' || ch == '-'
      || ch == '*' || ch == '/';
}

// 연산자 우선순위
int precedence(char op) {
  if (op == '+' || op == '-') {
    return 1;
  }

  if (op == '*' || op == '/') {
    return 2;
  }

  return 0;
}

// 후위표기식 계산
double evaluatePostfix(String postfix) {
  Stack<Double> values = new Stack<Double>();
  String[] tokens = splitTokens(postfix);

  for (int i = 0; i < tokens.length; i++) {
    String token = tokens[i];

    if (isNumber(token)) {
      values.push(Double.parseDouble(token));
    } else {
      if (values.size() < 2) {
        throw new RuntimeException("Invalid expression");
      }

      double b = values.pop();
      double a = values.pop();

      switch (token.charAt(0)) {
      case '+':
        values.push(a + b);
        break;

      case '-':
        values.push(a - b);
        break;

      case '*':
        values.push(a * b);
        break;

      case '/':
        if (b == 0) {
          throw new RuntimeException("Division by zero");
        }

        values.push(a / b);
        break;
      }
    }
  }

  if (values.size() != 1) {
    throw new RuntimeException("Invalid expression");
  }

  double answer = values.pop();

  if (Double.isNaN(answer) || Double.isInfinite(answer)) {
    throw new RuntimeException("Invalid result");
  }

  return answer;
}

// 숫자인지 확인
boolean isNumber(String s) {
  try {
    Double.parseDouble(s);
    return true;
  } catch (Exception e) {
    return false;
  }
}
