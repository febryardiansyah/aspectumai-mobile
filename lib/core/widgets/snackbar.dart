import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static void showLoading(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CupertinoActivityIndicator(
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        duration: const Duration(
          days: 1,
        ), // Keeps the snackbar visible until dismissed
      ),
    );
  }

  static void showError(
    BuildContext context, {
    String message = 'An error occurred',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[50],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccess(
    BuildContext context, {
    String message = 'Success',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[50],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
