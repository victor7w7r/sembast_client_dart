import 'package:console/console.dart' show Console;
import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/lang.dart';

Future<void> use(String store) async {

  final app = locator.get<App>();

  StoreRef<int, Map<String, Object?>> storeRefInt;
  StoreRef<String, Map<String, Object?>> storeRefStr;

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  bool storeInt = true;
  bool storeStr = true;

  await TaskEither.tryCatch(() async {
    storeRefInt = intMapStoreFactory.store(store);
    listIntKeys = (await storeRefInt.find(app.db)).map((sn) => sn.value).toList();
  }, (_, __) => storeInt = false).run();

  await TaskEither.tryCatch(() async {
    storeRefStr = stringMapStoreFactory.store(store);
    listStrKeys = (await storeRefStr.find(app.db)).map((sn) => sn.value).toList();
  }, (_, __) => storeStr = false).run();

  if(storeInt && storeStr) {
    lang(47, PrintQuery.inline);
    final keyType = Console.readLine()!;
    if(keyType == "int") {
      app.storeSelector(store, storeInt: intMapStoreFactory.store(store));
    } else if(keyType == "str") {
      app.storeSelector(store, storeStr: stringMapStoreFactory.store(store));
    }
  } else {
    if(storeInt) {
      lang(48, PrintQuery.normal, [listIntKeys.length.toString()]);
      app.storeSelector(store, storeInt: intMapStoreFactory.store(store));
    } else if(storeStr) {
      lang(49, PrintQuery.normal, [listStrKeys.length.toString()]);
      app.storeSelector(store, storeStr: stringMapStoreFactory.store(store));
    }
  }
}