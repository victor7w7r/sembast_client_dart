import 'package:fpdart/fpdart.dart' show IO;

import 'package:sembast_client_dart/app.dart';

void detach() => IO(() => locator.get<App>())
  .map((app) {
    app.post = "";
    app.storeRefInt = null;
    app.storeRefStr = null;
  })
  .run();

