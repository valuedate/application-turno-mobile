import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateHelper {
  static String getDayName(String day, String month, String year, ctx) {
    if (day.length < 2) day = "0$day";
    if (month.length < 2) month = "0$month";
    String dayName = DateFormat('EE')
        .format(DateTime.parse("$year-$month-$day"))
        .toString()
        .toLowerCase();
    switch (dayName) {
      case "mon":
        {
          return AppLocalizations.of(ctx)!.mon;
        }
      case "tue":
        {
          return AppLocalizations.of(ctx)!.tue;
        }
      case "wed":
        {
          return AppLocalizations.of(ctx)!.wed;
        }
      case "thu":
        {
          return AppLocalizations.of(ctx)!.thu;
        }
      case "fri":
        {
          return AppLocalizations.of(ctx)!.fri;
        }
      case "sat":
        {
          return AppLocalizations.of(ctx)!.sat;
        }
      case "sun":
        {
          return AppLocalizations.of(ctx)!.sun;
        }
      default:
        return "none";
    }
  }

  static String getMonthName(month, ctx) {
    if (month.length < 2) month = "0$month";
    switch (month) {
      case "01":
        return AppLocalizations.of(ctx)!.jan;
      case "02":
        return AppLocalizations.of(ctx)!.feb;
      case "03":
        return AppLocalizations.of(ctx)!.mar;
      case "04":
        return AppLocalizations.of(ctx)!.apr;
      case "05":
        return AppLocalizations.of(ctx)!.may;
      case "06":
        return AppLocalizations.of(ctx)!.jun;
      case "07":
        return AppLocalizations.of(ctx)!.jul;
      case "08":
        return AppLocalizations.of(ctx)!.aug;
      case "09":
        return AppLocalizations.of(ctx)!.sep;
      case "10":
        return AppLocalizations.of(ctx)!.oct;
      case "11":
        return AppLocalizations.of(ctx)!.nov;
      case "12":
        return AppLocalizations.of(ctx)!.dec;
      default:
        return "none";
    }
  }

  static dynamic getAddTimeToTime({
    required DateTime time,
    required Duration add,
    returnString = true,
  }) {
    DateTime diff = time.add(add);
    if (returnString) {
      return "${diff.hour}:${diff.minute}";
    } else {
      return diff;
    }
  }
}
