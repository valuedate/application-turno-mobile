import 'package:turno/controllers/language_controller.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/localizations_config.dart';
import 'package:turno/utils/routes.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        Provider(create: (ctx) => LanguageController()),
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => Shift()),
      ],
      child: MaterialApp(
        title: 'Turno',
        theme: ThemeStyle.getTheme(),
        localizationsDelegates: LocalizationsConfig.localizationsDelegates,
        supportedLocales: LocalizationsConfig.supportedLocales,
        locale: LocalizationsConfig.supportedLocales[0],
        initialRoute: MyRoutes.splash,
        onGenerateRoute: (settings) {
          return MyRoutes.getRoutes(settings, context);
        },
      ),
    );
  }
}
