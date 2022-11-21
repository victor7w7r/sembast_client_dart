import 'dart:io' show exit;

import 'package:dcli/dcli.dart' show green;

import 'package:sembast_client_dart/config/index.dart';
import 'package:sembast_client_dart/commands/index.dart';
import 'package:sembast_client_dart/utils/commands.dart';

Future<void> directive(List<String> cmd) async {

  final app = container.resolve<App>();

  switch(cmd[0]) {

    case "": break;

    case "clear":
      clear();
      app.pre = "";
      break;

    case "check":
      if(cmd.length != 1 && cmd[1] != "") {
        await check(cmd[1].trim());
        app.pre = "";
      } else {
        lang(8, PrintQuery.error);
        app.pre = green(":( ");
      }
      break;

    case "detach":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        detach();
        app.pre = "";
      }
      break;

    case "get":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await getRec(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "ijson":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await ijson(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "insert":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await insert(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "ls":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        await ls();
        app.pre = "";
      }
      break;

    case "limit":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length == 3) {
          await limit(cmd[1].trim(), cmd[2].trim());
        } else {
          lang(51, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "rm":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await rm(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "ujson":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await ujson(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "update":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        if(cmd.length != 1 && cmd[1] != "") {
          await update(cmd[1].trim());
        } else {
          lang(10, PrintQuery.error);
          app.pre = green(":( ");
        }
      }
      break;

    case "rmall":
      if(app.storeRefInt == null && app.storeRefStr == null) {
        lang(9, PrintQuery.error);
        app.pre = green(":( ");
      } else {
        await rmall();
        app.pre = "";
      }
      break;

    case "use":
      if(cmd.length != 1 && cmd[1] != "") {
        await use(cmd[1].trim());
        app.pre = "";
      } else {
        lang(8, PrintQuery.error);
        app.pre = green(":( ");
      }
      break;

    case "help":
      help();
      app.pre = "";
      break;

    case "exit": exit(0);

    default:
      lang(11, PrintQuery.error, [cmd[0]]);
      app.pre = green(":( ");
  }
}