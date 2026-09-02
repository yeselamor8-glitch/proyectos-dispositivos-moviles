import 'package:flutter/material.dart';

class AnagramaVista extends StatefulWidget {
  const AnagramaVista({super.key});

  @override
  State<AnagramaVista> createState() => _AnagramaVistaState();
}

class _AnagramaVistaState extends State<AnagramaVista> {
  final _txtPalabra1 = TextEditingController();
  final _txtPalabra2 = TextEditingController();
  String _resultado = '';
  bool _esAnagrama = false;

  @override
  void dispose() {
    _txtPalabra1.dispose();
    _txtPalabra2.dispose();
    super.dispose();
  }

  void _verificarAnagrama() {
    final palabra1 = _txtPalabra1.text.trim().toLowerCase();
    final palabra2 = _txtPalabra2.text.trim().toLowerCase();

    if (palabra1.isEmpty || palabra2.isEmpty) {
      setState(() {
        _resultado = '⚠️ Por favor ingrese ambas palabras';
        _esAnagrama = false;
      });
      return;
    }

    if (palabra1 == palabra2) {
      setState(() {
        _resultado = '❌ Las palabras son idénticas, no son anagramas';
        _esAnagrama = false;
      });
      return;
    }

    // Ordenar las letras de ambas palabras
    List<String> letras1 = palabra1.split('')..sort();
    List<String> letras2 = palabra2.split('')..sort();

    bool esAnagrama = letras1.join() == letras2.join();

    setState(() {
      _esAnagrama = esAnagrama;
      if (esAnagrama) {
        _resultado = '✅ "$palabra1" y "$palabra2" SON anagramas';
      } else {
        _resultado = '❌ "$palabra1" y "$palabra2" NO son anagramas';
      }
    });
  }

  void _limpiar() {
    _txtPalabra1.clear();
    _txtPalabra2.clear();
    setState(() {
      _resultado = '';
      _esAnagrama = false;
    });
  }

  void _intercambiar() {
    final temp = _txtPalabra1.text;
    _txtPalabra1.text = _txtPalabra2.text;
    _txtPalabra2.text = temp;
    _verificarAnagrama();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Anagramas'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.swap_horiz,
                size: 80,
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
              const Text(
                'Un anagrama es cuando dos palabras tienen las mismas letras pero en diferente orden',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _txtPalabra1,
                        decoration: const InputDecoration(
                          labelText: 'Primera palabra',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.looks_one, color: Colors.purple),
                          hintText: 'Ejemplo: amor',
                        ),
                        onSubmitted: (_) => _verificarAnagrama(),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _txtPalabra2,
                        decoration: const InputDecoration(
                          labelText: 'Segunda palabra',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.looks_two, color: Colors.purple),
                          hintText: 'Ejemplo: roma',
                        ),
                        onSubmitted: (_) => _verificarAnagrama(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _verificarAnagrama,
                    icon: const Icon(Icons.check),
                    label: const Text('Verificar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: _intercambiar,
                    icon: const Icon(Icons.swap_vert),
                    label: const Text('Intercambiar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple,
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
              const SizedBox(height: 30),
              if (_resultado.isNotEmpty)
                Card(
                  elevation: 6,
                  color: _esAnagrama 
                      ? Colors.green.shade50 
                      : Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          _esAnagrama ? Icons.celebration : Icons.error_outline,
                          size: 40,
                          color: _esAnagrama 
                              ? Colors.green.shade700 
                              : Colors.red.shade700,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _resultado,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _esAnagrama 
                                ? Colors.green.shade800 
                                : Colors.red.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}