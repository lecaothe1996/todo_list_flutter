import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list/base_widget/my_dialog.dart';
import 'package:to_do_list/routes/app_pages.dart';
import 'package:to_do_list/sharedpref/key_preference.dart';
import 'package:to_do_list/sharedpref/shared_preference.dart';

class ToDoListCtrl extends GetxController {
  final _fireStore = FirebaseFirestore.instance;
  final toDoList = [].obs;
  String _userId = '';
  String userEmail = '';
  final String _key = 'text';

  @override
  void onClose() {
    super.onClose();
    toDoList.close();
  }

  @override
  void onInit() {
    super.onInit();
    _userId = SharedPreference.getString(KeyPreferences.user_id);
    userEmail = SharedPreference.getString(KeyPreferences.user_email);
    _getTodoList();
  }

  void _getTodoList() {
    _fireStore.collection(_userId).snapshots().listen(
      (event) {
        final dataList = event.docs.map((doc) {
          final data = doc.data();
          final docId = doc.id;
          return ToDo(
            id: docId,
            text: data[_key] as String,
          );
        }).toList();
        toDoList.value = dataList;
      },
    );
  }

  void onAddTodo() async {
    MyDialog.showDialog(
      callback: (value) async {
        EasyLoading.show();
        try {
          await _fireStore.collection(_userId).add(<String, String>{
            _key: value,
          });
          EasyLoading.dismiss();
        } on FirebaseAuthException catch (e) {
          print('Error: $e');
          EasyLoading.showError(e.code);
        }
      },
    );
  }

  void onDeleteTodo(String id) async {
    EasyLoading.show();
    try {
      await _fireStore.collection(_userId).doc(id).delete();
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      EasyLoading.showError(e.code);
    }
  }

  void onUpdateTodo({
    required String id,
    required String text,
  }) {
    MyDialog.showDialog(
      initValue: text,
      callback: (value) async {
        EasyLoading.show();
        try {
          await _fireStore.collection(_userId).doc(id).update(<String, String>{
            _key: value,
          });
          EasyLoading.dismiss();
        } on FirebaseAuthException catch (e) {
          print('Error: $e');
          EasyLoading.showError(e.code);
        }
      },
    );
  }

  void goToListItem(String text) {
    Get.toNamed(AppPages.TO_DO_LIST_ITEM, arguments: text);
  }

  void onLogout() async {
    EasyLoading.show();
    await FirebaseAuth.instance.signOut();
    await SharedPreference.setBool(KeyPreferences.is_login, false);
    await SharedPreference.remove(KeyPreferences.user_id);
    EasyLoading.dismiss();
    Get.offNamedUntil(AppPages.LOGIN, (route) => false);
  }
}

class ToDo {
  final String id;
  final String? text;

  ToDo({
    required this.id,
    this.text,
  });
}
