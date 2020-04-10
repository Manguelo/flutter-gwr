import 'package:flutter_gwr/stores/schedule_store.dart';
import 'package:flutter_gwr/stores/stream_store.dart';
import 'package:mobx/mobx.dart';

part 'root_store.g.dart';

class RootStore = _RootStore with _$RootStore;

abstract class _RootStore with Store {
  _RootStore() {
    scheduleStore = ScheduleStore(this);
    streamStore = StreamStore(this);
  }

  ScheduleStore scheduleStore;

  StreamStore streamStore;
}
