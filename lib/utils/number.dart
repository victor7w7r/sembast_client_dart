 // ignore: unnecessary_null_comparison
bool isNumeric(String str) => str == null
  ? false
  : double.tryParse(str) != null;
