import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/widgets/to_do_list/ctrl.dart';

class ToDoListView extends StatelessWidget {
  ToDoListView({super.key});

  final ToDoListCtrl toDoListCtrl = Get.put(ToDoListCtrl());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          child: Center(
            child: Text(
              toDoListCtrl.userEmail,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => toDoListCtrl.onAddTodo(),
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(15),
                  child: const Center(
                    child: Text('Add To Do'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => toDoListCtrl.onLogout(),
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(15),
                  child: const Center(
                    child: Text('Logout'),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: toDoListCtrl.toDoList.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => toDoListCtrl.goToListItem(toDoListCtrl.toDoList[index].text),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${toDoListCtrl.toDoList[index].text}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                          onPressed: () => toDoListCtrl.onUpdateTodo(
                            id: toDoListCtrl.toDoList[index].id,
                            text: toDoListCtrl.toDoList[index].text,
                          ),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => toDoListCtrl.onDeleteTodo(toDoListCtrl.toDoList[index].id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
