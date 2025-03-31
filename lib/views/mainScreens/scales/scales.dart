import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';

class ScreenScales extends StatefulWidget {
  final Function changeHiddenAppBar;
  final Function changeActiveIndex;
  const ScreenScales(
      {required this.changeHiddenAppBar,
      required this.changeActiveIndex,
      super.key});

  @override
  State<ScreenScales> createState() => _ScreenScalesState();
}

class _ScreenScalesState extends State<ScreenScales> {
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
            child:
                Container(color: Colors.white, child: Column(children: []))));
  }
}
