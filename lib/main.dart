import 'package:easy_localization/easy_localization.dart';
import 'package:first_project/views/add.dart';
import 'package:first_project/views/demo.dart';
import 'package:first_project/views/home.dart';
import 'package:first_project/views/report/report.dart';
import 'package:first_project/views/sign_in.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/introduce.dart';
import 'views/overview/overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('ar', 'DZ')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: Locale('ar', 'DZ'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IntroduceProvider(),
      child: MaterialApp(
        title: 'Navigator',
        initialRoute: IntroducePage.id,
        routes: {
          SignInPage.id: (context) => const SignInPage(),
          DemoPage.id: (context) => const DemoPage(),
          IntroducePage.id: (context) => const IntroducePage(),
          OverviewPage.id: (context) => OverviewPage(),
          AddPage.id: (context) => const AddPage(),
          HomePage.id: (context) => const HomePage(),
          ReportPage.id: (context) => const ReportPage(),
        },
      ),
    );
  }
}
