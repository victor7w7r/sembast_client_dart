import 'dart:io';

import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan, green;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:fpdart/fpdart.dart' show IO, TaskEither;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:sembast_client_dart/lang.dart';
import 'package:sembast_client_dart/utils/index.dart';

final locator = GetIt.instance;

void setup() => GetIt.I.registerSingleton<App>(App());

class App {

  late final Database db;

  StoreRef<int, Map<String, Object?>>? storeRefInt;
  StoreRef<String, Map<String, Object?>>? storeRefStr;

  bool isIntKeys = false;
  bool english = false;
  String pre = "";
  String post = "";

  void storeSelector(String storeName, {
    StoreRef<int, Map<String, Object?>>? storeInt,
    StoreRef<String, Map<String, Object?>>? storeStr
  }) {
    if(storeInt != null) {
      post = cyan(" ($storeName #)");
      storeRefInt = storeInt;
      isIntKeys = true;
    } else if(storeStr != null) {
      post = cyan(" ($storeName ~)");
      storeRefStr = storeStr;
      isIntKeys = false;
    }
  }

  Future<void> init(List<String> args) async {

    String password = "";
    late SembastCodec codec;

    clear();
    print(green("Bienvenido / Welcome"));
    print(cyan("Please, choose your language / Por favor selecciona tu idioma"));

    IO(Chooser<String>(['English', 'Espanol'], message: 'Number/Numero: ').chooseSync)
      .map((selection) => selection == "English" ? english = true : english = false)
      .run();

    clear();
    cover();

    if(args.isEmpty) {
      lang(0, PrintQuery.error);
      exit(1);
    }

    final dbFile = File(args[0]);

    if(!dbFile.existsSync()) {
      lang(1, PrintQuery.error);
      exit(1);
    }

    final lines = dbFile.readAsLinesSync();

    if(lines.isEmpty) {
      lang(2, PrintQuery.error);
      exit(1);
    }

    if(!lines.first.contains(',"sembast":')) {
      lang(3, PrintQuery.error);
      exit(1);
    }

    if(lines.first.contains(',"codec":')) {
      stdin.echoMode = false;

      do {
        stdout.write(lang(4));
        password = stdin.readLineSync()!;
        codec = sembastCodec(password: password);
        stdout.write("\n");
      } while(password == "");

      await TaskEither.tryCatch(() async {
        stdout.write("\n");
        stdin.echoMode = true;
        db = await databaseFactoryIo.openDatabase(args[0], codec: codec);
      }, (e, _) {
        lang(5, PrintQuery.error);
        exit(1);
      }).run();

    } else {
      db = await databaseFactoryIo.openDatabase(args[0]);
    }
  }

  void cover() {
    clear();
    print('                                    `"~>v??*^;rikD&MNBQku*;`                                           ');
    print('                                `!{wQNWWWWWWWWWWWWWWWNWWWWWWNdi^`                                       ');
    print('                              .v9NWWWWNRFmWWWWWWWWWWWWga?vs0pNWWWMw!                                    ');
    print('                            !9WWWWWWU>`>&WWWWWWUH!_JNWWWWWQz  ^EWWWWg|                                  ');
    print('                           _SWWWWWNe: /RWWWWWWNNHBRuyix&WWWWWg2?-"VNWWW6_                              ');
    print('                         "kWWWWWNz. .zNWWWWWWw=, ^NsLQNW**MWWWW&WQJuNWWWNr.                            ');
    print('                       .FNWWWWNu. rL&WWWWWWg!!*;^Jo!*BN0aFx)>|!;;;;;!~/r)xFwaao?|,                      ');
    print('                     .sNWWWWMi` -,#WWWWWWNi"` Siwu UWv  .;^|^;`               .!*lUSF*;                ');
    print('                    )BWWWWWo.   9NWWWWWW0; ;PvLc*aU&^ |L=-``.;>*=                   ;)wmkL_             ');
    print('                  _QWWWWWq"   .aWWWWWWWs`  rF<>/^gQ, /i   ,;;.  !2                      ,*k0F/`        ');
    print('                 *NWWWWNv   ,/&WWWWWWNr "!SL92l)BU.  ^x   x. L,  I_                        `>P&F;      ');
    print('               `2WWWWWg;    !BWWWWWWD"   .s;!/xNa     /L,   !L`  P,                           .?&gr     ');
    print('              ,QWWWWWS`  >;LWWWWWWWk`_;!/u|  ^Ml        ;~!^,  `iv                              `?Ng^   ');
    print('             ^BWWWWWi   *i7NWWWWWWc "a;;?ii"~NV             `;?},                                 ,9WF  ');
    print('            >WWWWWB!  ` ;8WWWWWWM=  r>`;F/2wNc          .;||!,                                      oW#.');
    print('           ?WWWWW#"  `2;7NWWWWW&_ =_=u%ir`>Wi                                                        PW6');
    print('          rWWWWWc   `||>WWWWWWU.  r^?7;!v*W)                                                         ,WW|');
    print('         ^NWWWB!  ! /jrmWWWWWw  `vL.k*/vkW\$>rr*r;`        ;rL{7)>!`                                   mWF');
    print('         .BWWW\$,   ,u. PWWWWW) ,r`)|)!__LWv     `;L"     |s>:```._|JuL                                 qWE');
    print('        uWWWH` .vi"Fo*WWWWN>   ^v  r*`>W}                                                             &Ws ');
    print('        ;WWWP`  `=*ox_pWWWB; ^)i`9xr,#7W*            .     ,/*`                                       |WW!');
    print('       SWWD` >LLr^_y*NWWQ"  ,<?P~|iF0W}            ~;   v_ `o;                                      .0WU');
    print('      ^WW0,.!F2xULFi5WW0` >7vr!!z_`*Wv             `|;;^!,~!`                                      .8W8.');
    print('      dWN;`>JyrkIr`!NWN! ,uFia!9?*2WI                                                             ;QWD.');
    print('     =WW7`_S)~Fxv| xWWi ;}drqa=;=uWRNmL,                                                         rWWt`');
    print('     DWP`;LiL;}c*rsWW&`,Po_e7L/ =Nc `>oD\$aawTouic7)*r>=|^^~!;;;;;;;;;;;;;~^/>rvL{JctxiiiiuusoF2kgBS/ ');
    print('    ;WN\\Uy>*rF.,pWWWr-;?J}"vov^^Nu         `.,"_;!~^/=>r*v?LL{}Jjjjjjj}}7?vr>/^!;____-""",,,..``    ');
    print('    iW?_**>^;>"~&EeWg=|liv*s!~?NL');
    print('    wWc*\$>*~~L6Ni QW! /Uursx >WJ');
    print('    2M)o*_F "R0; .Wd~U7,``;*iN>');
    print('    xWe?vI7cMu`  ,W&>xssr~=PB|');
    print('    "WY ,cBZ_    `M2l//i,,QQ,');
    print('     |U\$di_       UBu>i)yBy`');
    print('                  ^Wx,rDR!');
    print('                   /ZUl^');
    print('.oPYo. .oPYo. .pPYo.   .oPYo.                       o   o                 .oPYo.   o              8  o                ');
    print('8  .o8     `8 8        8    8                       8                     8        8              8                   ');
    print('8 .P`8   .oP` 8oPYo.   8      oPYo. .oPYo. .oPYo.  o8P o8 o    o .oPYo.   `Yooo.  o8P o    o .oPYo8 o8 .oPYo. .oPYo.  ');
    print('8.d` 8    `b. 8`  `8   8      8  `` 8oooo8 .oooo8   8   8 Y.  .P 8oooo8       `8   8  8    8 8    8  8 8    8 Yb..   ');
    print('8o`  8     :8 8.  .P   8    8 8     8.     8    8   8   8 `b..d` 8.            8   8  8    8 8    8  8 8    8   `Yb. ');
    print('`YooP` `YooP` `YooP`   `YooP` 8     `Yooo` `YooP8   8   8  `YP`  `Yooo`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP. ');
    print(':.....::.....::.....::::.....:..:::::.....::.....:::..::..::...:::.....::::.....:::..::.....::.....::..:.....::.....:');
    print(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::');
    print(':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::');
    print('');
    print(cyan("036 Sembast Client for CLI"));
    print('');
    print(green("Copyright(c) 2022, 2023, 036 Creative Studios. ${lang(6)}"));
    print('');
    print(lang(7));
    print('');

  }
}