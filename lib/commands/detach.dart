import 'package:fpdart/fpdart.dart' show IO;

import 'package:sembast_client_dart/config/index.dart';

void detach() => IO(() => container.resolve<App>())
  .map((app) {
    app.post = "";
    app.storeRefInt = null;
    app.storeRefStr = null;
  })
  .run();

