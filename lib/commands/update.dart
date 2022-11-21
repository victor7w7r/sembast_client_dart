import 'dart:io' show stdout, stdin;

import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> update(String key) async {

  final app = container.resolve<App>();

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
          stdout.write(lang(45));
          keyVal = stdin.readLineSync()!.trim();
          if(keyVal == "%") return;
          if(!recOp.containsKey(keyVal) && keyVal != "") {
            lang(46, PrintQuery.error);
            keyVal = "";
          }
        }
        while(value == "") {
          stdout.write(lang(34));
          value = stdin.readLineSync()!.trim();
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
        stdout.write(lang(45));
        keyVal = stdin.readLineSync()!.trim();
        if(keyVal == "%") return;
        if(!recOp.containsKey(keyVal) && keyVal != "") {
          lang(46, PrintQuery.error);
          keyVal = "";
        }
      }
      while(value == "") {
        stdout.write(lang(34));
        value = stdin.readLineSync()!.trim();
      }
      await app.storeRefStr!.record(key).update(app.db, {keyVal: value});
      lang(44, PrintQuery.normal);
      app.pre = "";
    }
  }
}