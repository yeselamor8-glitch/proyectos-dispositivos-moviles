import 'package:flutter/material.dart';

class ImcVista extends StatefulWidget {
  const ImcVista({super.key});

  @override
  State<ImcVista> createState() => _ImcVistaState();
}

class _ImcVistaState extends State<ImcVista> {
  final _txtPeso = TextEditingController();
  final _txtAltura = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  double? _imc;
  String _categoria = '';
  Color _colorCategoria = Colors.grey;
  IconData _iconoCategoria = Icons.info;

  @override
  void dispose() {
    _txtPeso.dispose();
    _txtAltura.dispose();
    super.dispose();
  }

  void _calcularIMC() {
    // Validar el formulario
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Obtener valores
    final peso = double.parse(_txtPeso.text.trim().replaceAll(',', '.'));
    final altura = double.parse(_txtAltura.text.trim().replaceAll(',', '.'));

    // Validar valores positivos
    if (peso <= 0) {
      _mostrarError('El peso debe ser mayor a 0');
      return;
    }

    if (altura <= 0 || altura > 3) {
      _mostrarError('La altura debe estar entre 0.1 y 3.0 metros');
      return;
    }

    // Calcular IMC
    final imc = peso / (altura * altura);
    
    // Categorizar
    _categorizarIMC(imc);

    setState(() {
      _imc = imc;
    });
  }

  void _categorizarIMC(double imc) {
    setState(() {
      if (imc < 18.5) {
        _categoria = 'Bajo peso';
        _colorCategoria = Colors.blue;
        _iconoCategoria = Icons.trending_down;
      } else if (imc >= 18.5 && imc <= 24.9) {
        _categoria = 'Peso normal';
        _colorCategoria = Colors.green;
        _iconoCategoria = Icons.check_circle;
      } else if (imc >= 25.0 && imc <= 29.9) {
        _categoria = 'Sobrepeso';
        _colorCategoria = Colors.orange;
        _iconoCategoria = Icons.warning;
      } else {
        _categoria = 'Obesidad';
        _colorCategoria = Colors.red;
        _iconoCategoria = Icons.error;
      }
    });
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _limpiar() {
    _txtPeso.clear();
    _txtAltura.clear();
    setState(() {
      _imc = null;
      _categoria = '';
      _colorCategoria = Colors.grey;
      _iconoCategoria = Icons.info;
    });
    _formKey.currentState?.reset();
  }

  String? _validarPeso(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El peso es obligatorio';
    }
    
    final peso = double.tryParse(value.trim().replaceAll(',', '.'));
    if (peso == null) {
      return 'Ingrese un número válido';
    }
    
    if (peso <= 0) {
      return 'El peso debe ser positivo';
    }
    
    if (peso > 500) {
      return 'El peso no puede ser mayor a 500 kg';
    }
    
    return null;
  }

  String? _validarAltura(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La altura es obligatoria';
    }
    
    final altura = double.tryParse(value.trim().replaceAll(',', '.'));
    if (altura == null) {
      return 'Ingrese un número válido';
    }
    
    if (altura <= 0) {
      return 'La altura debe ser positiva';
    }
    
    if (altura > 3) {
      return 'La altura no puede ser mayor a 3 metros';
    }
    
    if (altura < 0.3) {
      return 'La altura no puede ser menor a 0.3 metros';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                // Icono principal
                const Icon(
                  Icons.monitor_weight,
                  size: 80,
                  color: Colors.teal,
                ),
                
                const SizedBox(height: 20),
                
                // Título
                const Text(
                  'Calcule su Índice de Masa Corporal',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 10),
                
                // Descripción
                Text(
                  'Ingrese su peso y altura para calcular su IMC',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 30),
                
                // Card con los campos de entrada
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Campo de peso
                        TextFormField(
                          controller: _txtPeso,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: _validarPeso,
                          decoration: InputDecoration(
                            labelText: 'Peso (kg)',
                            hintText: 'Ejemplo: 70.5',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.scale, color: Colors.teal),
                            suffixText: 'kg',
                            filled: true,
                            fillColor: Colors.teal.shade50,
                          ),
                          onFieldSubmitted: (_) => _calcularIMC(),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Campo de altura
                        TextFormField(
                          controller: _txtAltura,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: _validarAltura,
                          decoration: InputDecoration(
                            labelText: 'Altura (m)',
                            hintText: 'Ejemplo: 1.75',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.height, color: Colors.teal),
                            suffixText: 'm',
                            filled: true,
                            fillColor: Colors.teal.shade50,
                          ),
                          onFieldSubmitted: (_) => _calcularIMC(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Botones
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _calcularIMC,
                        icon: const Icon(Icons.calculate),
                        label: const Text('Calcular IMC'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _limpiar,
                        icon: const Icon(Icons.clear),
                        label: const Text('Limpiar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Resultado
                if (_imc != null) ...[
                  Card(
                    elevation: 6,
                    color: _colorCategoria.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            _iconoCategoria,
                            size: 50,
                            color: _colorCategoria,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Su IMC es:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _imc!.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: _colorCategoria,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _colorCategoria,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              _categoria,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Tabla de referencia
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tabla de referencia:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTablaReferencia(),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTablaReferencia() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        _buildFilaTabla('IMC < 18.5', 'Bajo peso', Colors.blue),
        _buildFilaTabla('18.5 - 24.9', 'Peso normal', Colors.green),
        _buildFilaTabla('25.0 - 29.9', 'Sobrepeso', Colors.orange),
        _buildFilaTabla('IMC ≥ 30.0', 'Obesidad', Colors.red),
      ],
    );
  }

  TableRow _buildFilaTabla(String rango, String categoria, Color color) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            rango,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(categoria),
            ],
          ),
        ),
      ],
    );
  }
}