import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:turno/components/buttons/btn_txt_icon.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/utils/date_helper.dart';
import 'package:turno/utils/theme.dart';

class HistoricalGraph extends StatelessWidget {
  final Shift shift;
  final Function changeActiveIndex;
  const HistoricalGraph(
      {required this.shift, required this.changeActiveIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.last_shifts),
              SizedBox(
                width: 100,
                height: 35,
                child: BtnTextIcon(
                  text: AppLocalizations.of(context)!.see_history,
                  color: Colors.white,
                  textColor: ThemeStyle.primary,
                  borderColor: ThemeStyle.primary.withOpacity(0.15),
                  onClick: () {
                    changeActiveIndex(1);
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 285,
          child: Stack(
            children: [
              Column(
                children: graphDivider(),
              ),
              ListView(
                scrollDirection: Axis.horizontal,
                children: graphBar(shift, context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<Widget> graphDivider() {
  List<Widget> graph = [];
  graph.add(const SizedBox(height: 24));
  for (int i = 0; i < 6; i++) {
    graph.add(const Divider(
      height: 1,
      color: ThemeStyle.lightGray,
    ));
    graph.add(const SizedBox(height: 35));
  }
  graph.add(const Divider(
    height: 1,
    color: ThemeStyle.lightGray,
  ));
  return graph;
}

List<Widget> graphBar(Shift shift, ctx) {
  List<Widget> graph = [];
  int length = shift.shiftHistory?.length ?? 0;
  graph.add(const SizedBox(width: 10));
  for (int i = 0; i < length; i++) {
    Duration? duration;
    DateTime? start =
        DateTime.tryParse(shift.shiftHistory?[i]["start_at"] ?? "");
    DateTime? end = DateTime.tryParse(shift.shiftHistory?[i]["end_at"] ?? "");
    int day = end?.day ?? start?.day ?? 0;
    String month = shift.shiftHistory?[i]["rotation_month"] ??
        end?.month.toString() ??
        start?.month.toString() ??
        "";
    if (start != null && end != null) duration = end.difference(start);
    int? time = duration?.inHours ?? 0;
    graph.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 28,
        height: 285,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 24, child: Text(time.toString())),
            Container(
              constraints: const BoxConstraints(minHeight: 1, maxHeight: 216),
              height: 9.0 * time,
              width: 10,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  colors: [ThemeStyle.secondary, ThemeStyle.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(height: 15, child: Text("${(day <= 9) ? "0" : ""}$day")),
            const SizedBox(height: 5),
            SizedBox(
                height: 15, child: Text(DateHelper.getMonthName(month, ctx))),
          ],
        ),
      ),
    ));
  }

  graph.add(const SizedBox(width: 10));
  return graph.toList();
}
