import 'package:flutter/material.dart';

void main() {
  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D6A4F),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const IMCHomePage(),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  const IMCHomePage({super.key});

  @override
  State<IMCHomePage> createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  double? _imc;
  String _classificacao = '';
  Color _corClassificacao = Colors.transparent;

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _classificarIMC(double imc) {
    if (imc < 18.5) {
      return {
        'texto': 'Abaixo do peso',
        'cor': Colors.blue.shade600,
        'icone': Icons.arrow_downward_rounded,
      };
    } else if (imc < 25) {
      return {
        'texto': 'Peso normal',
        'cor': Colors.green.shade600,
        'icone': Icons.check_circle_rounded,
      };
    } else if (imc < 30) {
      return {
        'texto': 'Sobrepeso',
        'cor': Colors.orange.shade700,
        'icone': Icons.warning_rounded,
      };
    } else {
      return {
        'texto': 'Obesidade',
        'cor': Colors.red.shade700,
        'icone': Icons.error_rounded,
      };
    }
  }

  void _calcularIMC() {
    if (!_formKey.currentState!.validate()) return;

    final double peso = double.parse(_pesoController.text.replaceAll(',', '.'));
    final double altura =
        double.parse(_alturaController.text.replaceAll(',', '.'));

    final double imc = peso / (altura * altura);
    final resultado = _classificarIMC(imc);

    setState(() {
      _imc = imc;
      _classificacao = resultado['texto'];
      _corClassificacao = resultado['cor'];
    });

    _pesoController.clear();
    _alturaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A4F),
        foregroundColor: Colors.white,
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Center(
                  child: Icon(
                    Icons.monitor_weight_outlined,
                    size: 64,
                    color: Color(0xFF2D6A4F),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Informe seus dados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B4332),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                TextFormField(
                  controller: _pesoController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    hintText: 'Ex: 70.5',
                    prefixIcon: const Icon(Icons.fitness_center),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o peso';
                    }
                    final parsed =
                        double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null || parsed <= 0) {
                      return 'Peso inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _alturaController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Altura (m)',
                    hintText: 'Ex: 1.75',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a altura';
                    }
                    final parsed =
                        double.tryParse(value.replaceAll(',', '.'));
                    if (parsed == null || parsed <= 0 || parsed > 3) {
                      return 'Altura inválida (use metros, ex: 1.75)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: _calcularIMC,
                  icon: const Icon(Icons.calculate_rounded),
                  label: const Text(
                    'Calcular IMC',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                if (_imc != null)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _corClassificacao,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _corClassificacao.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Resultado',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'IMC: ${_imc!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B4332),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _corClassificacao.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _imc! < 18.5
                                    ? Icons.arrow_downward_rounded
                                    : _imc! < 25
                                        ? Icons.check_circle_rounded
                                        : _imc! < 30
                                            ? Icons.warning_rounded
                                            : Icons.error_rounded,
                                color: _corClassificacao,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _classificacao,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: _corClassificacao,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 32),
                _buildTabelaReferencia(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabelaReferencia() {
    final faixas = [
      {'range': '< 18,5', 'label': 'Abaixo do peso', 'cor': Colors.blue.shade600},
      {'range': '18,5 – 24,9', 'label': 'Peso normal', 'cor': Colors.green.shade600},
      {'range': '25 – 29,9', 'label': 'Sobrepeso', 'cor': Colors.orange.shade700},
      {'range': '≥ 30', 'label': 'Obesidade', 'cor': Colors.red.shade700},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tabela de referência',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 12),
          ...faixas.map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: f['cor'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      f['range'] as String,
                      style: const TextStyle(
                          fontFamily: 'monospace', fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      f['label'] as String,
                      style: TextStyle(
                        color: f['cor'] as Color,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}