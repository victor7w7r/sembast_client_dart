import 'dart:io' show Platform, File;

import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/lang.dart';
import 'package:sembast_client_dart/utils/index.dart';

Future<void> ls() async {

  final app = locator.get<App>();

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
    lang(37, PrintQuery.normal);
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
}