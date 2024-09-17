import 'package:flutter/material.dart';

import 'buildUsuarioView.dart';
import 'buildOperarioView.dart';
import 'buildMantenimientoView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servicios generales',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(2, 58, 183, 58),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Servicios generales'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedView = 'usuario';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            opcionesMenu(context, const Icon(Icons.home),
                const Text('Usuarios'), 'usuario'),
            opcionesMenu(context, const Icon(Icons.list),
                const Text('Operarios'), 'operario'),
            opcionesMenu(context, const Icon(Icons.pets),
                const Text('Mantenimiento'), 'mantenimiento'),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          switch (_selectedView) {
            case 'usuario':
              return buildUsuarioView();
            case 'operario':
              return buildOperarioView();
            case 'mantenimiento':
              return buildMantenimientoView();
            default:
              return Container();
          }
        },
      ),
    );
  }

  ListTile opcionesMenu(
      BuildContext context, Icon home, Text text, String destino) {
    return ListTile(
      leading: home,
      title: text,
      onTap: () {
        setState(() {
          _selectedView = destino;
        });
        Navigator.pop(context); // Cierra el drawer
      },
    );
  }
}
