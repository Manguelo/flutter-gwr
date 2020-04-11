import 'package:flutter/material.dart';
import 'package:flutter_gwr/app_config.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_gwr/screens/widgets/audio_control.dart';
import 'package:flutter_gwr/stores/stream_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  StreamStore store;
  SpinKitWave animation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      store = AppConfig.of(context).rootStore.streamStore;
      store.initialize();
    });
  }

  @override
  void dispose() {
    animation.controller.dispose();
    super.dispose();
  }

//2400
  @override
  Widget build(BuildContext context) {
    final store = AppConfig.of(context).rootStore.streamStore;
    final primaryColor = Theme.of(context).primaryColor;
    final imagePadding =
        (MediaQuery.of(context).size.height <= 600 ? 100 : 75).toDouble();
    animation = SpinKitWave(
      color: Theme.of(context).accentColor,
      size: 23.0,
      controller: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: primaryColor,
        title: Text(
          'God\'s Way Radio',
        ),
        actions: <Widget>[animation.paddingOnly(right: 15)],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_blur.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/radio_logo_info.png',
              ),
            ).paddingFromLTRB(imagePadding, 40, imagePadding, 25),
            AudioControl(),
            Observer(
              builder: (_) {
                final isBusy = store.isPlaying;
                isBusy
                    ? animation.controller.repeat()
                    : animation.controller.stop();
                return Slider(
                  value: store.volume,
                  onChanged: (val) => store.setVolume(val),
                );
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  store.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ).paddingOnly(top: 25);
              },
            ),
            Observer(
              builder: (_) {
                return Text(
                  store.artist,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ).paddingOnly(top: 10);
              },
            ),
          ],
        ),
      ),
    );
  }
}
