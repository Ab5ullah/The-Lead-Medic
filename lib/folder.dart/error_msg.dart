import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:flutter/material.dart';

class Message {
  static void taskErrorWarning(String taskName, String taskErrorWarning) {
    Get.snackbar(taskName, taskErrorWarning,
        backgroundColor: AppColors.fifthcolor,
        titleText: Text(taskName,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent)),
        messageText: Text(taskErrorWarning,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)));
  }
}
