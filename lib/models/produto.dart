import 'package:flutter/material.dart';

const Map<String, IconData> iconesPorCategoria = {
  'Eletrônicos': Icons.devices,
  'Roupas': Icons.checkroom,
  'Alimentos': Icons.restaurant,
  'Livros': Icons.menu_book,
};

class Produto {
  final String nome;
  final double preco;
  final String categoria;

  Produto({required this.nome, required this.preco, required this.categoria});
}
