import 'dart:io';

import 'package:dcli/dcli.dart';

Future<int> syscall(String cmd) async =>
  waitForEx(Process.start(
    'bash', ["-c", cmd],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio
  )).exitCode;

void clear() => Terminal().clearScreen();