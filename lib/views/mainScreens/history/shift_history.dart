import 'package:turno/components/shift_card.dart';
import 'package:turno/components/shift_card_extra.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/views/mainScreens/history/hero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//WIP

class ScreenShiftHistory extends StatelessWidget {
  final Function changeHiddenAppBar;
  ScreenShiftHistory({required this.changeHiddenAppBar, super.key});
  final ScrollController _scrollController = ScrollController();

  final double topSpace = kToolbarHeight + 82;
  @override
  Widget build(BuildContext context) {
    Shift shift = Provider.of(context);
    _scrollController.addListener(() {
      if (_scrollController.offset >= 40) {
        changeHiddenAppBar(true);
      } else {
        changeHiddenAppBar(false);
      }
    });
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        controller: _scrollController,
        child: Container(
          transform: Matrix4.translationValues(0, -topSpace, 0),
          color: Colors.white,
          child: Column(
            children: [
              ShiftHistoryHero(
                topSpace: topSpace,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 100),
                  child: Wrap(
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: shift.shiftHistory!.map<Widget>((item) {
                      return getShiftCard(item);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getShiftCard(item) {
    DateTime? date = DateTime.tryParse(item["start_at"] ?? "");
    DateTime? endDate = DateTime.tryParse(item["end_at"] ?? "");
    Duration? duration = (item["start_at"] != null && item["end_at"] != null)
        ? endDate!.difference(date!)
        : null;
    if (date != null) {
      List<String>? totalTimeShift =
          (duration != null) ? duration.toString().split(":") : null;
      return ShiftCard(
        day: date.day.toString(),
        month: date.month.toString(),
        year: date.year.toString(),
        shiftCode: item["shift_cod"] ?? "",
        teamName: item["team_name"] ?? "",
        totalTimeShift: (duration != null)
            ? "${totalTimeShift![0]}:${totalTimeShift[1]}"
            : null,
        timeShiftStart: (item["start_at"] != null)
            ? "${date.hour}:${date.minute}:${date.second}"
            : "",
        timeShiftEnd: (item["end_at"] != null)
            ? "${endDate!.hour}:${endDate.minute}:${endDate.second}"
            : "",
        isExpandable: true,
        expandedContent: getExpandedContent(item),
      );
    }
    return Container();
  }

  Widget getExpandedContent(item) {
    return ShiftCardExtra(item: item);
  }
}
