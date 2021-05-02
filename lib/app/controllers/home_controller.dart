import 'package:conversor_moedas/app/models/currency_model.dart';
import 'package:conversor_moedas/app/repositories/currency_repository.dart';
import 'package:flutter/widgets.dart';

class HomeController {
  List<CurrencyModel> currencies = [];

  final repository = CurrencyRepository();

  final state = ValueNotifier<HomeState>(HomeState.start);

  final TextEditingController fromValue;
  final TextEditingController toValue;

  CurrencyModel fromCurrency;
  CurrencyModel toCurrency;

  Future start() async {
    state.value = HomeState.loading;
    try {
      currencies = await repository.fetchCurrencies();
      state.value = HomeState.success;
      fromCurrency = currencies[0];
      toCurrency = currencies[1];
    } catch (err) {
      state.value = HomeState.error;
    }
  }

  HomeController({this.fromValue, this.toValue}) {}

  void convert() {
    String text = fromValue.text;
    double value = double.tryParse(text.replaceAll(',', '.')) ?? 1.0;
    double returnValue = 0;

    if (toCurrency.name == 'BRL') {
      returnValue = value * fromCurrency.real;
    } else if (toCurrency.name == 'USD') {
      returnValue = value * fromCurrency.dolar;
    } else if (toCurrency.name == 'EUR') {
      returnValue = value * fromCurrency.euro;
    }

    toValue.text = returnValue.toStringAsFixed(2);
  }
}

enum HomeState {
  start,
  loading,
  success,
  error,
}
