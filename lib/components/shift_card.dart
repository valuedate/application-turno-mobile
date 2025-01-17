import 'package:turno/utils/date_helper.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class ShiftCard extends StatefulWidget {
  final String day;
  final String month;
  final String year;
  final bool isExpandable;
  final String teamName;
  final String timeShiftStart;
  final String timeShiftEnd;
  final String shiftCode;
  final String? shiftDescription;
  final String? totalTimeShift;
  final Widget? expandedContent;

  const ShiftCard(
      {required this.day,
      required this.month,
      required this.year,
      required this.isExpandable,
      required this.teamName,
      required this.timeShiftStart,
      required this.timeShiftEnd,
      required this.shiftCode,
      this.totalTimeShift = "",
      this.shiftDescription,
      this.expandedContent,
      super.key});

  @override
  State<ShiftCard> createState() => _ShiftCardState();
}

class _ShiftCardState extends State<ShiftCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 65),
      width: double.maxFinite,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ThemeStyle.transparentGray,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                  color: (widget.shiftCode == 'F')
                      ? ThemeStyle.lightGray
                      : ThemeStyle.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: (widget.shiftCode == 'F')
                                        ? ThemeStyle.gray.withOpacity(0.3)
                                        : ThemeStyle.transparentGray)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.day} ${DateHelper.getMonthName(widget.month, context)}",
                                style: ThemeStyle.textStyle(
                                  color: (widget.shiftCode == 'F')
                                      ? ThemeStyle.darkGray
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateHelper.getDayName(widget.day, widget.month,
                                    widget.year, context),
                                style: ThemeStyle.textStyle(
                                  color: (widget.shiftCode == 'F')
                                      ? ThemeStyle.darkGray
                                      : Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ))),
                  SizedBox(
                    width: 30,
                    child: ImageIcon(
                      AssetImage(
                          "assets/icons/${(widget.shiftCode == 'F') ? 'no_calendar' : (widget.shiftCode == 'N') ? 'moon' : 'sun'}.png"),
                      color: (widget.shiftCode == 'F')
                          ? ThemeStyle.primary
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 100, right: 5, top: 10, bottom: 10),
              child: (widget.shiftCode == 'F' &&
                      widget.shiftDescription != null)
                  ? SizedBox(
                      height: 45,
                      child: Center(
                        child: Row(
                          children: [Text(widget.shiftDescription!)],
                        ),
                      ))
                  : Column(
                      children: [
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage("assets/icons/team.png"),
                              color: ThemeStyle.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.teamName,
                              style: ThemeStyle.textStyle(
                                  fontWeight: (widget.isExpandable)
                                      ? FontWeight.w400
                                      : FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage("assets/icons/time.png"),
                              color: ThemeStyle.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${widget.timeShiftStart} | ${widget.timeShiftEnd}",
                              style: ThemeStyle.textStyle(),
                            ),
                          ],
                        ),
                        if (widget.totalTimeShift != null &&
                            widget.totalTimeShift != "")
                          Row(
                            children: [
                              const ImageIcon(
                                AssetImage("assets/icons/timeTotal.png"),
                                color: ThemeStyle.primary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Total ${widget.totalTimeShift!} horas",
                                style: ThemeStyle.textStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            height: (expanded) ? null : 0,
                            child: widget.expandedContent),
                      ],
                    ),
            ),
          ),
          if (widget.isExpandable)
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onExpanded,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 27,
                        height: 27,
                        constraints:
                            const BoxConstraints(maxWidth: 27, minHeight: 27),
                        decoration: BoxDecoration(
                          color: ThemeStyle.primary.withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: ImageIcon(
                          AssetImage(
                              "assets/icons/${expanded ? 'minus' : 'plus'}.png"),
                          color: ThemeStyle.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }
}
