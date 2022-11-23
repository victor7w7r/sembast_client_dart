import 'dart:io' show stdout, stdin;

import 'package:sembast_client_dart/app.dart';
import 'package:sembast_client_dart/directive.dart';

Future<void> main(List<String> args) async {

  setup();

  final app = locator.get<App>();
  await app.init(args);

  while(true) {
    stdout.write("\r${app.pre}036sembast${app.post}> ");
    final cmd = stdin.readLineSync()!.split(" ");
    await directive(cmd);
  }

}