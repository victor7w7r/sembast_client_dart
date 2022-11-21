import 'dart:io' show stdout, stdin;

import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/number.dart';

Future<void> rm(String key) async {

  final app = container.resolve<App>();

  if(app.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await app.storeRefInt!.record(int.parse(key)).get(app.db);
      if(recOp == null) {
        lang(38, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        stdout.write(lang(39));
        final keyType = stdin.readLineSync()!;
        if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
          await app.storeRefInt!.record(int.parse(key)).delete(app.db);
          lang(40, PrintQuery.normal);
        }
      }
    } else {
      lang(36, PrintQuery.error);
      app.pre = green(":( ");
    }
  } else {
    final recOp = await app.storeRefStr!.record(key).get(app.db);
    if(recOp == null) {
      lang(38, PrintQuery.error);
      app.pre = green(":( ");
    } else {
      stdout.write(lang(39));
      final keyType = stdin.readLineSync()!;
      if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
        await app.storeRefStr!.record(key).delete(app.db);
        lang(40, PrintQuery.normal);
      }
    }
  }
}