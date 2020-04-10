import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gwr/app_config.dart';
import 'package:flutter_gwr/screens/home_page.dart';
import 'package:flutter_gwr/stores/root_store.dart';
import 'package:flutter_gwr/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final configuredApp = AppConfig(
    rootStore: RootStore(),
    child: MyApp(),
  );

  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Database',
      debugShowCheckedModeBanner: false,
      theme: gwrTheme,
      home: HomePage(),
    );
  }
}
