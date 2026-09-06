import 'package:flutter/material.dart';

class JuegoVista extends StatefulWidget {
  const JuegoVista({super.key});

  @override
  State<StatefulWidget> createState() => _JuegoState();
}

class _JuegoState extends State<JuegoVista> {

void _repartir() {
    // Lógica para repartir las cartas
  }

void _verificar(int index) {
    // Lógica para verificar las cartas del jugador correspondiente
  }




  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Juego de Cartas'),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Martin Estrada Contreras'),
            Tab(text: 'Raul Vidal'),
          ],
        ),
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                  ElevatedButton(
                    onPressed: _repartir,
                    child: const Text("Repartir"),
                  ),
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          _verificar(DefaultTabController.of(context).index);
                        },
                        child: const Text("Verificar"),
                      );
                    },
                  ),
                ],
            )
          ),
        
        ],

    
    )
   )
    
  );
  }
}