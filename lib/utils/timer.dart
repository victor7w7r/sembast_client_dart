import 'dart:async';

import 'package:console/console.dart';

void randomable(ShellPrompt shell) {
  Timer.periodic(Duration(seconds: 1), (t) {
    print("ASdds");
    shell.message = "\r${DateTime.now().toString()}";
  });
}