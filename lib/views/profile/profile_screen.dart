import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turno/components/app_bar.dart';
import 'package:turno/components/footer.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/views/profile/profile.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool appBarHidden = false;
  int currentPageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add a listener to the ScrollController to update appBarHidden
    _scrollController.addListener(() {
      if (_scrollController.offset >= 5) {
        print("AppBar Hidden: true");
        changeAppBarHidden(true);
      } else {
        print("AppBar Hidden: false");
        changeAppBarHidden(false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void changeActiveIndex(int index) {
    setState(() {
      currentPageIndex = index;
      appBarHidden = false; // Reset app bar visibility when switching tabs
    });
  }

  void changeAppBarHidden(bool hidden) {
    setState(() {
      appBarHidden = hidden;
    });
  }

  double topSpace = kToolbarHeight + 78;

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ThemeStyle.primary, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(78),
          child: MyAppBar(
            hiddenAppBar: appBarHidden,
            btnAction: () {
              auth.logout(context);
            },
            btnIcon: MyIcon.exit,
            btnText: AppLocalizations.of(context)!.exit,
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController, // Attach the ScrollController
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  topSpace, // Minimum height of 100% viewport
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Distribute space
              children: [
                // Profile Section
                Column(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, -10, 0),
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            appBarHidden
                                ? const SizedBox.shrink()
                                : Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white
                                          .withAlpha((0.1 * 255).toInt()),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: ImageIcon(
                                        AssetImage(
                                            "assets/icons/left_arrow.png"),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            const SizedBox(width: 15),
                            appBarHidden
                                ? const SizedBox.shrink()
                                : Text(
                                    AppLocalizations.of(context)!.back,
                                    style: ThemeStyle.textStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const Profile(), // Profile widget
                  ],
                ),

                // Language Selector Section
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

                    // Links Section
                    const Footer(), // Footer widget with links like "Fale Connosco", "Termos e Condições", etc.
                    const SizedBox(height: 20), // Add spacing below the footer
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
