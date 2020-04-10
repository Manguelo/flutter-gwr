import 'package:flutter/material.dart';
import 'package:flutter_gwr/extensions/container_extensions.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_gwr/theme.dart';

class ListenLiveButton extends StatelessWidget {
  const ListenLiveButton({this.title, this.action});

  final String title;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: gwrTheme.accentColor,
      onPressed: action,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: gwrTheme.primaryColor,
        ),
      ).paddingAll(15),
    ).clipRect(BorderRadius.circular(5));
  }
}
