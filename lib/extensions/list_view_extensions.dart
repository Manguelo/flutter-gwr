import 'package:flutter/material.dart';

extension ListViewExtensions on ListView {
  Stack fadeEdge(double height) {
    return Stack(
      children: <Widget>[
        this,
        Positioned(
          right: 0,
          width: 8,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: const [0, 1],
                colors: [Colors.white, Colors.white.withOpacity(0)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
