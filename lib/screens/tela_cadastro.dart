import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../utils/categorias.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  String? _categoria;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  double? _lerPreco() {
    return double.tryParse(_precoController.text.trim().replaceAll(',', '.'));
  }

  String? _validarNome(String? valor) {
    final nome = valor?.trim() ?? '';
    if (nome.isEmpty) {
      return 'Informe o nome do produto';
    }
    if (nome.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  String? _validarPreco(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o preço';
    }
    final preco = _lerPreco();
    if (preco == null) {
      return 'Informe um preço numérico válido';
    }
    if (preco <= 0) {
      return 'O preço deve ser maior que zero';
    }
    return null;
  }

  String? _validarCategoria(String? valor) {
    if (valor == null) {
      return 'Selecione uma categoria';
    }
    if (!iconesPorCategoria.containsKey(valor)) {
      return 'Categoria inválida';
    }
    return null;
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Produto(
          nome: _nomeController.text.trim(),
          preco: _lerPreco()!,
          categoria: _categoria!,
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
                validator: _validarNome,
              ),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _validarPreco,
              ),
              const SizedBox(height: 16),
              FormField<String>(
                validator: _validarCategoria,
                builder: (campo) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: _categoria,
                      hint: const Text('Selecione a categoria'),
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
                          _categoria = valor;
                        });
                        campo.didChange(valor);
                      },
                    ),
                    if (campo.hasError)
                      Text(
                        campo.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
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
