import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turno/components/app_bar.dart';
import 'package:turno/components/footer.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:turno/models/auth.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context, listen: false);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [ThemeStyle.primary, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78),
          child: MyAppBar(
            hiddenAppBar: false,
            btnAction: () {
              auth.logout(context);
            },
            btnIcon: MyIcon.exit,
            btnText: AppLocalizations.of(context)!.exit,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, -10, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: ImageIcon(
                                AssetImage("assets/icons/left_arrow.png"),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            AppLocalizations.of(context)!.back,
                            style: ThemeStyle.textStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Esse trecho a abaixo ainda esta em construção, vão outras funcionalidades que ainda não estão no sendo produzidas
                  const SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ThemeStyle.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: ImageIcon(
                            AssetImage("assets/icons/globe.png"),
                            color: ThemeStyle.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // a app até esta preparada para o multi linguas, mas esse trecho esta estatico e sem função de troca por ora
                      Text(
                        "PT",
                        style: ThemeStyle.textStyle(
                            fontWeight: FontWeight.w700,
                            color: ThemeStyle.primary),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "EN",
                        style: ThemeStyle.textStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "FR",
                        style: ThemeStyle.textStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "ES",
                        style: ThemeStyle.textStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Footer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
