import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:somando_dois_numeros/main.dart';
import 'package:mockito/mockito.dart';
import 'package:somando_dois_numeros/main.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

//criando um widget de teste e simulando as ações do usuário.

void main() {
  group('MyApp', () {
    testWidgets('Somando dois números corretamente',
        (WidgetTester tester) async {
      // Buildando o widget
      await tester.pumpWidget(MyApp());

      // Preenchendo os dois campos de texto com valores
      await tester.enterText(
          find.widgetWithText(TextField, 'Primeiro número'), '2');
      await tester.enterText(
          find.widgetWithText(TextField, 'Segundo número'), '3');

      // Apertando o botão calcular
      await tester.tap(find.widgetWithText(ElevatedButton, 'Calcular'));

      // Rebuildando o widget com status atualizado
      await tester.pump();

      // Verificando se a soma foi calculada corretamente
      expect(find.text('Resultado: 5'), findsOneWidget);

      // Apertando o botão 'Nova somatória'
      await tester.tap(find.widgetWithText(ElevatedButton, 'Nova somatória'));

      // Rebuildando o widget com status atualizado
      await tester.pump();

      // Verificando se os campos de texto foram limpos e o resultado é zero
      expect(find.widgetWithText(TextField, 'Primeiro número'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Segundo número'), findsOneWidget);
      expect(find.text('Resultado: 0'), findsOneWidget);
    });
  });
}
