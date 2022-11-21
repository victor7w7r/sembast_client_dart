import 'dart:io' show stdout, stdin;

import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> insert(String key) async {

  final app = container.resolve<App>();

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
            stdout.write(lang(32));
            keyVal = stdin.readLineSync()!.trim();
            if(keyVal == "*") break;
            if(keyVal == "%") return;
            if(record.containsKey(keyVal) && keyVal != "") {
              lang(33, PrintQuery.error);
              keyVal = "";
            }
          }
          while(value == "" && keyVal != "*") {
            stdout.write(lang(34));
            value = stdin.readLineSync()!.trim();
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
          stdout.write(lang(32));
          keyVal = stdin.readLineSync()!.trim();
          if(keyVal == "*") break;
          if(keyVal == "%") return;
          if(record.containsKey(keyVal) && keyVal != "") {
            lang(33, PrintQuery.error);
            keyVal = "";
          }
        }
        while(value == "" && keyVal != "*") {
          stdout.write(lang(34));
          value = stdin.readLineSync()!.trim();
        }
        if(keyVal != "*") record.addAll({keyVal: value});
      }
      await app.storeRefStr!.record(key).put(app.db, record);
      lang(35, PrintQuery.normal);
      app.pre = "";
    }
  }
}