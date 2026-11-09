import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../utils/categorias.dart';
import 'tela_cadastro.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Produto> _produtos = [
    Produto(nome: 'Fone de Ouvido', preco: 149.90, categoria: 'Eletrônicos'),
    Produto(nome: 'Camiseta', preco: 59.90, categoria: 'Roupas'),
    Produto(nome: 'Café', preco: 24.50, categoria: 'Alimentos'),
    Produto(nome: 'Dom Casmurro', preco: 39.90, categoria: 'Livros'),
  ];

  Future<void> _abrirCadastro() async {
    final novoProduto = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );

    if (novoProduto != null) {
      setState(() {
        _produtos.add(novoProduto);
      });
    }
  }

  void _adicionarAoCarrinho(Produto produto) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${produto.nome} adicionado ao carrinho')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Produtos')),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];
          return Card(
            child: ListTile(
              leading: Icon(iconesPorCategoria[produto.categoria]),
              title: Text(produto.nome),
              subtitle: Text(
                'R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
              ),
              trailing: ElevatedButton(
                onPressed: () => _adicionarAoCarrinho(produto),
                child: const Text('Comprar'),
              ),
              onTap: () => _adicionarAoCarrinho(produto),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
