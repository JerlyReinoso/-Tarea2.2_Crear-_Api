import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../services/api_service.dart';
import 'create_person_screen.dart';
import 'edit_person_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Persona> personas = [];

  @override
  void initState() {
    super.initState();
    _loadPersonas();
  }

  _loadPersonas() async {
    personas = await apiService.obtenerPersonas();
    setState(() {});
  }

  _eliminarPersona(String id) async {
    try {
      await apiService.eliminarPersona(id);
      _loadPersonas(); // Recargar la lista después de eliminar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar persona'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Acción de búsqueda (puedes implementarla más tarde)
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: personas.isEmpty
            ? Center(child: CircularProgressIndicator()) // Muestra un cargador si no hay personas
            : ListView.builder(
          itemCount: personas.length,
          itemBuilder: (context, index) {
            final persona = personas[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                title: Text(
                  '${persona.nombre} ${persona.apellido}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  persona.telefono,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                onTap: () {
                  // Navegar a la pantalla de editar persona
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditPersonScreen(persona: persona)),
                  ).then((_) {
                    // Después de editar, actualizamos la lista
                    _loadPersonas();
                  });
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _eliminarPersona(persona.id!),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de crear persona
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePersonScreen()),
          ).then((_) {
            // Después de regresar de CreatePersonScreen, actualizamos la lista de personas
            _loadPersonas();
          });
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
