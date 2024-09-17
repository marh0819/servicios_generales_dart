/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'buildOperarioView.dart'; // Importa el archivo donde tienes `buildOperarioView`


class CrearOperarioPage extends StatefulWidget {
  @override
  _CrearOperarioPageState createState() => _CrearOperarioPageState();
}

class _CrearOperarioPageState extends State<CrearOperarioPage> {
  final TextEditingController _idOperarioController = TextEditingController();
  final TextEditingController _fkIdUsuarioController = TextEditingController();

  Future<void> crearOperario() async {
    final url = Uri.parse('http://192.168.18.20:8080/api/v1/operarios');

    // Convertir los valores de los TextFields a int
    final int? idOperario = int.tryParse(_idOperarioController.text);
    final int? fkIdUsuario = int.tryParse(_fkIdUsuarioController.text);

    if (idOperario == null || fkIdUsuario == null) {
      print('Por favor, ingresa valores válidos');
      return;
    }

    // Cuerpo del POST request
    final body = jsonEncode({
      'id_operario': idOperario,
      'fk_id_Usuario': fkIdUsuario,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print('Operario creado con éxito');
        // Navegar a la vista de Operarios
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => buildOperarioView()),
        );
      } else {
        print('Error al crear operario: ${response.statusCode}');
        print('Respuesta: ${response.body}');
      }
    } catch (e) {
      print('Error al realizar la petición: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Operario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idOperarioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'ID Operario'),
            ),
            TextField(
              controller: _fkIdUsuarioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'FK ID Usuario'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: crearOperario,
              child: Text('Añadir Operario'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'buildOperarioView.dart'; // Importa el archivo donde tienes `buildOperarioView`
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrearOperarioPage extends StatefulWidget {
  @override
  _CrearOperarioPageState createState() => _CrearOperarioPageState();
}

class _CrearOperarioPageState extends State<CrearOperarioPage> {
  final TextEditingController idOperarioController = TextEditingController();
  final TextEditingController fkIdUsuarioController = TextEditingController();

  Future<void> createOperario() async {
    final url = Uri.parse('http://192.168.25.49:8080/api/v1/operarios');

    final body = jsonEncode({
      'id_operario': int.tryParse(idOperarioController.text),
      'fk_id_Usuario': int.tryParse(fkIdUsuarioController.text),
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print('Operario creado exitosamente');
        // Aquí rediriges a buildOperarioView
        Navigator.pushNamed(context, '/buildOperarioView');
      } else {
        print('Error al crear el operario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Operario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            TextField(
              controller: fkIdUsuarioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID Usuario',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                createOperario();
              },
              child: Text('Crear Operario'),
            ),
          ],
        ),
      ),
    );
  }
}
