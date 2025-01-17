import 'dart:async';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/utils/custom_location_permission.dart';
import 'package:turno/utils/geolocator_helper.dart';
import 'package:turno/utils/store.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:turno/views/bottomSheets/end_shift.dart';

class ShiftActions extends StatefulWidget {
  final String token;
  final bool canStart;
  final bool started;
  final Function updateHome;
  final Shift shift;
  const ShiftActions(
      {required this.token,
      required this.canStart,
      required this.started,
      required this.updateHome,
      required this.shift,
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
  const CheckShift(
      {required this.shift,
      required this.token,
      required this.hasLunch,
      required this.updateHome,
      required this.canStart,
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
            if (widget.shift.currentStartedShift?["status"] != null &&
                widget.shift.currentStartedShift["status"] == "ENTRADA" &&
                (widget.shift.currentStartedShift["shift_has_lunch_hours"]
                            .toString()
                            .toUpperCase() ==
                        "Y" ||
                    widget.shift.currentStartedShift["has_lunch_hours"]
                            .toString()
                            .toUpperCase() ==
                        "Y") &&
                !widget.shift.startedShiftExtra)
              StartLunch(
                shift: widget.shift,
                token: widget.token,
                update: widget.updateHome,
              ),
            if (widget.shift.currentStartedShift?["status"] != null &&
                widget.shift.currentStartedShift["status"] == "SAIDAREFEICAO" &&
                (widget.shift.currentStartedShift["shift_has_lunch_hours"]
                            .toString()
                            .toUpperCase() ==
                        "Y" ||
                    widget.shift.currentStartedShift["has_lunch_hours"]
                            .toString()
                            .toUpperCase() ==
                        "Y") &&
                !widget.shift.startedShiftExtra)
              EndLunch(
                shift: widget.shift,
                token: widget.token,
                update: widget.updateHome,
              ),
            if (widget.shift.startedShift || widget.shift.startedShiftExtra)
              EndShift(
                shift: widget.shift,
                token: widget.token,
                update: widget.updateHome,
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
    return Text(
      "Não possui turnos associados",
      textAlign: TextAlign.center,
      style: ThemeStyle.textStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
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
  const EndShift(
      {required this.shift,
      required this.token,
      required this.update,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BtnTextIcon(
      text: AppLocalizations.of(context)!.end_shift,
      icon: const AssetImage("assets/icons/timerStop.png"),
      onClick: () async {
        await showMaterialModalBottomSheet(
          expand: true,
          context: context,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          barrierColor: ThemeStyle.primary.withOpacity(0.5),
          builder: (context) => ConfirmEndShift(token: token, update: update),
        );
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
  final Shift shift;
  const TimerShift({required this.shift, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime? start =
        DateTime.tryParse(shift.currentStartedShift["start_at"] ?? "");
    DateTime? startLunch =
        DateTime.tryParse(shift.currentStartedShift["partial_end_at"] ?? "");
    DateTime? endLunch =
        DateTime.tryParse(shift.currentStartedShift["partial_start_at"] ?? "");
    List timer = [];
    List timerLunch = [];
    List timerShift = [];
    if (startLunch != null && endLunch == null) {
      timer = now.difference(startLunch).toString().split(".");
      timerShift = startLunch.difference(start!).toString().split(".");
    } else if (startLunch != null && endLunch != null && start != null) {
      Duration timerAux = endLunch.difference(startLunch);
      timerLunch = timerAux.toString().split(".");
      timer = (now.difference(start) - timerAux).toString().split(".");
    } else if (start != null) {
      timer = now.difference(start).toString().split(".");
    }

    return Column(
      children: [
        if (timerLunch.isNotEmpty)
          Text(
            "${timerLunch[0]}",
            style: ThemeStyle.textStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: ThemeStyle.primary,
            ),
          ),
        if (timerShift.isNotEmpty)
          Text(
            "${timerShift[0]}",
            style: ThemeStyle.textStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: ThemeStyle.primary,
            ),
          ),
        if (timer.isNotEmpty)
          Text(
            "${timer[0]}",
            style: ThemeStyle.textStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
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
