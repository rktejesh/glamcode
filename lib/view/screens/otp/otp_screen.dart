import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    return SafeArea(
      child: Form(
        key: otpFormKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      "We have sent you a 4-digit verification code\n on +91-${widget.phoneNumber}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.fontSizeLarge),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                    child: Pinput(
                      validator: (s) {
                        if (s != null) {
                          return s.length == 4
                              ? null
                              : "OTP should be of 4 digits.";
                        } else {
                          return "Enter OTP";
                        }
                      },
                      controller: pinController,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: TextButton(
                      onPressed: () {
                        if (otpFormKey.currentState!.validate()) {
                          final AuthBloc authBloc = context.read<AuthBloc>();
                          print(widget.phoneNumber);
                          authBloc.userRepository
                              .verifyOtp(pinController.text, widget.phoneNumber)
                              .then((value) => authBloc.add(AppLoaded()));
                        }
                      },
                      child: const Text("Verify"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black)),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
