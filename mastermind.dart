import 'dart:io';
import 'dart:math';

void main() {
  Random random = Random();

  List<int> senha = List.generate(4, (_) => random.nextInt(6) + 1);

  int maxTentativas = 10;
  bool venceu = false;

  print('=== JOGO MASTERMIND ===');
  print('Tente adivinhar a senha secreta de 4 dígitos.');
  print('Cada dígito vai de 1 a 6.');
  print('Você tem $maxTentativas tentativas.');
  print('');

  for (int tentativa = 1; tentativa <= maxTentativas; tentativa++) {
    List<int> palpite = [];
    while (true) {
      print('Tentativa $tentativa de $maxTentativas');
      stdout.write('Digite 4 números entre 1 e 6 (exemplo: 1234): ');
      String? entrada = stdin.readLineSync();
      if (entrada == null || entrada.length != 4) {
        print('Entrada inválida. Digite exatamente 4 números.');
        continue;
      }
      bool valida = true;
      palpite.clear();
      for (int i = 0; i < entrada.length; i++) {
        int? numero = int.tryParse(entrada[i]);
        if (numero == null || numero < 1 || numero > 6) {
          valida = false;
          break;
        }
        palpite.add(numero);
      }
      if (!valida) {
        print('Entrada inválida. Use apenas números entre 1 e 6.');
        continue;
      }
      break;
    }

    int pretos = 0;
    int brancos = 0;

    List<bool> senhaUsada = List.filled(4, false);
    List<bool> palpiteUsado = List.filled(4, false);

    for (int i = 0; i < 4; i++) {
      if (palpite[i] == senha[i]) {
        pretos++;
        senhaUsada[i] = true;
        palpiteUsado[i] = true;
      }
    }

    for (int i = 0; i < 4; i++) {
      if (palpiteUsado[i]) continue;
      for (int j = 0; j < 4; j++) {
        if (!senhaUsada[j] && palpite[i] == senha[j]) {
          brancos++;
          senhaUsada[j] = true;
          break;
        }
      }
    }

    print('Pinos Pretos: $pretos');
    print('Pinos Brancos: $brancos');
    print('');

    if (pretos == 4) {
      venceu = true;
      print('Parabéns! Você acertou a senha em $tentativa tentativa(s).');
      break;
    }
  }

  if (!venceu) {
    print('Que pena! Você perdeu.');
    print('A senha era: ${senha.join()}');
  }
}
