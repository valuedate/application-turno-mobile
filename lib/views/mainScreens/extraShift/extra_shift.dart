import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/views/mainScreens/extraShift/hero.dart';

class ScreenExtraShift extends StatefulWidget {
  final Function changeHiddenAppBar;
  final Function changeActiveIndex;
  const ScreenExtraShift(
      {required this.changeHiddenAppBar,
      required this.changeActiveIndex,
      super.key});

  @override
  State<ScreenExtraShift> createState() => _ScreenExtraShiftState();
}

class _ScreenExtraShiftState extends State<ScreenExtraShift> {
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
                child: Column(children: [
                  HomeHero(
                    shift: shift,
                    topSpace: topSpace,
                    changeActiveIndex: widget.changeActiveIndex,
                    updateHome: () {
                      setState(() {});
                    },
                  ),
                ]))));
  }
}
