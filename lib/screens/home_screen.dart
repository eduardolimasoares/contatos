import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contatos/models/contato.dart'; // Substitua 'your_app' pelo nome do seu aplicativo

class ContatoScreen extends StatefulWidget {
  final Contato? contato; // pode ser nulo se estivermos adicionando um novo contato

  ContatoScreen({this.contato});

  @override
  _ContatoScreenState createState() => _ContatoScreenState();
}

class _ContatoScreenState extends State<ContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  File? _imagemSelecionada; // para armazenar a imagem selecionada

  @override
  void initState() {
    super.initState();
    if (widget.contato != null) {
      // Se estamos editando um contato existente, preencha os campos
      _nomeController.text = widget.contato!.nome;
      _telefoneController.text = widget.contato!.telefone;
      // Aqui, você também pode lidar com a imagem existente, se houver
    }
  }

  void _selecionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  void _salvarContato() {
    if (!_formKey.currentState!.validate()) {

      return;
    }


    final novoContato = Contato(
      id: widget.contato != null ? widget.contato!.id : DateTime.now().toString(), // ID único
      nome: _nomeController.text,
      telefone: _telefoneController.text,
      imagePath: _imagemSelecionada != null ? _imagemSelecionada!.path : '', // Salve o caminho da imagem
    );


    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato != null ? 'Editar Contato' : 'Adicionar Contato'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_imagemSelecionada != null)
                  Image.file(
                    _imagemSelecionada!,
                    width: 150, // você pode ajustar as dimensões conforme necessário
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome.';
                    }
                    return null; // entrada válida
                  },
                ),
                TextFormField(
                  controller: _telefoneController,
                  decoration: InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um número de telefone.';
                    }
                    return null; // entrada válida
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _selecionarImagem,
                  child: Text('Selecionar Imagem'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _salvarContato,
                  child: Text('Salvar Contato'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
