import 'package:dcli/dcli.dart' show orange;

import 'package:sembast_client_dart/lang.dart';

void help() {
  print("");
  print("");
  print(" ${orange('check <store>')}${lang(17)}");
  print(" ${orange('use <store>')}${lang(18)}");
  print("");
  print(" ${orange('ls')}${lang(19)}");
  print(" ${orange('get <key>')}${lang(20)}");
  print(" ${orange('insert <key>')}${lang(21)}");
  print(" ${orange('ijson <key>')}${lang(22)}");
  print(" ${orange('limit <start> <end>')}${lang(50)}");
  print(" ${orange('update <key>')}${lang(23)}");
  print(" ${orange('ujson <key>')}${lang(24)}");
  print(" ${orange('rm <key>')}${lang(25)}");
  print(" ${orange('rmall')}${lang(26)}");
  print(" ${orange('detach')}${lang(27)}");
  print("");
  print("");
}