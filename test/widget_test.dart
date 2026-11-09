import 'package:catalogo_produtos/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cadastra produto sem substituir e mostra SnackBar', (
    tester,
  ) async {
    await tester.pumpWidget(const CatalogoApp());
    expect(find.byType(Card), findsNWidgets(4));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Cadastrar Produto'), findsOneWidget);

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(find.text('Informe o nome do produto'), findsOneWidget);
    expect(find.text('Informe o preço'), findsOneWidget);
    expect(find.text('Selecione uma categoria'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Mo');
    await tester.enterText(find.byType(TextFormField).at(1), '0');
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(
      find.text('O nome deve ter pelo menos 3 caracteres'),
      findsOneWidget,
    );
    expect(find.text('O preço deve ser maior que zero'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(1), 'abc');
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(find.text('Informe um preço numérico válido'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Mouse');
    await tester.enterText(find.byType(TextFormField).at(1), '10,5');
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Livros').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNWidgets(5));
    expect(find.text('R\$ 10,50'), findsOneWidget);
    expect(find.byIcon(Icons.menu_book), findsNWidgets(2));

    await tester.tap(find.text('Mouse'));
    await tester.pump();
    expect(find.text('Mouse adicionado ao carrinho'), findsOneWidget);
  });
}
