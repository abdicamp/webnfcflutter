import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'navigator_key.dart';

class FormatDate {
  String formatDate(date, {format = 'EEE, dd MMM yyyy', context}) {
    return DateFormat(format, 'id_ID').format(
      DateTime.parse(date).toLocal(),
    );
  }

  String formatTime(date, context) {
    return DateFormat.jm(
            Localizations.localeOf(context ?? navigatorKey.currentContext)
                .languageCode)
        .format(
      DateTime.parse(date).toLocal(),
    );
  }
}
