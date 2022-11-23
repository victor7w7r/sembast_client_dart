import 'package:console/console.dart' show Console;
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/lang.dart';

Future<void> rmall() async {

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
    lang(41, PrintQuery.normal);
    return;
  }

  Console.write(lang(42));

  if(app.isIntKeys) {
    final keyType = Console.readLine()!;
    if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
      await app.storeRefInt!.delete(app.db);
      lang(43, PrintQuery.normal);
    }
  } else {
    final keyType = Console.readLine()!;
    if(keyType == "s" || keyType == "S" || keyType == "y" || keyType == "Y") {
      await app.storeRefStr!.delete(app.db);
      lang(43, PrintQuery.normal);
    }
  }
}