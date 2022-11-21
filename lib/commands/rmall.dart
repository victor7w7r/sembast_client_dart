import 'dart:io' show stdout, stdin;

import 'package:dcli/dcli.dart' show green;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';

Future<void> rmall() async {

  final app = container.resolve<App>();

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  app.isIntKeys
    ? listIntKeys = (await app.storeRefInt!.find(app.db))
      .map((sn) => sn.value)
      .toList()
    : listStrKeys = (await app.storeRefStr!.find(app.db))
      .map((sn) => sn.value)
      .toList();

  if(listIntKeys.isEmpty && listStrKeys.isEmpty) {
    lang(41, PrintQuery.normal);
    return;
  }

  stdout.write(lang(42));

  if(app.isIntKeys) {
    final keyType = stdin.readLineSync()!;
    if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
      await app.storeRefInt!.delete(app.db);
      lang(43, PrintQuery.normal);
    }
  } else {
    final keyType = stdin.readLineSync()!;
    if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
      await app.storeRefStr!.delete(app.db);
      lang(43, PrintQuery.normal);
    }
  }
}