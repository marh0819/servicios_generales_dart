import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class buildMantenimientoView extends StatefulWidget {
  const buildMantenimientoView({super.key});

  @override
  _buildMantenimientoViewState createState() => _buildMantenimientoViewState();
}

class _buildMantenimientoViewState extends State<buildMantenimientoView> {
  Future<List<Map<String, dynamic>>>? _mantenimientoData;

  @override
  void initState() {
    super.initState();
    _mantenimientoData = fetchMantenimientoData();
  }

  Future<List<Map<String, dynamic>>> fetchMantenimientoData() async {
    final response = await http
        .get(Uri.parse('http://192.168.25.49:8080/api/v1/mantenimientos'));

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
        title: const Text('Mantenimientos List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _mantenimientoData,
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
              var mantenimiento = data![index];
              return ListTile(
                title: Text(mantenimiento['nombre_Mantenimiento']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inicio: ${mantenimiento['fechaInicio']}'),
                    Text('Fin: ${mantenimiento['fechaFin']}'),
                    Text('Estado: ${mantenimiento['estadoManteminento']}'),
                    Text(
                        'Prioridad: ${mantenimiento['prioridadMantenimiento']}'),
                    Text(
                        'Descripción: ${mantenimiento['descripcionMantenimiento']}'),
                  ],
                ),
                isThreeLine: true, // Para mostrar más espacio para el subtítulo
              );
            },
          );
        },
      ),
    );
  }
}
