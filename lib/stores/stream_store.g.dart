// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StreamStore on _StreamStore, Store {
  final _$isPlayingAtom = Atom(name: '_StreamStore.isPlaying');

  @override
  bool get isPlaying {
    _$isPlayingAtom.context.enforceReadPolicy(_$isPlayingAtom);
    _$isPlayingAtom.reportObserved();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.context.conditionallyRunInAction(() {
      super.isPlaying = value;
      _$isPlayingAtom.reportChanged();
    }, _$isPlayingAtom, name: '${_$isPlayingAtom.name}_set');
  }

  final _$playerAtom = Atom(name: '_StreamStore.player');

  @override
  AssetsAudioPlayer get player {
    _$playerAtom.context.enforceReadPolicy(_$playerAtom);
    _$playerAtom.reportObserved();
    return super.player;
  }

  @override
  set player(AssetsAudioPlayer value) {
    _$playerAtom.context.conditionallyRunInAction(() {
      super.player = value;
      _$playerAtom.reportChanged();
    }, _$playerAtom, name: '${_$playerAtom.name}_set');
  }

  final _$volumeAtom = Atom(name: '_StreamStore.volume');

  @override
  double get volume {
    _$volumeAtom.context.enforceReadPolicy(_$volumeAtom);
    _$volumeAtom.reportObserved();
    return super.volume;
  }

  @override
  set volume(double value) {
    _$volumeAtom.context.conditionallyRunInAction(() {
      super.volume = value;
      _$volumeAtom.reportChanged();
    }, _$volumeAtom, name: '${_$volumeAtom.name}_set');
  }

  final _$titleAtom = Atom(name: '_StreamStore.title');

  @override
  String get title {
    _$titleAtom.context.enforceReadPolicy(_$titleAtom);
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.conditionallyRunInAction(() {
      super.title = value;
      _$titleAtom.reportChanged();
    }, _$titleAtom, name: '${_$titleAtom.name}_set');
  }

  final _$artistAtom = Atom(name: '_StreamStore.artist');

  @override
  String get artist {
    _$artistAtom.context.enforceReadPolicy(_$artistAtom);
    _$artistAtom.reportObserved();
    return super.artist;
  }

  @override
  set artist(String value) {
    _$artistAtom.context.conditionallyRunInAction(() {
      super.artist = value;
      _$artistAtom.reportChanged();
    }, _$artistAtom, name: '${_$artistAtom.name}_set');
  }

  final _$initializeAsyncAction = AsyncAction('initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$playAsyncAction = AsyncAction('play');

  @override
  Future<void> play() {
    return _$playAsyncAction.run(() => super.play());
  }

  final _$pauseAsyncAction = AsyncAction('pause');

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  @override
  String toString() {
    final string =
        'isPlaying: ${isPlaying.toString()},player: ${player.toString()},volume: ${volume.toString()},title: ${title.toString()},artist: ${artist.toString()}';
    return '{$string}';
  }
}
