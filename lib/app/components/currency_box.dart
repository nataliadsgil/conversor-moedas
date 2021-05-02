import 'package:flutter/material.dart';

class CurrencyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 65,
            child: DropdownButton(
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.blueGrey,
              ),
              items: [
                DropdownMenuItem(child: Text('Real')),
                DropdownMenuItem(child: Text('Dólar')),
                DropdownMenuItem(child: Text('Euro')),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
