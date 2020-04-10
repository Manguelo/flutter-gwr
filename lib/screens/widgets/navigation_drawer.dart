import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gwr/extensions/container_extensions.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_gwr/screens/widgets/drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          Text(
            'Social Links',
            style: TextStyle(
              fontSize: 20,
            ),
          ).paddingOnly(bottom: 20, top: 5),
          DrawerItem(Color(0xff3A5A99), 'assets/Facebook.png', 'Facebook',
              'https://www.facebook.com/GodsWayRadio/'),
          DrawerItem(Color(0xff517EA3), 'assets/Instagram.png', 'Instagram',
              'https://twitter.com/godswayradio'),
          DrawerItem(Color(0xff55ACEE), 'assets/Twitter.png', 'Twitter',
              'https://www.instagram.com/godswayradio/?hl=en'),
          if (!Platform.isAndroid)
            DrawerItem(Color(0xffE52D27), 'assets/YouTube.png', 'YouTube',
                'https://www.youtube.com/channel/UCHRWISEfus-AHDcizhlIUcA'),
          Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: Text(
              '"As for God, Hid way is perfect, the word of the LORD os proven; He is a shield to all those who trust in Him." - Psalm 18:30',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ).paddingOnly(left: 30, right: 30),
          ).expanded()
        ],
      ),
    );
  }
}
