import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9BEF4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Payment Confirmation"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/thank_you.png',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Text(
                          "FOR AVAILING SERVICES FROM US",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Text(
                          "Just a second we’re sending the order details\n to your email/phone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              "if you choose to cancel, you can do it anytime before 4 Hours of the appointment time. Post which a cancellation  fee will we charged of  ₹200",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontSize: Dimensions.fontSizeDefault),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(
                    context,
                    "/index");
              },
              child: const Text(
                "Go Home",
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: const Text(
          "Note- Dear customer! your timely contribution can provide this opportunity to other needed customer",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
