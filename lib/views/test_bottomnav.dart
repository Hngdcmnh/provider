import 'package:first_project/views/generated/codegen_loader.g.dart';
import 'package:first_project/views/introduce.dart';
import 'package:first_project/views/overview/overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

import 'generated/locale_keys.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('ar', 'DZ'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: Locale('ar', 'DZ'),
        assetLoader: CodegenLoader(),
        child: MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    print(context.supportedLocales[0].toString());
    print(context.supportedLocales[1].toString());

    return  MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Column(
          children: [
            SizedBox(height: 100,width: double.infinity,),
            TextButton(
                onPressed: () async {
                  // log(locale.toString(), name: toString());
                  await context.setLocale(context.supportedLocales[1]); //BuildContext extension method
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(LocaleKeys.get('title').tr())),
            TextButton(
                onPressed: () async {
                  // log(locale.toString(), name: toString());
                  await context.setLocale(context.supportedLocales[0]); //BuildContext extension method
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(LocaleKeys.get('title').tr())),
            // TextButton(
            //     onPressed: () async {
            //       // log(locale.toString(), name: toString());
            //       await context.setLocale(context.supportedLocales[0]); //BuildContext extension method
            //       Navigator.pop(context);
            //     },
            //     child: Text(LocaleKeys.change_language.tr())),
          ],
        )
    );
  }
}

//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         localizationsDelegates: context.localizationDelegates,
//         supportedLocales: context.supportedLocales,
//         locale: context.locale,
//         home: Column(
//           children: [
//             SizedBox(height: 100,width: double.infinity,),
//             TextButton(
//                 onPressed: () async {
//                   // log(locale.toString(), name: toString());
//                   await context.setLocale(context.supportedLocales[1]); //BuildContext extension method
//                   Navigator.pop(context);
//                 },
//                 child: Text(LocaleKeys.change_language.tr())),
//             TextButton(
//                 onPressed: () async {
//                   // log(locale.toString(), name: toString());
//                   await context.setLocale(context.supportedLocales[0]); //BuildContext extension method
//                   Navigator.pop(context);
//                 },
//                 child: Text(LocaleKeys.change_language.tr())),
//             TextButton(
//
//                 child: Text(LocaleKeys.change_language.tr())),
//           ],
//         )
//     );
//   }
// }