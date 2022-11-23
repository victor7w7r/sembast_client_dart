import 'package:console/console.dart' show Console;
import 'package:dcli/dcli.dart' show green;
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/lang.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> update(String key) async {

  final app = locator.get<App>();

  if(app.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await app.storeRefInt!.record(int.parse(key)).get(app.db);
      if(recOp == null) {
        lang(15, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        String keyVal = "";
        String value = "";
        while(keyVal == "") {
          Console.write(lang(45));
          keyVal = Console.readLine()!.trim();
          if(keyVal == "%") return;
          if(!recOp.containsKey(keyVal) && keyVal != "") {
            lang(46, PrintQuery.error);
            keyVal = "";
          }
        }
        while(value == "") {
          Console.write(lang(34));
          value = Console.readLine()!.trim();
        }
        await app.storeRefInt!.record(int.parse(key)).update(app.db, {keyVal: value});
        lang(44, PrintQuery.normal);
        app.pre = "";
      }
    } else {
      lang(16, PrintQuery.error);
      app.pre = green(":( ");
    }
  } else {
    final recOp = await app.storeRefStr!.record(key).get(app.db);
    if(recOp == null) {
      lang(15, PrintQuery.error);
      app.pre = green(":( ");
    } else {
      String keyVal = "";
      String value = "";
      while(keyVal == "") {
        Console.write(lang(45));
        keyVal = Console.readLine()!.trim();
        if(keyVal == "%") return;
        if(!recOp.containsKey(keyVal) && keyVal != "") {
          lang(46, PrintQuery.error);
          keyVal = "";
        }
      }
      while(value == "") {
        Console.write(lang(34));
        value = Console.readLine()!.trim();
      }
      await app.storeRefStr!.record(key).update(app.db, {keyVal: value});
      lang(44, PrintQuery.normal);
      app.pre = "";
    }
  }
}