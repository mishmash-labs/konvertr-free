import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../providers/converter_provider.dart';

class ConverterKeypad extends StatelessWidget {
  const ConverterKeypad({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convProvider = Provider.of<ConverterProvider>(context, listen: false);
    const buttonHeight = 0.09375;

    Widget valueButton({String value}) => InkWell(
          onTap: () => convProvider.executeButton(context, value),
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white60, fontSize: 32),
              ),
            ),
          ),
        );

    Widget iconButton({String value, IconData icon}) => InkWell(
          onTap: () => convProvider.executeButton(context, value),
          child: SizedBox(
            height: buttonHeight * MediaQuery.of(context).size.height,
            child: Center(child: Icon(icon, color: Colors.white60, size: 32)),
          ),
        );

    return Container(
      color: Theme.of(context).primaryColor,
      child: Table(
        children: [
          TableRow(
            children: <Widget>[
              valueButton(value: '7'),
              valueButton(value: '8'),
              valueButton(value: '9'),
              iconButton(value: 'copy', icon: Feather.copy),
            ],
          ),
          TableRow(
            children: <Widget>[
              valueButton(value: '4'),
              valueButton(value: '5'),
              valueButton(value: '6'),
              iconButton(value: 'swap', icon: AntDesign.swap),
            ],
          ),
          TableRow(
            children: <Widget>[
              valueButton(value: '1'),
              valueButton(value: '2'),
              valueButton(value: '3'),
              valueButton(value: 'C'),
            ],
          ),
          TableRow(
            children: <Widget>[
              valueButton(value: '.'),
              valueButton(value: '0'),
              convProvider.categoryName == 'temperature'
                  ? valueButton(value: '+/-')
                  : valueButton(value: '00'),
              iconButton(
                  value: 'del', icon: MaterialCommunityIcons.backspace_outline),
            ],
          ),
        ],
      ),
    );
  }
}
