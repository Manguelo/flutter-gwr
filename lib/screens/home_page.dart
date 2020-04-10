import 'package:flutter/material.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_gwr/screens/player_page.dart';
import 'package:flutter_gwr/screens/widgets/listen_live_button.dart';
import 'package:flutter_gwr/screens/widgets/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
    print('\n\n\n\ndispose\n\n\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'God\'s Way Radio',
        ),
      ),
      drawer: Drawer(
        child: NavigationDrawer(),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_blur.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/radio_logo_info.png',
              ),
            ).paddingOnly(left: 70, right: 70),
            ListenLiveButton(
              title: 'LISTEN LIVE',
              action: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PlayerPage())),
            ).paddingFromLTRB(40, 100, 40, 125),
          ],
        ),
      ),
    );
  }
}
