import 'package:turno/components/app_bar.dart';
import 'package:turno/components/bottom_bar.dart';
import 'package:turno/utils/icons.dart';
import 'package:turno/utils/theme.dart';
import 'package:turno/views/mainScreens/home/home.dart';
import 'package:turno/views/mainScreens/mais.dart';
import 'package:turno/views/mainScreens/history/shift_history.dart';
import 'package:turno/views/mainScreens/extraShift/extra_shift.dart';
import 'package:flutter/material.dart';
import 'package:turno/views/mainScreens/scales/scales.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  bool appBarHidden = false;
  int currentPageIndex = 0;

  Future<void> _launchUrl() async {
    // Replace this URL with your help page URL
    final Uri url = Uri.parse('https://turno.pt/blog/view/61/');

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView, // This opens in an internal browser
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    )) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
          ),
        );
      }
    }
  }

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
            btnAction: _launchUrl,
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
              ScreenScales(
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
