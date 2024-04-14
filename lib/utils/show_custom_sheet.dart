import 'package:flutter/material.dart';

Future<dynamic> showCustomModal(BuildContext context, Widget child) {
  return showModalBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return child;
      });
}
