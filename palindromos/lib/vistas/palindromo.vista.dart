import 'package:flutter/material.dart';

class PalindromoVista extends StatefulWidget {
  const PalindromoVista({super.key});

  @override
  State<PalindromoVista> createState() => _PalindromoVistaState();
}

class _PalindromoVistaState extends State<PalindromoVista> {
  final _txtFrase = TextEditingController();
  String _resultado = '';

  void _verificarPalindromo() {
    // Obtener la frase ingresada por el usuario
    final fraseOriginal = _txtFrase.text.trim();

    if (fraseOriginal.isEmpty) {
      setState(() {
        _resultado = 'Por favor ingrese una frase';
      });
      return;
    }

    // Paso 1: Limpiar la frase (eliminar espacios y caracteres especiales)
    final fraseLimpia = fraseOriginal
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toLowerCase();

    // Paso 2: Invertir la frase
    final fraseInvertida = fraseLimpia.split('').reversed.join();

    // Paso 3: Comparar la frase limpia con la frase invertida
    setState(() {
      if (fraseLimpia == fraseInvertida) {
        _resultado = '✅ "$fraseOriginal" ES un palíndromo';
      } else {
        _resultado = '❌ "$fraseOriginal" NO es un palíndromo';
      }
    });
  }

  void _limpiar() {
    _txtFrase.clear();
    setState(() {
      _resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Palíndromos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.text_fields,
              size: 60,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingrese una frase para verificar si es palíndromo',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _txtFrase,
              decoration: const InputDecoration(
                labelText: 'Ingrese la frase',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              onSubmitted: (_) => _verificarPalindromo(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _verificarPalindromo,
                  icon: const Icon(Icons.check),
                  label: const Text('Verificar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: _limpiar,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpiar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Card(
                color: _resultado.contains('✅')
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _resultado.contains('✅')
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}