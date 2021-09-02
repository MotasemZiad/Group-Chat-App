import 'package:flutter/material.dart';

class GlobalWidgets {
  GlobalWidgets._();
  static GlobalWidgets globalWidgets = GlobalWidgets._();

  showSnackBar({
    @required BuildContext context,
    @required String message,
    Color backgroundColor,
    int duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: duration),
      ),
    );
  }

  showCustomDialog({
    @required BuildContext context,
    @required String text,
    String title,
    String action1Title,
    Function action1Function,
    String action2Title,
    Function action2Function,
    Color titleColor,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? '',
          ),
          titleTextStyle: TextStyle(color: titleColor),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: action1Function,
              child: Text(action1Title ?? ''),
            ),
            if (action2Title != null && action2Function != null)
              TextButton(
                onPressed: action2Function,
                child: Text(action2Title ?? ''),
              ),
          ],
        );
      },
      useSafeArea: true,
    );
  }
}
