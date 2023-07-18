import 'package:flutter/material.dart';

class DialogUtils {
  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              children: [
                Text("Loading..."),
                Spacer(),
                CircularProgressIndicator()
              ],
            ),
          );
        },
        barrierDismissible: false);
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static showMyDialog(
      {String? title,
      String message = "something went wrong, please try again later",
      required BuildContext context}) {
    showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: title == null
                ? const SizedBox()
                : Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ok"))
            ],
          );
        },
        barrierDismissible: false);
  }
}
