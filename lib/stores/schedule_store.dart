import 'package:flutter_gwr/stores/root_store.dart';
import 'package:mobx/mobx.dart';

part 'schedule_store.g.dart';

class ScheduleStore = _ScheduleStore with _$ScheduleStore;

abstract class _ScheduleStore with Store {
  _ScheduleStore(this.rootStore);

  RootStore rootStore;
}
