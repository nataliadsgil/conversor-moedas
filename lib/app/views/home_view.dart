import 'package:conversor_moedas/app/components/currency_box.dart';
import 'package:conversor_moedas/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController fromValue = TextEditingController();

  final TextEditingController toValue = TextEditingController();

  HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController = HomeController(
      toValue: toValue,
      fromValue: fromValue,
    );
    homeController.start();
  }

  _start() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _success() {
    return Column(
      children: [
        CurrencyBox(
          selectedItem: homeController.fromCurrency,
          items: homeController.currencies,
          controller: fromValue,
          onPressed: () {
            var index =
                homeController.currencies.indexOf(homeController.fromCurrency);
            if (index < homeController.currencies.length - 1) {
              index++;
            } else {
              index = 0;
            }
            setState(() {
              homeController.fromCurrency = homeController.currencies[index];
            });
          },
        ),
        SizedBox(height: 10),
        CurrencyBox(
          selectedItem: homeController.toCurrency,
          items: homeController.currencies,
          controller: toValue,
          onPressed: () {
            var index =
                homeController.currencies.indexOf(homeController.toCurrency);
            if (index < homeController.currencies.length - 1) {
              index++;
            } else {
              index = 0;
            }
            setState(() {
              homeController.toCurrency = homeController.currencies[index];
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            homeController.convert();
          },
          child: Text('Converter'),
        )
      ],
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Tentar Novamente'),
      ),
    );
  }

  stateManagment(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Image.asset('assets/images/logo.png'),
              ),
              AnimatedBuilder(
                animation: homeController.state,
                builder: (context, child) {
                  return stateManagment(homeController.state.value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
