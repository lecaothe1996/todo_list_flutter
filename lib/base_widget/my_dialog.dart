import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  static Future<void> showDialog({
    required void Function(String value) callback,
    String? initValue,
  }) {
    TextEditingController textEditingController = TextEditingController(text: initValue);
    return Get.defaultDialog(
      title: 'Dialog',
      content: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
          hintText: 'Enter',
        ),
      ),
      onConfirm: () {
        Get.back();
        callback(textEditingController.text);
      },
      textConfirm: 'Send',
    );
  }
}
