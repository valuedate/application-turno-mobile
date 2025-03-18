import 'package:flutter/material.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftCardExtra extends StatelessWidget {
  final dynamic item;
  const ShiftCardExtra({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? startAt = DateTime.tryParse(item["start_at"] ?? "");
    DateTime? partialEnd = DateTime.tryParse(item["partial_end_at"] ?? "");
    DateTime? partialStart = DateTime.tryParse(item["partial_start_at"] ?? "");
    DateTime? endAt = DateTime.tryParse(item["end_at"] ?? "");

    String? dateInit = startAt.toString().split(" ")[0];
    String? timeInit = startAt.toString().split(" ")[1];
    String? timeInitLunch =
        (partialEnd != null) ? partialEnd.toString().split(" ")[1] : null;
    String? timeEndLunch =
        (partialStart != null) ? partialStart.toString().split(" ")[1] : null;

    String? dateEnd =
        (item["end_at"] != null) ? endAt.toString().split(" ")[0] : null;
    String? timeEnd =
        (item["end_at"] != null) ? endAt.toString().split(" ")[1] : null;
    int rating = item["rating_coworker"] ?? 0;
    String note = item["comment"] ?? "";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 1,
            color: ThemeStyle.gray.withAlpha((0.1 * 255).toInt()),
          ),
        ),
        if (startAt != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              children: [
                const Icon(MyIcon.init, color: ThemeStyle.primary, size: 20),
                const SizedBox(width: 10),
                Text(
                  "$dateInit | ${timeInit.split(".")[0]}",
                  style: ThemeStyle.textStyle(),
                ),
              ],
            ),
          ),
        if (timeInitLunch != null && timeEndLunch != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              children: [
                const Icon(MyIcon.lunch, color: ThemeStyle.primary, size: 20),
                const SizedBox(width: 10),
                Text(
                  "${timeInitLunch.split(".")[0]} - ${timeEndLunch.split(".")[0]}",
                  style: ThemeStyle.textStyle(),
                ),
              ],
            ),
          ),
        if (endAt != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              children: [
                const Icon(
                  MyIcon.stop,
                  color: ThemeStyle.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "$dateEnd | ${timeEnd?.split(".")[0]}",
                  style: ThemeStyle.textStyle(),
                ),
              ],
            ),
          ),
        if (item["source_app"] != null && item["source_app"] != "")
          Row(
            children: [
              const Icon(
                MyIcon.source,
                color: ThemeStyle.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                item["source_app"],
                style: ThemeStyle.textStyle(),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 1,
            color: ThemeStyle.gray.withAlpha((0.1 * 255).toInt()),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.rating_and_note,
          style: ThemeStyle.textStyle(color: ThemeStyle.gray, fontSize: 13),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                SizedBox(
                  width: 22,
                  child: Icon(
                    (rating > i) ? MyIcon.star : MyIcon.star_empty,
                    color: (rating > i) ? ThemeStyle.primary : ThemeStyle.gray,
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
        if (item["comment"] != null && item["comment"] != "")
          Text(
            item["comment"],
            style: ThemeStyle.textStyle(fontSize: 13),
          ),
        const SizedBox(height: 35)
      ],
    );
  }
}
