import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

class DataEntryScreen extends StatefulWidget {
  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  File? _image;
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _recordAudio() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${appDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    if (!_isRecording) {
      await _recorder!.startRecorder(
        toFile: filePath,
        codec: Codec.aacADTS,
      );
      setState(() {
        _isRecording = true;
        _audioPath = filePath;
      });
    } else {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  void _saveData() {
    // Guardar los datos localmente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            ListTile(
              title: Text('Fecha: ${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _selectDate,
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Foto'),
            ),
            ElevatedButton(
              onPressed: _recordAudio,
              child: Text(_isRecording ? 'Detener Grabación' : 'Grabar Audio'),
            ),
            _audioPath == null
                ? Text('No audio recorded.')
                : Text('Audio guardado en: $_audioPath'),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}
