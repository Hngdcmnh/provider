import 'package:easy_localization/easy_localization.dart';
import 'package:first_project/views/generated/locale_keys.g.dart';
import 'package:first_project/views/sign_in.dart';
import 'package:flutter/material.dart';
import 'demo.dart';
import 'package:provider/provider.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);
  static String id = '/IntroducePage';

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => IntroduceProvider(),
        //   child:
        Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Tiếng Việt'),
                        Icon(Icons.arrow_right),
                      ],
                    ))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInPage.id);
                      },
                      child: const Text('Đăng nhập')),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, DemoPage.id);
                      },
                      child: const Text('Xem dữ liệu demo')),
                  Column(
                    children: [
                      Consumer<IntroduceProvider>(
                          builder: (context, introduceProvider, child) {
                        return Text(introduceProvider.num.toString());
                      }),
                      ElevatedButton(
                          onPressed: () {
                            Provider.of<IntroduceProvider>(context,
                                    listen: false)
                                .addNum();
                          },
                          child: const Text('Add'))
                    ],
                  )
                ],
              ),
            ));
    // );
  }
}

class IntroduceProvider with ChangeNotifier {
  int num = 0;

  void addNum() {
    num += 1;
    notifyListeners();
  }
}
