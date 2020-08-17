import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gwr/app_config.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';

class AudioControl extends StatelessWidget {
  const AudioControl();

  @override
  Widget build(BuildContext context) {
    final store = AppConfig.of(context).rootStore.streamStore;
    final primaryColor = Theme.of(context).primaryColor;

    return StreamBuilder<Object>(
      stream: store.player.isPlaying,
      builder: (context, snap) {
        final isPlaying = snap?.data ?? false;
        store.isPlaying = isPlaying;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(
                Icons.play_circle_outline,
                color: isPlaying ? primaryColor.withAlpha(50) : primaryColor,
              ),
              onPressed: isPlaying ? null : () => store.play(),
            ).paddingOnly(right: 5),
            IconButton(
              iconSize: 50,
              icon: Icon(
                Icons.pause_circle_outline,
                color: !isPlaying ? primaryColor.withAlpha(50) : primaryColor,
              ),
              onPressed: !isPlaying ? null : () => store.pause(),
            ).paddingOnly(right: 5)
          ],
        );
      },
    ).paddingOnly(bottom: 20);
  }
}
