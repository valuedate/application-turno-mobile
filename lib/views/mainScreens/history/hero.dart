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
          //Filtros desativados por enquanto
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     mainAxisSize: MainAxisSize.max,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       SizedBox(
          //         height: 40,
          //         child: Center(
          //             child: Text(
          //           AppLocalizations.of(context)!.filter_by,
          //           style: ThemeStyle.textStyle(
          //               color: ThemeStyle.primary,
          //               fontSize: 13,
          //               fontWeight: FontWeight.w600),
          //         )),
          //       ),
          //       Row(
          //         children: [
          //           SizedBox(
          //             height: 65,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   AppLocalizations.of(context)!.year,
          //                   style: ThemeStyle.textStyle(
          //                       fontSize: 13, fontWeight: FontWeight.w600),
          //                 ),
          //                 SizedBox(
          //                   height: 40,
          //                   child: Center(
          //                     child: CustomDropdown(
          //                       items: const ["Todos"],
          //                       active: -1,
          //                       onChanged: (i) {},
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const SizedBox(width: 20),
          //           SizedBox(
          //             height: 65,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   AppLocalizations.of(context)!.month,
          //                   style: ThemeStyle.textStyle(
          //                       fontSize: 13, fontWeight: FontWeight.w600),
          //                 ),
          //                 SizedBox(
          //                   height: 40,
          //                   child: Center(
          //                     child: CustomDropdown(
          //                       items: const ["Dezembro"],
          //                       active: -1,
          //                       onChanged: (i) {},
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(height: 45),
        ],
      ),
    );
  }
}
