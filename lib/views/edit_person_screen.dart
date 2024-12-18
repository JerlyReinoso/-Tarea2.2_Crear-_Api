import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../services/api_service.dart';

class EditPersonScreen extends StatefulWidget {
  final Persona persona;

  EditPersonScreen({required this.persona});

  @override
  _EditPersonScreenState createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends State<EditPersonScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late String nombre, apellido, telefono;

  @override
  void initState() {
    super.initState();
    // Inicializar con los valores de la persona a editar
    nombre = widget.persona.nombre;
    apellido = widget.persona.apellido;
    telefono = widget.persona.telefono;
  }

  _updatePersona() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final persona = Persona(id: widget.persona.id!, nombre: nombre, apellido: apellido, telefono: telefono);
      try {
        await apiService.actualizarPersona(widget.persona.id!, persona);
        Navigator.pop(context); // Volver a la pantalla principal
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar persona'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Persona', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edita los detalles de la persona',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: nombre,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => nombre = value!,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: apellido,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => apellido = value!,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: telefono,
                decoration: InputDecoration(
                  labelText: 'Telefono',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => telefono = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePersona,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Color del fondo (reemplazado primary por backgroundColor)
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Actualizar Persona', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
