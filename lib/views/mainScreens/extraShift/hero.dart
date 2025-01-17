import 'dart:async';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/date_helper.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turno/views/mainScreens/extraShift/actions.dart';

class HomeHero extends StatefulWidget {
  final Shift shift;
  final double topSpace;
  final Function updateHome;
  final Function changeActiveIndex;
  const HomeHero(
      {required this.shift,
      required this.topSpace,
      required this.updateHome,
      required this.changeActiveIndex,
      super.key});

  @override
  State<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends State<HomeHero> {
  DateTime now = DateTime.now();
  Timer? _timer;
  bool canStart = false;
  double? _progress;

  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context, listen: false);
    User user = Provider.of(context, listen: false);
    String? shiftLate = isLate(widget.shift, now);
    String? nextText = getNextShift(context, widget.shift);
    checkCanStart(now, widget.shift);
    _progress = updateProgress(widget.shift, _progress ?? 0);
    String greeting = (now.hour >= 6 && now.hour < 12)
        ? AppLocalizations.of(context)!.good_morning
        : (now.hour >= 12 && now.hour < 18)
            ? AppLocalizations.of(context)!.good_afternoon
            : AppLocalizations.of(context)!.good_evening;
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: widget.topSpace),
      transform: Matrix4.translationValues(0, -widget.topSpace, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(400),
          bottomLeft: Radius.circular(400),
        ),
        gradient: ThemeStyle.heroBackgroundGradient,
      ),
      child: Column(
        children: [
          Text(
            "$greeting, ${user.name!.split(" ")[0]}!",
            style: ThemeStyle.textStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 40),
          (widget.shift.startedShiftExtra)
              ? Text(
                  "Turno Extra",
                  style: ThemeStyle.textStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : Container(),
          const SizedBox(height: 30),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 300,
                height: 345,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                      child: (auth.token != null)
                          ? ShiftActions(
                              canStart: canStart,
                              started: widget.shift.startedShift
                                  ? true
                                  : widget.shift.startedShiftExtra,
                              token: auth.token!,
                              updateHome: updateState,
                              shift: widget.shift,
                              changeActiveIndex: widget.changeActiveIndex,
                            )
                          : Container()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? getNextShift(ctx, Shift shift) {
    String day;
    String month;
    String year;
    String dayWeek;
    if (!shift.currentShift.isEmpty && shift.currentStartedShift.isEmpty) {
      day = (shift.currentShift!["day_period"].toString().length < 2)
          ? "0${shift.currentShift!["day_period"]}"
          : shift.currentShift!["day_period"].toString();
      month = (shift.currentShift!["rotation_month"].toString().length < 2)
          ? "0${shift.currentShift!["rotation_month"]}"
          : shift.currentShift!["rotation_month"].toString();
      year = shift.currentShift!["rotation_year"].toString();
      String monthName = DateHelper.getMonthName(month, ctx);
      dayWeek = AppLocalizations.of(ctx)!.today;
      return "$dayWeek, $day $monthName";
    }
    if (shift.nextShift!.isNotEmpty) {
      for (int i = 0; i < shift.nextShift!.length; i++) {
        if (shift.nextShift![i]["shift_cod"].toString().toUpperCase() != "F") {
          day = (shift.nextShift![i]["day_period"].toString().length < 2)
              ? "0${shift.nextShift![i]["day_period"]}"
              : shift.nextShift![i]["day_period"].toString();
          month = (shift.nextShift![i]["rotation_month"].toString().length < 2)
              ? "0${shift.nextShift![i]["rotation_month"]}"
              : shift.nextShift![i]["rotation_month"].toString();
          year = shift.nextShift![i]["rotation_year"].toString();
          if (day != "null" && month != "null" && year != "null") {
            dayWeek = DateHelper.getDayName(day, month, year, ctx);
          } else {
            return "Sem informação";
          }
          String monthName = DateHelper.getMonthName(month, ctx);
          return "$dayWeek, $day $monthName";
        }
      }
    }
    return null;
  }

  void checkCanStart(DateTime now, Shift shift) async {
    if (shift.currentShift != null && !shift.currentShift.isEmpty) {
      String yearMonth = shift.currentShift!["rotation_period"];
      String day = shift.currentShift!["day_period"] < 10
          ? "0${shift.currentShift!["day_period"]}"
          : shift.currentShift!["day_period"].toString();
      DateTime shiftTimeInit = DateHelper.getAddTimeToTime(
          time: DateTime.parse(
              "$yearMonth-$day ${shift.currentShift!["sh_start_at"]}"),
          add: const Duration(minutes: -15),
          returnString: false);
      await shift.checkIfStarted();
      setState(() {
        canStart = !now.difference(shiftTimeInit).inMinutes.isNegative;
      });
    }
  }

  double updateProgress(Shift shift, double currentProgress) {
    int totalDuration = 0;
    int diff = 0;
    if (shift.currentStartedShift["duration"] != null &&
        shift.currentStartedShift["start_at"] != null) {
      totalDuration = int.parse(shift.currentStartedShift["duration"]);
      DateTime start = DateTime.parse(shift.currentStartedShift["start_at"]);
      diff = DateTime.now().difference(start).inMinutes;
    }
    currentProgress = diff / totalDuration;
    return (diff > 0) ? currentProgress : 0.0;
  }

  Widget pinInit(Shift shift) {
    if (shift.currentStartedShift["start_at"] != null &&
        shift.currentStartedShift["start_at"] != "") {
      return Positioned(
        right: 150,
        top: 0,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "E",
              style: ThemeStyle.textStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }

  void updateState() {
    widget.updateHome();
  }
}

String dateTimeToTimeOfDayString(dTime) {
  TimeOfDay hTime = TimeOfDay.fromDateTime(dTime);
  String hour = (hTime.hour < 10 ? "0" : "") + hTime.hour.toString();
  String minute = (hTime.minute < 10 ? "0" : "") + hTime.minute.toString();
  return "$hour:$minute";
}

String? isLate(Shift shift, DateTime now) {
  if (shift.currentStartedShift["start_at"] != null) return null;
  if (shift.currentShift["start_dateTime"] == null) return null;
  Duration diff =
      now.difference(DateTime.parse(shift.currentShift["start_dateTime"]));
  if (!diff.isNegative) {
    if (diff.inMinutes < 60) return diff.inMinutes.toString();
    return "${diff.toString().split(":")[0]}:${diff.toString().split(":")[1]}";
  }

  return null;
}
