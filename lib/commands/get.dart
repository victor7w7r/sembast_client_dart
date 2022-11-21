import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> getRec(String key) async {

  final app = container.resolve<App>();

  if(app.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await app.storeRefInt!.record(int.parse(key)).get(app.db);
      if(recOp == null) {
        lang(15, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        print(pretty(recOp));
        app.pre = "";
      }
    } else {
      app.pre = green(":( ");
      lang(16, PrintQuery.error);
    }
  } else {
    final recOp = await app.storeRefStr!.record(key).get(app.db);
    if(recOp == null) {
      lang(15, PrintQuery.error);
      app.pre = green(":( ");
    } else {
      print(pretty(recOp));
      app.pre = "";
    }
  }
}