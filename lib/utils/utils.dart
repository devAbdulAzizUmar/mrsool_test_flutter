import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  Utils._constructor();

  static verticalSpace(double height) => SizedBox(
        height: height,
      );

  static String getFormattedDate(String? date, BuildContext context) {
    if (date == null) return "";

    try {
      return "${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(
        DateTime.parse(date).toLocal(),
      )} | ${DateFormat.jm(Localizations.localeOf(context).languageCode).format(
        DateTime.parse(date).toLocal(),
      )}";
    } on FormatException catch (e) {
      debugPrint("getFormattedDate: $e");
      return "";
    }
  }
}
