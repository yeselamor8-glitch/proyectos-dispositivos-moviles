import 'dart:math';

import 'package:juego_cartas/modelos/emnumerados.dart';

class Carta{
  final int indice;

  Carta(Random r) : indice = r.nextInt(52) + 1; // Genera un número aleatorio entre 1 y 52
  String get rutaImagen => 'assets/imagenes/CARTA$indice.JPG'; // Devuelve la ruta de la imagen correspondiente a la carta
  Pinta get pinta {
    if (indice <= 13) {
      return Pinta.TREBOL;
    } else if (indice <= 26) {
      return Pinta.PICAS;
    } else if (indice <= 39) {
      return Pinta.CORAZON;
    } else {
      return Pinta.DIAMANTE;
    }
  }
  NombreCarta get nombre {
    int residuo = indice % 13;
    if (residuo == 0){
      residuo = 13;
    }
    return NombreCarta.values[residuo - 1];
  }

}