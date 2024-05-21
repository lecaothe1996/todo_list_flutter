import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/widgets/to_do_list_item/ctrl.dart';

class ToDoListItem extends StatelessWidget {
  ToDoListItem({super.key});

  final ToDoListItemCtrl toDoListItemCtrl = Get.put(ToDoListItemCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List Item'),
      ),
      body: Center(
        child: Text(toDoListItemCtrl.text),
      ),
    );
  }
}
