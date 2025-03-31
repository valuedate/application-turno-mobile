import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/components/dropdown.dart';
import 'package:turno/components/form_inputs/text_area.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/custom_location_permission.dart';
import 'package:turno/utils/geolocator_helper.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitExtraShift extends StatefulWidget {
  final String token;
  const InitExtraShift({required this.token, super.key});

  @override
  State<InitExtraShift> createState() => _InitExtraShiftState();
}

class _InitExtraShiftState extends State<InitExtraShift> {
  final _textAreaController = TextEditingController();
  int categoriesSelect = 0;
  bool btnDisabled = false;
  final Map<String, String> shiftExtraData = {
    'team_id': '',
    'note': '',
  };

  @override
  Widget build(BuildContext context) {
    User user = Provider.of(context, listen: false);
    Shift shift = Provider.of(context, listen: false);
    shiftExtraData["team_id"] =
        user.entityList[categoriesSelect]["public_key_uuid"];
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
                      Text(
                        AppLocalizations.of(context)!.init_extra_shift,
                        style: ThemeStyle.textStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 35),
                      SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.select_a_team}*",
                            style: ThemeStyle.textStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomDropdown(
                            active: categoriesSelect,
                            items: user.entityList.map<String>((item) {
                              return item["name"].toString();
                            }).toList(),
                            onChanged: (i) {
                              setState(() {
                                categoriesSelect = i;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.add_a_note,
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
                              placeholder: "Indique o motivo da Picagem Extra",
                              onChanged: (value) {
                                setState(() {
                                  shiftExtraData["team_id"] =
                                      user.entityList[categoriesSelect]
                                              ["public_key_uuid"] ??
                                          "";
                                  shiftExtraData["note"] = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 125),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("Cancelar"),
                              ),
                              BtnTextIcon(
                                disabled: btnDisabled,
                                onClick: () async {
                                  setState(() {
                                    btnDisabled = true;
                                  });
                                  CustomLocationPermission.getPermission();
                                  Position position = await GeolocatorHelper
                                      .getCurrentPosition();
                                  DateTime time = DateTime.now();
                                  await shift.timeSheetPunchExtra(
                                    token: widget.token,
                                    time: time,
                                    lat: position.latitude,
                                    lon: position.longitude,
                                    note: shiftExtraData["note"],
                                    team: shiftExtraData["team_id"]!,
                                    status: "ENTRADA",
                                  );
                                  Navigator.of(context).pop(true);
                                },
                                color: ThemeStyle.secondary,
                                materialIcon: Icons.timer,
                                //icon: const AssetImage("assets/icons/extra.png"),
                                text: "Iniciar picagem extra",
                                width: 200,
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      )),
                    ],
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
