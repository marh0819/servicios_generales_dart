/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class buildOperarioView extends StatefulWidget {
  const buildOperarioView({super.key});

  @override
  _buildOperarioViewState createState() => _buildOperarioViewState();
}

class _buildOperarioViewState extends State<buildOperarioView> {
  Future<List<Map<String, dynamic>>>? _operarioData;

  @override
  void initState() {
    super.initState();
    _operarioData = fetchOperarioData();
  }

  Future<List<Map<String, dynamic>>> fetchOperarioData() async {
    final response =
        await http.get(Uri.parse('http://192.168.25.49:8080/api/v1/operarios'));

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
        title: const Text('Operarios List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _operarioData,
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
              var operario = data![index];
              return ListTile(
                title: Text('Id usuario: ${operario['fk_id_Usuario']}'),
                subtitle: Text('Id operario: ${operario['id_operario']}'),
                leading: const Icon(Icons.person), // Icono opcional
              );
            },
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CrearOperarioPage.dart'; // Importa la página de crear operario

class buildOperarioView extends StatefulWidget {
  const buildOperarioView({super.key});

  @override
  _buildOperarioViewState createState() => _buildOperarioViewState();
}

class _buildOperarioViewState extends State<buildOperarioView> {
  Future<List<Map<String, dynamic>>>? _operarioData;

  @override
  void initState() {
    super.initState();
    _operarioData = fetchOperarioData();
  }

  Future<List<Map<String, dynamic>>> fetchOperarioData() async {
    final response =
        await http.get(Uri.parse('http://192.168.25.49:8080/api/v1/operarios'));

    if (response.statusCode == 200) {
      // Decodifica correctamente en UTF-8
      var jsonResponse = utf8.decode(response.bodyBytes);
      return List<Map<String, dynamic>>.from(jsonDecode(jsonResponse));
    } else {
      throw Exception('Failed to load Operario data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operarios List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _operarioData,
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
              var operario = data![index];
              return ListTile(
                title: Text('Id usuario: ${operario['fk_id_Usuario']}'),
                subtitle: Text('Id operario: ${operario['id_operario']}'),
                leading: const Icon(Icons.person), // Icono opcional
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la página CrearOperarioPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearOperarioPage()),
          );
        },
        child: const Icon(Icons.add), // Icono del botón de añadir
        tooltip: 'Añadir Operario',
      ),
    );
  }
}