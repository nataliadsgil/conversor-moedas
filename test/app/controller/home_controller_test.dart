import 'package:conversor_moedas/app/controllers/home_controller.dart';
import 'package:conversor_moedas/app/models/currency_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();

  final homeController = HomeController(
    fromValue: from,
    toValue: to,
  );

  test('deve converter de real para dolar', () {
    from.text = '2.0';
    homeController.convert();
    expect(to.text, '0.36');
  });

  test('deve converter de dolar para real', () {
    from.text = '1.0';
    homeController.fromCurrency = CurrencyModel(
      name: 'Dolar',
      real: 5.65,
      dolar: 1.0,
      euro: 0.85,
    );

    homeController.toCurrency = CurrencyModel(
      name: 'Real',
      real: 1.0,
      dolar: 0.18,
      euro: 0.15,
    );
    homeController.convert();
    expect(to.text, '5.65');
  });

  test('deve converter se o usuário digitar vírgula no lugar de ponto', () {
    from.text = '2,0';
    homeController.convert();
    expect(to.text, '0.36');
  });
}
