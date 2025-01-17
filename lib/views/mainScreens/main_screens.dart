import 'package:turno/components/app_bar.dart';
import 'package:turno/components/bottom_bar.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:turno/views/mainScreens/home/home.dart';
import 'package:turno/views/mainScreens/mais.dart';
import 'package:turno/views/mainScreens/history/shift_history.dart';
import 'package:turno/views/mainScreens/extraShift/extra_shift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  bool appBarHidden = false;
  int currentPageIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  double topSpace = kToolbarHeight + 82;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78),
          child: MyAppBar(
            hiddenAppBar: appBarHidden,
            btnAction: () {},
            btnIcon: MyIcon.help,
            btnText: AppLocalizations.of(context)!.help,
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          indexActive: currentPageIndex,
          changeIndexActive: changeActiveIndex,
        ),
        body: Stack(
          children: [
            Container(
              color: ThemeStyle.primary,
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 400),
              transform: Matrix4.translationValues(0, -topSpace, 0),
            ),
            <Widget>[
              MyHomePage(
                changeHiddenAppBar: changeAppBarHidden,
                changeActiveIndex: changeActiveIndex,
              ),
              ScreenShiftHistory(
                changeHiddenAppBar: changeAppBarHidden,
              ),
              ScreenExtraShift(
                changeHiddenAppBar: changeAppBarHidden,
                changeActiveIndex: changeActiveIndex,
              ),
              const ScreenMore(),
            ][currentPageIndex],
          ],
        ),
      ),
    );
  }

  void changeActiveIndex(index) {
    setState(() {
      currentPageIndex = index;
      appBarHidden = false;
    });
  }

  void changeAppBarHidden(hidden) {
    setState(() {
      appBarHidden = hidden;
    });
  }
}
