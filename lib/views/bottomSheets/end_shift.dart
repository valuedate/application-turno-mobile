import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/components/form_inputs/text_area.dart';
import 'package:turno/components/highlight.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/custom_location_permission.dart';
import 'package:turno/utils/geolocator_helper.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmEndShift extends StatefulWidget {
  final String token;
  final Function update;
  const ConfirmEndShift({required this.token, required this.update, super.key});

  @override
  State<ConfirmEndShift> createState() => _ConfirmEndShift();
}

class _ConfirmEndShift extends State<ConfirmEndShift> {
  final _textAreaController = TextEditingController();
  int rate = 0;
  bool sended = false;
  final Map<String, dynamic> shiftExtraData = {
    'note': '',
  };

  @override
  Widget build(BuildContext context) {
    Shift shift = Provider.of(context, listen: false);
    DateTime now = DateTime.now();
    List timer = [];
    if (shift.currentStartedShift["start_at"] != null) {
      DateTime? start = DateTime.parse(shift.currentStartedShift["start_at"]);
      if (shift.currentStartedShift["partial_end_at"] != null &&
          shift.currentStartedShift["partial_start_at"] != null) {
        DateTime? startLunch =
            DateTime.parse(shift.currentStartedShift["partial_end_at"]);
        DateTime? endLunch =
            DateTime.parse(shift.currentStartedShift["partial_start_at"]);
        timer = (now.difference(start) - endLunch.difference(startLunch))
            .toString()
            .split(".");
      } else {
        timer = now.difference(start).toString().split(".");
      }
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 40),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewInsets.bottom -
                      40),
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 90,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.06),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 18, bottom: 12),
                        ),
                        (!sended)
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      "Confirme o Término do seu Turno",
                                      textAlign: TextAlign.center,
                                      style: ThemeStyle.textStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (timer.isNotEmpty)
                                        Center(
                                            child: Highlight(
                                          text: "Total de horas: ${timer[0]}",
                                          icon: const ImageIcon(
                                            AssetImage(
                                                "assets/icons/timeTotal.png"),
                                            color: Colors.white,
                                          ),
                                        )),
                                      const SizedBox(height: 50),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Avalie este Turno",
                                            style: ThemeStyle.textStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rate = 1;
                                                    });
                                                  },
                                                  child: Icon(
                                                    (rate > 0)
                                                        ? MyIcon.star
                                                        : MyIcon.star_empty,
                                                    color: (rate > 0)
                                                        ? ThemeStyle.primary
                                                        : ThemeStyle.gray,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rate = 2;
                                                    });
                                                  },
                                                  child: Icon(
                                                    (rate > 1)
                                                        ? MyIcon.star
                                                        : MyIcon.star_empty,
                                                    color: (rate > 1)
                                                        ? ThemeStyle.primary
                                                        : ThemeStyle.gray,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rate = 3;
                                                    });
                                                  },
                                                  child: Icon(
                                                    (rate > 2)
                                                        ? MyIcon.star
                                                        : MyIcon.star_empty,
                                                    color: (rate > 2)
                                                        ? ThemeStyle.primary
                                                        : ThemeStyle.gray,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rate = 4;
                                                    });
                                                  },
                                                  child: Icon(
                                                    (rate > 3)
                                                        ? MyIcon.star
                                                        : MyIcon.star_empty,
                                                    color: (rate > 3)
                                                        ? ThemeStyle.primary
                                                        : ThemeStyle.gray,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rate = 5;
                                                    });
                                                  },
                                                  child: Icon(
                                                    (rate > 4)
                                                        ? MyIcon.star
                                                        : MyIcon.star_empty,
                                                    color: (rate > 4)
                                                        ? ThemeStyle.primary
                                                        : ThemeStyle.gray,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${AppLocalizations.of(context)!.add_a_note} (opcional)",
                                        style: ThemeStyle.textStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        height: 125,
                                        child: TextArea(
                                          controller: _textAreaController,
                                          placeholder:
                                              "Isto é um exemplo de nota adicionada ao meu turno.",
                                          onChanged: (value) {
                                            setState(() {
                                              shiftExtraData["note"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 125),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("Cancelar"),
                                          ),
                                          BtnTextIcon(
                                            onClick: () async {
                                              CustomLocationPermission
                                                  .getPermission();
                                              Position position =
                                                  await GeolocatorHelper
                                                      .getCurrentPosition();
                                              DateTime time = DateTime.now();
                                              if (shift.startedShiftExtra) {
                                                await shift.timeSheetPunchExtra(
                                                  time: time,
                                                  token: widget.token,
                                                  lat: position.latitude,
                                                  lon: position.longitude,
                                                  status: "SAIDA",
                                                  rate: rate.toString(),
                                                  note: shiftExtraData["note"],
                                                );
                                              } else {
                                                await shift.timeSheetPunch(
                                                  time: DateTime.now(),
                                                  token: widget.token,
                                                  lat: position.latitude,
                                                  lon: position.longitude,
                                                  status: "SAIDA",
                                                  rate: rate.toString(),
                                                  note: shiftExtraData["note"],
                                                );
                                              }
                                              shift.startedShiftDefined(
                                                  value: false,
                                                  extra:
                                                      shift.startedShiftExtra);
                                              await shift.clearStartedShift();
                                              await shift
                                                  .loadHistory(widget.token);
                                              widget.update();
                                              setState(() {
                                                sended = true;
                                              });
                                            },
                                            color: ThemeStyle.primary,
                                            text: "Confirmar Término",
                                            width: 200,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 100),
                                  Column(children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 104,
                                          height: 104,
                                          decoration: BoxDecoration(
                                            color: ThemeStyle.primary
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(52),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 20,
                                          child: SizedBox(
                                            height: 64,
                                            width: 64,
                                            child: Image.asset(
                                              "assets/images/check.png",
                                              height: 64,
                                              width: 64,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Turno terminado com sucesso, bom descanso!",
                                    textAlign: TextAlign.center,
                                    style: ThemeStyle.textStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(height: 150),
                                  Center(
                                    child: BtnTextIcon(
                                      onClick: () async {
                                        Navigator.of(context).pop(true);
                                      },
                                      color: ThemeStyle.primary,
                                      text: "Voltar à Página Inicial",
                                      width: 220,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
