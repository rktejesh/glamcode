import 'package:flutter/material.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/helper/validator.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/screens/otp/otp_screen.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;
  const LoginPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _LoginFormKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset("assets/images/bgLogin.png"),
                      SafeArea(
                          child: Image.asset(
                        "assets/images/loginLogo.png",
                        height: MediaQuery.of(context).size.width * 0.3,
                      ))
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: Form(
                      key: _LoginFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  focusColor: Colors.black,
                                  floatingLabelStyle:
                                      TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                              validator: CustomValidator().validateMobile,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: phoneNumberController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: TextButton(
                              onPressed: () {
                                /*Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const OTPScreen(
                                            phoneNumber: "")));*/
                                setState(() {
                                  loading = true;
                                });
                                print(loading);
                                if (_LoginFormKey.currentState!.validate()) {
                                  print(phoneNumberController.text);
                                  widget.authBloc.userRepository
                                      .sendOtp(phoneNumberController.text)
                                      .then((value) {
                                    if (value) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => OTPScreen(
                                                  phoneNumber:
                                                      phoneNumberController
                                                          .text)));
                                      setState(() {
                                        loading = false;
                                      });
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      const snackBar = SnackBar(
                                        content: Text('Error sending OTP!'),
                                        backgroundColor: (Colors.black12),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  });
                                }
                              },
                              child: const Text("Get OTP"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
