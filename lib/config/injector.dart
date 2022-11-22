import 'package:kiwi/kiwi.dart';

import 'package:sembast_client_dart/config/app.dart';

final container = KiwiContainer();

void setup() => container.registerSingleton((_) => App());
