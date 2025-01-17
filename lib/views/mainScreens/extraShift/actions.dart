import 'dart:async';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/utils/custom_location_permission.dart';
import 'package:turno/utils/geolocator_helper.dart';
import 'package:turno/utils/store.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:turno/views/bottomSheets/end_shift.dart';
import 'package:turno/views/bottomSheets/init_extra_shift.dart';

class ShiftActions extends StatefulWidget {
  final String token;
  final bool canStart;
  final bool started;
  final Function updateHome;
  final Shift shift;
  final Function changeActiveIndex;
  const ShiftActions(
      {required this.token,
      required this.canStart,
      required this.started,
      required this.updateHome,
      required this.shift,
      required this.changeActiveIndex,
      super.key});

  @override
  State<ShiftActions> createState() => _ShiftActionsState();
}

class _ShiftActionsState extends State<ShiftActions> {
  bool hasShift = false;
  bool hasLunch = false;
  bool hasInitShift = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hasShift = (widget.shift.currentShift.isEmpty) ? false : true;
    hasLunch = (widget.shift.currentShift!["shift_has_lunch_hours"] != null &&
            widget.shift.currentShift!["shift_has_lunch_hours"] != "N")
        ? true
        : false;
    return (hasShift ||
            widget.shift.startedShift ||
            widget.shift.startedShiftExtra)
        ? CheckShift(
            shift: widget.shift,
            token: widget.token,
            hasLunch: hasLunch,
            updateHome: widget.updateHome,
            canStart: widget.canStart,
            changeActiveIndex: widget.changeActiveIndex,
          )
        : const NoShift();
  }
}

class CheckShift extends StatefulWidget {
  final Shift shift;
  final String token;
  final bool hasLunch;
  final Function updateHome;
  final bool canStart;
  final Function changeActiveIndex;
  const CheckShift(
      {required this.shift,
      required this.token,
      required this.hasLunch,
      required this.updateHome,
      required this.canStart,
      required this.changeActiveIndex,
      super.key});

  @override
  State<CheckShift> createState() => _CheckShiftState();
}

class _CheckShiftState extends State<CheckShift> {
  bool init = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.shift.startedShift && !widget.shift.startedShiftExtra) {
      return InitShift(
        shift: widget.shift,
        token: widget.token,
        canStart: widget.canStart,
        update: widget.updateHome,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.shift.currentStartedShift != null)
          TimerShift(shift: widget.shift),
        const SizedBox(height: 20),
        Wrap(
          spacing: 5,
          children: [
            if (widget.shift.startedShift || widget.shift.startedShiftExtra)
              EndShift(
                shift: widget.shift,
                token: widget.token,
                update: widget.updateHome,
                changeActiveIndex: widget.changeActiveIndex,
              ),
          ],
        ),
      ],
    );
  }
}

class NoShift extends StatelessWidget {
  const NoShift({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return BtnTextIcon(
      onClick: () async {
        if (await showMaterialModalBottomSheet(
          expand: true,
          context: context,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          barrierColor: ThemeStyle.primary.withOpacity(0.5),
          builder: (context) => InitExtraShift(token: auth.token!),
        )) {}
      },
      text: AppLocalizations.of(context)!.init_extra_shift,
      icon: const AssetImage("assets/icons/extra.png"),
      color: ThemeStyle.secondary,
      width: 200,
    );
  }
}

class InitShift extends StatelessWidget {
  final Shift shift;
  final String token;
  final bool canStart;
  final Function update;
  const InitShift(
      {required this.shift,
      required this.token,
      required this.canStart,
      required this.update,
      super.key});

  @override
  Widget build(BuildContext context) {
    return (canStart)
        ? BtnTextIcon(
            text: AppLocalizations.of(context)!.init_shift,
            icon: const AssetImage("assets/icons/timerInit.png"),
            onClick: () async {
              await CustomLocationPermission.getPermission();
              Position position = await GeolocatorHelper.getCurrentPosition();
              DateTime time = DateTime.now();
              await shift.timeSheetPunch(
                time: time,
                token: token,
                lat: position.latitude,
                lon: position.longitude,
                status: "ENTRADA",
              );
              // await shift.setStartedShift(time: time, response: response);
              update();
            },
            color: ThemeStyle.secondary,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 190,
                child: Text(
                  AppLocalizations.of(context)!.can_start_shift,
                  textAlign: TextAlign.center,
                  style: ThemeStyle.textStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dateTimeToTimeOfDayString(
                    rotationPeriod: shift.currentShift!["rotation_period"],
                    dayPeriod: shift.currentShift!["day_period"],
                    shStartAt: shift.currentShift!["sh_start_at"]),
                style: ThemeStyle.textStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          );
  }
}

class EndShift extends StatelessWidget {
  final Shift shift;
  final String token;
  final Function update;
  final Function changeActiveIndex;
  const EndShift(
      {required this.shift,
      required this.token,
      required this.update,
      required this.changeActiveIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BtnTextIcon(
      text: AppLocalizations.of(context)!.end_shift,
      icon: const AssetImage("assets/icons/timerStop.png"),
      onClick: () async {
        if (await showMaterialModalBottomSheet(
          expand: true,
          context: context,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          barrierColor: ThemeStyle.primary.withOpacity(0.5),
          builder: (context) => ConfirmEndShift(token: token, update: update),
        )) {
          changeActiveIndex(0);
          //TODO conferir
        }
      },
      color: ThemeStyle.alert,
    );
  }
}

class StartLunch extends StatelessWidget {
  final Shift shift;
  final String token;
  final Function update;
  const StartLunch(
      {required this.shift,
      required this.token,
      required this.update,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BtnTextIcon(
      text: AppLocalizations.of(context)!.lunch,
      icon: const AssetImage("assets/icons/lunch.png"),
      onClick: () async {
        CustomLocationPermission.getPermission();
        Position position = await GeolocatorHelper.getCurrentPosition();
        DateTime time = DateTime.now();
        await shift.timeSheetPunch(
            time: time,
            token: token,
            lat: position.latitude,
            lon: position.longitude,
            status: "ENTRADAREFEICAO");
        update();
      },
    );
  }
}

class EndLunch extends StatelessWidget {
  final Shift shift;
  final String token;
  final Function update;
  const EndLunch(
      {required this.shift,
      required this.token,
      required this.update,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BtnTextIcon(
      text: AppLocalizations.of(context)!.end_lunch,
      icon: const AssetImage("assets/icons/lunch.png"),
      onClick: () async {
        CustomLocationPermission.getPermission();
        Position position = await GeolocatorHelper.getCurrentPosition();
        DateTime time = DateTime.now();
        await shift.timeSheetPunch(
          time: time,
          token: token,
          lat: position.latitude,
          lon: position.longitude,
          status: "SAIDAREFEICAO",
        );
        update();
      },
      color: ThemeStyle.alert,
    );
  }
}

class TimerShift extends StatelessWidget {
  final Shift? shift;
  const TimerShift({required this.shift, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime start = DateTime.parse(shift!.currentStartedShift["start_at"]);
    List timer = now.difference(start).toString().split(".");
    return Text(
      "${timer[0]}",
      style: ThemeStyle.textStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

Future<Map> getOpenedShift() async {
  return await Store.getMap("currentShift");
}

String dateTimeToTimeOfDayString({rotationPeriod, dayPeriod, shStartAt}) {
  String day = (dayPeriod < 10) ? "0$dayPeriod" : dayPeriod.toString();

  TimeOfDay hTime =
      TimeOfDay.fromDateTime(DateTime.parse("$rotationPeriod-$day $shStartAt"));
  String hour = (hTime.hour < 10 ? "0" : "") + hTime.hour.toString();
  String minute = (hTime.minute < 10 ? "0" : "") + hTime.minute.toString();
  return "$hour:$minute";
}
