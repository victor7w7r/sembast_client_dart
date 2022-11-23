import 'package:console/console.dart' show Console;
import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/lang.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> insert(String key) async {

  final app = locator.get<App>();

  if(app.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await app.storeRefInt!.record(int.parse(key)).get(app.db);
      if(recOp != null) {
        lang(31, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        final record = <String, dynamic>{};
        String keyVal = "";
        String value = "";
        while(keyVal != "*") {
          keyVal = "";
          value = "";
          while(keyVal == "") {
            Console.write(lang(32));
            keyVal = Console.readLine()!.trim();
            if(keyVal == "*") break;
            if(keyVal == "%") return;
            if(record.containsKey(keyVal) && keyVal != "") {
              lang(33, PrintQuery.error);
              keyVal = "";
            }
          }
          while(value == "" && keyVal != "*") {
            Console.write(lang(34));
            value = Console.readLine()!.trim();
          }
          if(keyVal != "*") record.addAll({keyVal: value});
        }
        await app.storeRefInt!.record(int.parse(key)).put(app.db, record);
        lang(35, PrintQuery.normal);
        app.pre = "";
      }
    } else {
      lang(36, PrintQuery.error);
      app.pre = green(":( ");
    }
  } else {
    final recOp = await app.storeRefStr!.record(key).get(app.db);
    if(recOp != null) {
      lang(31, PrintQuery.error);
      app.pre = green(":( ");
    } else {
      final record = <String, dynamic>{};
      String keyVal = "";
      String value = "";
      while(keyVal != "*") {
        keyVal = "";
        value = "";
        while(keyVal == "") {
          Console.write(lang(32));
          keyVal = Console.readLine()!.trim();
          if(keyVal == "*") break;
          if(keyVal == "%") return;
          if(record.containsKey(keyVal) && keyVal != "") {
            lang(33, PrintQuery.error);
            keyVal = "";
          }
        }
        while(value == "" && keyVal != "*") {
          Console.write(lang(34));
          value = Console.readLine()!.trim();
        }
        if(keyVal != "*") record.addAll({keyVal: value});
      }
      await app.storeRefStr!.record(key).put(app.db, record);
      lang(35, PrintQuery.normal);
      app.pre = "";
    }
  }
}