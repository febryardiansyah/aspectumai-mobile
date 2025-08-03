import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(
    BuildContext context, {
    String message = 'Loading...',
    bool dismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: dismissible,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CupertinoActivityIndicator(),
                  const AppSpacer.width(16),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
