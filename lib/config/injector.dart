import 'package:kiwi/kiwi.dart';

import 'package:sembast_client_dart/config/app.dart';

part 'injector.g.dart';

final container = KiwiContainer();

void setup() {
  final injector = _$Injector();
  injector.configure();
}

abstract class Injector {
  @Register.singleton(App)
  void configure();
}