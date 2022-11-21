import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import 'package:sembast_client_dart/config/index.dart';

Future<void> check(String store) async {

  final db = container.resolve<App>().db;

  StoreRef<int, Map<String, Object?>> storeRefInt;
  StoreRef<String, Map<String, Object?>> storeRefStr;

  List<Map<String,Object?>> listIntKeys = [];
  List<Map<String,Object?>> listStrKeys = [];

  await TaskEither.tryCatch(() async {
    storeRefInt = intMapStoreFactory.store(store);
    listIntKeys = (await storeRefInt.find(db)).map((sn) => sn.value).toList();
  }, (_, __) {}).run();

  await TaskEither.tryCatch(() async {
    storeRefStr = stringMapStoreFactory.store(store);
    listStrKeys = (await storeRefStr.find(db)).map((sn) => sn.value).toList();
  }, (_, __) {}).run();

  if(listIntKeys.isEmpty && listStrKeys.isEmpty) {
    lang(12, PrintQuery.normal, [store]);
  } else {
    if(listIntKeys.isNotEmpty) lang(13, PrintQuery.normal, [store, listIntKeys.length.toString()]);
    if(listStrKeys.isNotEmpty) lang(14, PrintQuery.normal, [store, listStrKeys.length.toString()]);
  }
}