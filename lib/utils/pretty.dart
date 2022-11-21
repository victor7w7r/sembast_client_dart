import 'dart:convert' show JsonEncoder;

import 'package:fpdart/fpdart.dart' show IO;

String pretty(dynamic input) => IO(() => ' ' * 3)
  .map((indent) => JsonEncoder.withIndent(indent))
  .map((encoder) => encoder.convert(input))
  .run();
