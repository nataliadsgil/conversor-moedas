import 'package:conversor_moedas/app/repositories/currency_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final repository = CurrencyRepository();
  test('Deve trazer lista de moedas', () async {
    final list = await repository.fetchCurrencies();
    print(list[0].name);
  });
}
