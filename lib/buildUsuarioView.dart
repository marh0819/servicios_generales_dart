import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class buildUsuarioView extends StatefulWidget {
  const buildUsuarioView({super.key});

  @override
  _buildUsuarioViewState createState() => _buildUsuarioViewState();
}

class _buildUsuarioViewState extends State<buildUsuarioView> {
  Future<List<Map<String, dynamic>>>? _usuarioData;

  @override
  void initState() {
    super.initState();
    _usuarioData = fetchUsuarioData();
  }

  Future<List<Map<String, dynamic>>> fetchUsuarioData() async {
    final response =
        await http.get(Uri.parse('http://192.168.25.49:8080/api/v1/usuarios'));

    if (response.statusCode == 200) {
      // Decodifica correctamente en UTF-8
      var jsonResponse = utf8.decode(response.bodyBytes);
      return List<Map<String, dynamic>>.from(jsonDecode(jsonResponse));
    } else {
      throw Exception('Failed to load Servicios data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _usuarioData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          var data = snapshot.data;
          // Asumiendo que data es una lista de mapas
          return ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              var usuario = data![index];
              return ListTile(
                title: Text('${usuario['nombre']} ${usuario['apellido']}'),
                subtitle: Text('Categoría: ${usuario['categoria']}'),
                leading: const Icon(Icons.person), // Icono opcional
              );
            },
          );
        },
      ),
    );
  }
}
