import 'package:get/get.dart';

class ToDoListItemCtrl extends GetxController{
  String text = '';

  @override
  void onInit() {
    super.onInit();
    text = Get.arguments;
  }
}