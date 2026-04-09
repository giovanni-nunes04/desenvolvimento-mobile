void main() {
  Map<String, Function(double, double)> calculadora = {
    'somar': (a, b) => a + b,
    'subtrair': (a, b) => a - b,
    'multiplicar': (a, b) => a * b,
    'dividir': (a, b) => b != 0 ? a / b : double.nan,
  };

  String funcao = 'multiplicar';
  double n1 = 8;
  double n2 = 4;

  if (calculadora.containsKey(funcao)) {
    print(calculadora[funcao]!(n1, n2));
  } else {
    print('Função não encontrada.');
  }
}
