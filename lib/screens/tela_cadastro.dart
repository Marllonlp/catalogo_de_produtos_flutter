import 'package:flutter/material.dart';

import '../models/produto.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  String _categoria = iconesPorCategoria.keys.first;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  double? _lerPreco() {
    return double.tryParse(_precoController.text.replaceAll(',', '.'));
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Produto(
          nome: _nomeController.text,
          preco: _lerPreco()!,
          categoria: _categoria,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do produto'),
                validator: (valor) => valor == null || valor.trim().isEmpty
                    ? 'Informe o nome'
                    : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (_) =>
                    _lerPreco() == null ? 'Informe um preço válido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _categoria,
                isExpanded: true,
                items: iconesPorCategoria.keys
                    .map(
                      (categoria) => DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria),
                      ),
                    )
                    .toList(),
                onChanged: (valor) {
                  setState(() {
                    _categoria = valor!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cadastrar,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
