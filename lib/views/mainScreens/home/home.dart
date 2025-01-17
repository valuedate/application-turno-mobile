import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/components/shift_card.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/utils/theme.dart';
import 'package:turno/views/bottomSheets/init_extra_shift.dart';
import 'package:turno/views/mainScreens/home/hero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:turno/views/mainScreens/home/historical_graph.dart';

class MyHomePage extends StatefulWidget {
  final Function changeHiddenAppBar;
  final Function changeActiveIndex;
  const MyHomePage(
      {required this.changeHiddenAppBar,
      required this.changeActiveIndex,
      super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double topSpace = kToolbarHeight + 82;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Shift shift = Provider.of(context, listen: false);
    Auth auth = Provider.of(context);
    _scrollController.addListener(() {
      if (_scrollController.offset >= 40) {
        widget.changeHiddenAppBar(true);
      } else {
        widget.changeHiddenAppBar(false);
      }
    });
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          shift.loadNextShift(auth.token),
          shift.loadCurrentShift(auth.token),
          shift.loadHistory(auth.token),
        ]);
        setState(() {});
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        clipBehavior: Clip.none,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              HomeHero(
                shift: shift,
                topSpace: topSpace,
                updateHome: () {
                  setState(() {});
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                transform: Matrix4.translationValues(0, -topSpace + 45, 0),
                child: Column(
                  children: [
                    if (!shift.startedShift && !shift.startedShiftExtra)
                      BtnTextIcon(
                        onClick: () async {
                          if (await showMaterialModalBottomSheet(
                            expand: true,
                            context: context,
                            isDismissible: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: ThemeStyle.primary.withOpacity(0.5),
                            builder: (context) =>
                                InitExtraShift(token: auth.token!),
                          )) {
                            setState(() {});
                          }
                        },
                        text: AppLocalizations.of(context)!.init_extra_shift,
                        icon: const AssetImage("assets/icons/extra.png"),
                        color: ThemeStyle.secondary,
                        width: 200,
                      ),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.next_shift_title,
                          style: ThemeStyle.textStyle(
                              color: ThemeStyle.darkGray,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        SizedBox(
                          width: 100,
                          height: 35,
                          child: BtnTextIcon(
                            text: AppLocalizations.of(context)!.see_shift,
                            color: Colors.white,
                            textColor: ThemeStyle.primary,
                            borderColor: ThemeStyle.primary.withOpacity(0.15),
                            onClick: () {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Wrap(
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      children: shift.nextShift!.map<Widget>((item) {
                        return getShiftCard(item);
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -kToolbarHeight, 0),
                child: HistoricalGraph(
                    shift: shift, changeActiveIndex: widget.changeActiveIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getShiftCard(item) {
    if (item["day_period"] == null ||
        item["rotation_month"] == null ||
        item["rotation_year"] == null ||
        item["shift_cod"] == null ||
        item["shift_desc"] == null ||
        item["team_name"] == null ||
        item["sh_start_at"] == null ||
        item["sh_end_at"] == null) {
      return Container();
    }
    return ShiftCard(
      day: item["day_period"].toString(),
      month: item["rotation_month"],
      year: item["rotation_year"],
      shiftCode: item["shift_cod"],
      shiftDescription: item["shift_desc"],
      teamName: item["team_name"],
      timeShiftStart: item["sh_start_at"],
      timeShiftEnd: item["sh_end_at"],
      isExpandable: false,
    );
  }
}
