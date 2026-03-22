import 'dart:io';
import 'dart:math';

void main() {
  final List<String> palavras = [
    'banana',
    'computador',
    'gato',
    'janela',
    'escola',
    'teclado',
  ];

  final Random random = Random();
  final String palavraSecreta = palavras[random.nextInt(palavras.length)].toLowerCase();

  final Set<String> letrasCorretas = {};
  final Set<String> letrasErradas = {};
  final Set<String> letrasTentadas = {};

  int vidas = 6;
  bool venceu = false;
  bool perdeu = false;

  print('=== JOGO DA FORCA ===');

  while (!venceu && !perdeu) {
    print('');
    desenharForca(vidas);
    print('Palavra: ${montarPalavraOculta(palavraSecreta, letrasCorretas)}');
    print('Erros: ${formatarLetras(letrasErradas)}');
    print('Tentativas restantes: $vidas');
    stdout.write('Digite uma letra ou chute a palavra completa: ');

    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Entrada inválida. Tente novamente.');
      continue;
    }

    entrada = entrada.trim().toLowerCase();

    if (entrada.isEmpty) {
      print('Você precisa digitar algo.');
      continue;
    }

    if (entrada.length > 1) {
      if (!RegExp(r'^[a-zA-ZÀ-ÿ]+$').hasMatch(entrada)) {
        print('Digite apenas letras.');
        continue;
      }

      if (entrada == palavraSecreta) {
        venceu = true;
        break;
      } else {
        print('Chute incorreto! Você perdeu o jogo.');
        vidas = 0;
        perdeu = true;
        break;
      }
    }

    if (!RegExp(r'^[a-zA-ZÀ-ÿ]$').hasMatch(entrada)) {
      print('Digite apenas uma letra válida.');
      continue;
    }

    if (letrasTentadas.contains(entrada)) {
      print('Você já tentou a letra "$entrada".');
      continue;
    }

    letrasTentadas.add(entrada);

    if (palavraSecreta.contains(entrada)) {
      letrasCorretas.add(entrada);
      print('Boa! A letra "$entrada" existe na palavra.');
    } else {
      letrasErradas.add(entrada);
      vidas--;
      print('A letra "$entrada" não existe na palavra.');
    }

    venceu = verificarVitoria(palavraSecreta, letrasCorretas);

    if (vidas <= 0) {
      perdeu = true;
    }
  }

  print('');
  desenharForca(vidas);

  if (venceu) {
    print('Parabéns! Você venceu!');
    print('A palavra era: ${palavraSecreta.toUpperCase()}');
  } else {
    print('Que pena! Você perdeu.');
    print('A palavra era: ${palavraSecreta.toUpperCase()}');
  }
}

String montarPalavraOculta(String palavra, Set<String> letrasCorretas) {
  List<String> exibicao = [];

  for (int i = 0; i < palavra.length; i++) {
    String letra = palavra[i];
    if (letrasCorretas.contains(letra)) {
      exibicao.add(letra.toUpperCase());
    } else {
      exibicao.add('_');
    }
  }

  return exibicao.join(' ');
}

bool verificarVitoria(String palavra, Set<String> letrasCorretas) {
  for (int i = 0; i < palavra.length; i++) {
    if (!letrasCorretas.contains(palavra[i])) {
      return false;
    }
  }
  return true;
}

String formatarLetras(Set<String> letras) {
  if (letras.isEmpty) {
    return '[]';
  }

  List<String> lista = letras.map((l) => l.toUpperCase()).toList();
  lista.sort();
  return '[${lista.join(', ')}]';
}

void desenharForca(int vidas) {
  List<String> estagios = [
    '''
  +---+
  |   |
  O   |
 /|\\  |
 / \\  |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|\\  |
 /    |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|\\  |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
  |   |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
      |
      |
      |
=========
''',
    '''
  +---+
  |   |
      |
      |
      |
      |
=========
''',
  ];

  print(estagios[vidas]);
}
