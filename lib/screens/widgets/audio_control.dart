import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gwr/app_config.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AudioControl extends StatelessWidget {
  const AudioControl();

  @override
  Widget build(BuildContext context) {
    final store = AppConfig.of(context).rootStore.streamStore;
    final primaryColor = Theme.of(context).primaryColor;

    return Observer(
      builder: (_) {
        final isPlaying = store.isPlaying;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(
                Icons.play_circle_outline,
                color: isPlaying ? primaryColor.withAlpha(50) : primaryColor,
              ),
              onPressed: () => store.play(),
            ).paddingOnly(right: 5),
            IconButton(
              iconSize: 50,
              icon: Icon(
                Icons.pause_circle_outline,
                color: !isPlaying ? primaryColor.withAlpha(50) : primaryColor,
              ),
              onPressed: () => store.pause(),
            ).paddingOnly(right: 5)
          ],
        );
      },
    ).paddingOnly(bottom: 20);
  }
}
