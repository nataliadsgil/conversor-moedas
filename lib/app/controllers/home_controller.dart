import 'package:conversor_moedas/app/models/currency_model.dart';
import 'package:flutter/widgets.dart';

class HomeController {
  List<CurrencyModel> currencies;

  final TextEditingController fromValue;
  final TextEditingController toValue;

  CurrencyModel fromCurrency;
  CurrencyModel toCurrency;

  HomeController({this.fromValue, this.toValue}) {
    currencies = CurrencyModel.getCurrencies();
    fromCurrency = currencies[0];
    toCurrency = currencies[1];
  }

  void convert() {
    String text = fromValue.text;
    double value = double.tryParse(text.replaceAll(',', '.')) ?? 1.0;
    double returnValue = 0;

    if (toCurrency.name == 'Real') {
      returnValue = value * fromCurrency.real;
    } else if (toCurrency.name == 'Dolar') {
      returnValue = value * fromCurrency.dolar;
    } else if (toCurrency.name == 'Euro') {
      returnValue = value * fromCurrency.euro;
    } else if (toCurrency.name == 'Bitcoin') {
      returnValue = value * fromCurrency.bitcoin;
    }

    toValue.text = returnValue.toStringAsFixed(2);
  }
}
