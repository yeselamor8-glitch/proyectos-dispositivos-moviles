import 'package:flutter/material.dart';

class ConversorVista extends StatefulWidget {
  const ConversorVista({super.key});

  @override
  State<StatefulWidget> createState() => _ConversorState();
}

class _ConversorState extends State<ConversorVista> {
  final _txtNumero = TextEditingController();
  String _resultado = "";
  final _estadoFormulario = GlobalKey<FormState>();

  String _convertirARomano(int numero) {
    if (numero <= 0 || numero > 3999) {
      return 'Número fuera de rango (1-3999)';
    }

    const Map<int, String> numerosRomanos = {
      1000: 'M',
      900: 'CM',
      500: 'D',
      400: 'CD',
      100: 'C',
      90: 'XC',
      50: 'L',
      40: 'XL',
      10: 'X',
      9: 'IX',
      5: 'V',
      4: 'IV',
      1: 'I',
    };

    // obtener el numero romano
    String romano = "";
    while (numero > 0) {
      for (var valor in numerosRomanos.keys) {
        if (numero >= valor) {
          romano += numerosRomanos[valor]!;
          numero -= valor;
          break;
        }
      }
    }

    return romano;
  }

  void _calcular() {
    //verificar si el valor es valido
    if (_estadoFormulario.currentState!.validate()) {
      final numero = int.parse(_txtNumero.text);
      final romano = _convertirARomano(numero);
      setState(() {
        _resultado = romano;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversor a Números Romanos"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _estadoFormulario,
          child: Column(
            children: [
              const Text("ingrese un numero para convertirlo a romano"),
              const SizedBox(height: 20),
              TextFormField(
                controller: _txtNumero,
                decoration: const InputDecoration(
                  labelText: "Número del 1 al 3999",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                //validaciones
                validator: (valor) {
                  // Validar que el valor no sea nulo o vacío
                  if (valor == null || valor.isEmpty) {
                    return "Por favor ingrese un número valido";
                  }
                  // Validar que el valor sea un número entero entre 1 y 3999
                  final numero = int.tryParse(valor);
                  if (numero == null || numero < 1 || numero > 3999) {
                    return "Por favor ingrese un número entre 1 y 3999";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcular,
                child: const Text("Convertir"),
              ),
              const SizedBox(height: 20),
              Text("Resultado: $_resultado", textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
