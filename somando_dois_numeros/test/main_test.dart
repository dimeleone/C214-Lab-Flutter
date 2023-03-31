import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:somando_dois_numeros/main.dart';

/*teste: 
> encontrando os campos de texto
> preenchendo os campos com valores válidos
> encontrando o botão de calcular e pressionando
> verificando se o resultado foi calculado corretamente!
*/

void main() {
  testWidgets('Testando cálculo de soma', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Encontrando os campos de texto
    final primeiroNumeroField =
        find.widgetWithText(TextField, 'Primeiro número');
    final segundoNumeroField = find.widgetWithText(TextField, 'Segundo número');

    // Preenchendo os campos de texto
    await tester.enterText(primeiroNumeroField, '10');
    await tester.enterText(segundoNumeroField, '20');

    // Encontrando o botão de cálculo e pressionando
    final calcularButton = find.widgetWithText(ElevatedButton, 'Calcular');
    await tester.tap(calcularButton);
    await tester.pump();

    // Verificando se o resultado foi calculado corretamente
    expect(find.text('Resultado: 30'), findsOneWidget);
  });
}
