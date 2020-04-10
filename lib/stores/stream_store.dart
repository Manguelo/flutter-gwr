import 'dart:async';
import 'dart:io';

import 'package:flutter_gwr/stores/root_store.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
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
  bool isBusy = false;

  @observable
  RmxAudioPlayer player = new RmxAudioPlayer();

  @observable
  double volume = 0.5;

  @observable
  String title = 'God\'s Way Radio';

  @observable
  String artist = '104.7 WAYG';

  Timer timer;

  @action
  Future<void> initialize() async {
    player.initialize();
    isPlaying = true;
    setNotifications(artist, title);
    player.off('status', (eventname, {args}) => null);
    player.on(
      'status',
      (eventname, {args}) async {
        if (args?.value['status'] == 'paused' && isPlaying && !isBusy) {
          title = 'Loading...';
          artist = '104.7 WAYG';
          startTimer();
        } else if (args?.value['status'] == 'playing') {
          title = 'God\'s Way Radio';
          artist = '104.7 WAYG';
          stopTimer();
        }
      },
    );
  }

  @action
  Future<void> play() async {
    try {
      isPlaying = true;
      setNotifications(artist, title);
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
      player.pause();
    } catch (ex) {
      Logger().e(ex);
    }
  }

  @action
  Future<void> setNotifications(String ablum, String title) async {
    if (isBusy && !isPlaying) {
      return;
    }

    isBusy = true;
    try {
      await player.setPlaylistItems(
        [
          new AudioTrack(
              trackId: 'gods_way_radio_104.7',
              isStream: true,
              albumArt:
                  'https://godswayradio.com/wp-content/uploads/2015/06/miami_skyline-wallpaper-1920x1440-5.jpg',
              album: ablum,
              artist: "",
              assetUrl: 'http://ic2.christiannetcast.com/wayg-fm',
              title: title),
        ],
        options: new PlaylistItemOptions(startPaused: false),
      );
    } catch (ex) {
      Logger().e(ex);
    } finally {
      isBusy = false;
    }
  }

  @action
  Future<void> setVolume(double volume) async {
    this.volume = volume;
    player.setVolume(1);
    final maxVol = await VolumeWatcher.getMaxVolume;
    final vol = (maxVol * volume);
    VolumeWatcher.setVolume(vol);
  }

  void startTimer() {
    if (!(timer?.isActive ?? false))
      timer = Timer.periodic(Duration(seconds: 3), (t) {
        setNotifications(artist, title);
      });
  }

  void stopTimer() {
    timer.cancel();
  }
}
