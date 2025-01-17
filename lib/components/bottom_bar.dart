import 'package:turno/utils/icons.dart';
import 'package:turno/utils/routes.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomBar extends StatelessWidget {
  final int indexActive;
  final Function changeIndexActive;
  const CustomBottomBar(
      {required this.indexActive, required this.changeIndexActive, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: ThemeStyle.transparentToWhite,
      ),
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: ThemeStyle.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                changeIndexActive(0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MyIcon.init,
                    size: 24,
                    color:
                        (indexActive == 0) ? ThemeStyle.darkGray : Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.home,
                    style: ThemeStyle.textStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: (indexActive == 0)
                          ? ThemeStyle.darkGray
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                changeIndexActive(1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MyIcon.calendar,
                    size: 24,
                    color:
                        (indexActive == 1) ? ThemeStyle.darkGray : Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.shift,
                    style: ThemeStyle.textStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: (indexActive == 1)
                          ? ThemeStyle.darkGray
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                changeIndexActive(2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MyIcon.extra,
                    size: 24,
                    color:
                        (indexActive == 2) ? ThemeStyle.darkGray : Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.shift_extra,
                    style: ThemeStyle.textStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: (indexActive == 2)
                          ? ThemeStyle.darkGray
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.menu);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MyIcon.menu,
                    size: 24,
                    color:
                        (indexActive == 3) ? ThemeStyle.darkGray : Colors.white,
                  ),
                  Text(
                    AppLocalizations.of(context)!.more,
                    style: ThemeStyle.textStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: (indexActive == 3)
                          ? ThemeStyle.darkGray
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
