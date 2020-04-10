import 'package:flutter/material.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_gwr/screens/web_view.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem(this.color, this.image, this.title, this.url);

  final Color color;
  final String image;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(url: url, title: title),
            fullscreenDialog: true,
          ),
        ),
        child: Container(
          height: 70,
          color: color,
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                child: Image.asset(image).paddingOnly(left: 20, right: 30),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
