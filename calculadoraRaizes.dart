import 'dart:math';

void calcularRaizes(List<double> valores) {
  if (valores.length == 2) {
    double b = valores[0];
    double c = valores[1];

    if (b == 0) {
      print('Não é possível calcular.');
    } else {
      print('Raiz: ${-c / b}');
    }
  } else if (valores.length == 3) {
    double a = valores[0];
    double b = valores[1];
    double c = valores[2];

    if (a == 0) {
      print('Não é equação de 2º grau.');
      return;
    }
