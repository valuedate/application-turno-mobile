import 'package:flutter/material.dart';

class ShowErrors {
  ShowErrors({
    required String msg,
    required String closeMsg,
    required String errorTitle,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(errorTitle),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(closeMsg),
          ),
        ],
      ),
    );
  }
}
