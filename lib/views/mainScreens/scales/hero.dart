import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftHistoryHero extends StatelessWidget {
  final double topSpace;
  const ShiftHistoryHero({required this.topSpace, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: topSpace),
      decoration: const BoxDecoration(
        gradient: ThemeStyle.heroBackgroundGradientWhite,
      ),
      child: Column(
        children: [
          SizedBox(
            width: 230,
            child: Text(
              AppLocalizations.of(context)!.shift_history,
              textAlign: TextAlign.center,
              style: ThemeStyle.textStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 45),
        ],
      ),
    );
  }
}
