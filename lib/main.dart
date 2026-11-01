import 'package:flutter/material.dart';

import 'screens/tela_principal.dart';

void main() {
  runApp(const CatalogoApp());
}

class CatalogoApp extends StatelessWidget {
  const CatalogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Catálogo de Produtos',
      home: TelaPrincipal(),
    );
  }
}
