import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Layout - Acompanhamento de tarefas')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(                
            children: [
              _buildColumn(Icons.check_circle, 'Completas', 'Tasks completas', Colors.teal),
              const SizedBox(width: 12),
              _buildColumn(Icons.edit, 'Em progresso', 'Estão em progresso', Colors.blue),
              const SizedBox(width: 12),
              _buildColumn(Icons.access_time, 'Pendentes', 'Aguardando início', Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(IconData icon, String title, String subtitle, Color color) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              '$title\n$subtitle',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
