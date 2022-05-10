import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'introduce.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static String id = '/SignInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Đăng nhập'),
            ),
            body: Container(
              padding: const EdgeInsets.only(
                  top: 60, left: 20, right: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return Visibility(
                        visible: (loginProvider.signInMode == 'domain')
                            ? true
                            : false,
                        child: TextField(
                          onChanged: (value) {
                            loginProvider.changePhoneNumber(value);
                          },
                          controller: loginProvider.controllerDomain,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: (loginProvider.controllerDomain
                                                .value.text.isEmpty &&
                                            loginProvider.isError)
                                        ? Colors.red
                                        : Colors.black54),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: (loginProvider.controllerDomain
                                                .value.text.isEmpty &&
                                            loginProvider.isError)
                                        ? Colors.red
                                        : Colors.black54),
                              ),
                              hintText: 'Tên miền',
                              suffixIcon: loginProvider
                                      .controllerDomain.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        loginProvider.changeDomain('');
                                      },
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.black54,
                                      ))),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return TextField(
                        onChanged: (value) {
                          loginProvider.changePhoneNumber(value);
                        },
                        controller: loginProvider.controllerPhoneNumber,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: (loginProvider.controllerPhoneNumber
                                              .value.text.isEmpty &&
                                          loginProvider.isError)
                                      ? Colors.red
                                      : Colors.black54),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: (loginProvider.controllerPhoneNumber
                                              .value.text.isEmpty &&
                                          loginProvider.isError)
                                      ? Colors.red
                                      : Colors.black54),
                            ),
                            hintText: 'Số điện thoại/Email',
                            suffixIcon:
                                loginProvider.controllerPhoneNumber.text.isEmpty
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          loginProvider.changePhoneNumber('');
                                        },
                                        icon: const Icon(
                                          Icons.clear_rounded,
                                          color: Colors.black54,
                                        ))),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return TextField(
                        controller: loginProvider.controllerPassword,
                        onChanged: (value) {
                          loginProvider.changePassword(value);
                        },
                        obscureText: loginProvider.isHiden ? true : false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: (loginProvider.controllerPassword.value
                                            .text.isEmpty &&
                                        loginProvider.isError)
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: (loginProvider.controllerPassword.value
                                            .text.isEmpty &&
                                        loginProvider.isError)
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          hintText: 'Mật khẩu',
                          suffixIcon:
                              loginProvider.controllerPassword.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: () {
                                        loginProvider.hidePassword();
                                      },
                                      icon: Icon(
                                        loginProvider.isHiden
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        color: Colors.black54,
                                      )),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Provider.of<LoginProvider>(context, listen: false)
                                .signIn();
                          },
                          child: const Text('Đăng nhập'));
                    }),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(primary: Colors.blue),
                        child: const Text('Quên mật khẩu?')),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return TextButton(
                          onPressed: () {
                            loginProvider.changeModeSignIn();
                          },
                          style: TextButton.styleFrom(primary: Colors.blue),
                          child: (loginProvider.signInMode == 'username')
                              ? Text('Đăng nhập với tên miền khác')
                              : Text('Quay lại'));
                    }),
                  ],
                ),
              ),
            )));
  }
}

class LoginProvider with ChangeNotifier {
  bool isError = false;
  bool isHiden = true;
  String signInMode = 'username';
  final controllerDomain = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final controllerPassword = TextEditingController();

  void changePhoneNumber(String value) {
    if (value.isEmpty) {
      controllerPhoneNumber.clear();
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      controllerPassword.clear();
    }
    notifyListeners();
  }

  void changeDomain(String value) {
    if (value.isEmpty) {
      controllerDomain.clear();
    }
    notifyListeners();
  }

  void hidePassword() {
    isHiden = !isHiden;
    notifyListeners();
  }

  void signIn() {
    if(signInMode =='username')
      {
        if (controllerPhoneNumber.value.text.isEmpty ||
            controllerPassword.value.text.isEmpty) {
          isError = true;
        } else {
          isError = false;
        }
      }
    else
      {
        if (controllerPhoneNumber.value.text.isEmpty ||
            controllerPassword.value.text.isEmpty || controllerDomain.value.text.isEmpty) {
          isError = true;
        } else {
          isError = false;
        }
      }

    notifyListeners();
  }

  void changeModeSignIn() {
    if (signInMode == 'username') {
      signInMode = 'domain';
    } else {
      signInMode = 'username';
    }
    notifyListeners();
  }
}
