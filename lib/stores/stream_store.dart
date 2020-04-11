import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
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

  int retryCount = 0;

  Timer timer;

  // Track is invalid or is loading and user pressed play
  bool isLoading(dynamic args) =>
      args?.value['status'] == 'loading' &&
      isPlaying &&
      !(timer?.isActive ?? false);

  @action
  Future<void> initialize() async {
    player.initialize();
    isPlaying = true;
    setNotifications(artist, title);

    // Listen for events
    player.off('status', (eventname, {args}) => null);
    player.on(
      'status',
      (eventname, {args}) async {
        final connection = await checkConnection();
        if (!connection.isSuccess && player.isPlaying) {
          startTimer();
          // Invalid track or is loading
        } else if (isLoading(args)) {
          title = 'Loading...';
          artist = '104.7 WAYG';
          startTimer();
          // Is playing
        } else if (args?.value['status'] == 'playing') {
          title = 'God\'s Way Radio';
          artist = '104.7 WAYG';
          if (!isPlaying) {
            startTimer();
          } else {
            stopTimer();
          }
          // Is paused and user pressed play
        } else if (args?.value['status'] == 'paused' && isPlaying) {
          startTimer();
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
      stopTimer();
      player.pause();
    } catch (ex) {
      Logger().e(ex);
    }
  }

  @action
  Future<void> setNotifications(String ablum, String title) async {
    if (isBusy) {
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
              album: '104.7 WAYG',
              artist: "",
              assetUrl: 'http://ic2.christiannetcast.com/wayg-fm',
              title: 'God\'s Way Radio'),
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

  Future<void> startTimer({int seconds = 5}) async {
    var hasConnection = await checkConnection();
    if (!(timer?.isActive ?? false))
      timer = Timer.periodic(Duration(seconds: seconds), (t) async {
        // Connection is poor or connection was poor
        if (!hasConnection.isSuccess || title == 'Loading...') {
          title = 'Loading...';
          artist = 'Poor network connection';
          isPlaying = true;
          setNotifications(artist, title);

          if (retryCount >= 3) {
            timer.cancel();
            startTimer(seconds: 15);
          }
          retryCount += 1;
        }
        hasConnection = await checkConnection();
      });
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
    timer.cancel();
    title = 'God\'s Way Radio';
    artist = '104.7 WAYG';
    retryCount = 0;
  }
}
