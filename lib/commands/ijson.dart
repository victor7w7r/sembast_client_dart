import 'dart:convert' show jsonDecode;
import 'dart:io' show stdout, stdin;

import 'package:dcli/dcli.dart' show green;
import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> ijson(String key) async {

  final app = container.resolve<App>();

  if(app.isIntKeys) {
    if(isNumeric(key)) {
      final recOp = await app.storeRefInt!.record(int.parse(key)).get(app.db);
      if(recOp != null) {
        lang(28, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        stdout.write("JSON: ");
        final jsonEl = stdin.readLineSync()!.trim();
        if(jsonEl.startsWith('{') && jsonEl.endsWith('}')) {
          await TaskEither.tryCatch(IO(() => jsonEl.replaceAll("'", '"'))
            .map((jsonFiltered) => jsonDecode(jsonFiltered))
            .map((record) async {
              lang(29, PrintQuery.normal);
              app.pre = "";
              return await app.storeRefInt!.record(int.parse(key)).put(app.db, record);
            }
          ).run, (_, __) {
            lang(30, PrintQuery.error);
            app.pre = green(":( ");
          }).run();
        } else if(jsonEl == "") {
        } else {
          lang(30, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
    } else {
      lang(36, PrintQuery.error);
      app.pre = green(":( ");
    }
  } else {
    final recOp = await app.storeRefStr!.record(key).get(app.db);
    if(recOp != null) {
      lang(28, PrintQuery.error);
      app.pre = green(":( ");
    } else {
      stdout.write("JSON: ");
      final jsonEl = stdin.readLineSync()!.trim();
      if(jsonEl.startsWith('{') && jsonEl.endsWith('}')) {
        await TaskEither.tryCatch(IO(() => jsonEl.replaceAll("'", '"'))
          .map((jsonFiltered) => jsonDecode(jsonFiltered))
          .map((record) async {
            lang(29, PrintQuery.normal);
            app.pre = "";
            return await app.storeRefStr!.record(key).put(app.db, record);
          }
        ).run, (_, __) {
          lang(30, PrintQuery.error);
          app.pre = green(":( ");
        }).run();
      } else if(jsonEl == "") {
      } else {
        lang(30, PrintQuery.error);
        app.pre = green(":( ");
      }
    }
  }
}