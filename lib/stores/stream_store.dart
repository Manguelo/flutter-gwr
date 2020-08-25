import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_gwr/stores/root_store.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:volume_watcher/volume_watcher.dart';

part 'stream_store.g.dart';

class StreamStore = _StreamStore with _$StreamStore;

abstract class _StreamStore with Store {
  _StreamStore(this.rootStore);

  RootStore rootStore;

  @observable
  bool isPlaying = false;

  @observable
  AssetsAudioPlayer player = AssetsAudioPlayer();

  @observable
  double volume = 0.5;

  @observable
  String title = 'God\'s Way Radio';

  @observable
  String artist = '104.7 WAYG';

  int retryCount = 0;

  @action
  Future<void> initialize() async {
    final maxVol = await VolumeWatcher.getMaxVolume;
    volume = (await VolumeWatcher.getCurrentVolume) / maxVol;

    player.open(
      Audio.liveStream(
        'http://ic2.christiannetcast.com/wayg-fm',
        metas: Metas(
          id: 'gwr',
          title: 'God\'s Way Radio',
          artist: '104.7 WAYG',
          image: MetasImage.asset('assets/player_img.jpg'),
        ),
      ),
      showNotification: true,
    );

    isPlaying = true;
  }

  @action
  Future<void> play() async {
    if (isPlaying) {
      return;
    }
    try {
      isPlaying = true;
      player.play();
    } catch (ex) {
      Logger().e(ex);
      isPlaying = false;
    }
  }

  @action
  Future<void> pause() async {
    try {
      isPlaying = false;
      stopTimer();
      player.stop();
    } catch (ex) {
      Logger().e(ex);
    }
  }

  Future<AddressCheckResult> checkConnection() async {
    return await DataConnectionChecker().isHostReachable(
      AddressCheckOptions(
        InternetAddress('1.1.1.1'),
        port: 53,
        timeout: Duration(seconds: 1),
      ),
    );
  }

  void stopTimer() {
    title = 'God\'s Way Radio';
    artist = '104.7 WAYG';
    retryCount = 0;
  }
}
