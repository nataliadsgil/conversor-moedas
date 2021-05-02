import 'package:conversor_moedas/app/models/currency_model.dart';
import 'package:dio/dio.dart';

class CurrencyRepository {
  final dio = Dio();
  final mainUrl = 'https://economia.awesomeapi.com.br/last';

  Future<List<CurrencyModel>> fetchCurrencies() async {
    final currenciesCode = ['USD', 'BRL', 'EUR'];
    final List<CurrencyModel> list = [];

    for (var i = 0; i < currenciesCode.length; i++) {
      String code = '';
      int contComma = 0;
      for (var j = 0; j < currenciesCode.length; j++) {
        if (currenciesCode[i] != currenciesCode[j]) {
          contComma++;
          code += '${currenciesCode[i]}-${currenciesCode[j]}';
          if (contComma < 2) code += ',';
        }
      }

      final url = '$mainUrl/$code';
      final response = await dio.get(url);

      print(response);

      var currencyCode = currenciesCode[i];

      final currency = CurrencyModel(
        name: currencyCode,
        real: currencyCode == 'BRL'
            ? 1.0
            : double.tryParse(response.data['$currencyCode' + 'BRL']['bid']),
        dolar: currencyCode == 'USD'
            ? 1.0
            : double.tryParse(response.data['$currencyCode' + 'USD']['bid']),
        euro: currencyCode == 'EUR'
            ? 1.0
            : double.tryParse(response.data['$currencyCode' + 'EUR']['bid']),
      );

      list.add(currency);
    }

    return list;
  }
}
