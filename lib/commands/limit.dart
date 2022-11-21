import 'dart:io';

import 'package:dcli/dcli.dart' show green;
import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> limit(String start, String end) async {

  final app = container.resolve<App>();

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  if(isNumeric(start) && isNumeric(end)) {
    if(int.parse(end) > int.parse(start)) {
      app.isIntKeys
        ? listIntKeys = await Task(() => app.storeRefInt!.find(app.db))
          .map((lsn) => IO(lsn.map((sn) => sn.value).toList)
            .map((ls) => Either.tryCatch(
                () => ls.sublist(int.parse(start), int.parse(end)),
                (e, _) => e
              ).getOrElse((_) => ls))
            .run()
          ).run()
        : listStrKeys = await Task(() => app.storeRefStr!.find(app.db))
          .map((lsn) => IO(lsn.map((sn) => sn.value).toList)
            .map((ls) => Either.tryCatch(
                () => ls.sublist(int.parse(start), int.parse(end)),
                (e, _) => e
              ).getOrElse((_) => ls))
            .run()
          ).run();
      if(listIntKeys.isEmpty && listStrKeys.isEmpty) {
        lang(37, PrintQuery.normal);
        app.pre = "";
        return;
      }
      if(app.isIntKeys && listIntKeys.isNotEmpty) {
        if(!Platform.isWindows && listIntKeys.length > 2) {
          final file = File("temp.json");
          file.writeAsStringSync(pretty(listIntKeys));
          await syscall('cat temp.json | less');
          file.deleteSync();
        } else {
          print(pretty(listIntKeys));
        }
      } else {
        if(!Platform.isWindows  && listStrKeys.length > 2) {
          final file = File("temp.json");
          file.writeAsStringSync(pretty(listStrKeys));
          await syscall('cat temp.json | less');
          file.deleteSync();
        } else {
          print(pretty(listStrKeys));
        }
      }
    } else {
      lang(53, PrintQuery.error);
      app.pre = green(":( ");
    }
  } else {
    lang(52, PrintQuery.error);
    app.pre = green(":( ");
  }
}