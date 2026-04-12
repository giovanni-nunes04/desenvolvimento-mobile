import 'dart:math';

void main() {
  final random = Random();

  Map<int, List<int>> jogosMegaSena = {};

  for (int quantidade = 6; quantidade <= 15; quantidade++) {
    Set<int> volante = {};

    while (volante.length < quantidade) {
      volante.add(random.nextInt(60) + 1);
    }

    List<int> numerosOrdenados = volante.toList();
    numerosOrdenados.sort();

    jogosMegaSena[quantidade] = numerosOrdenados;
  }

  print('=== Volantes da Mega-Sena ===\n');

  jogosMegaSena.forEach((quantidade, volante) {
    print('Aposta com $quantidade números: $volante');
  });
}
