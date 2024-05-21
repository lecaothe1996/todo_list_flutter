
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list/firebase_options.dart';
import 'package:to_do_list/routes/app_pages.dart';
import 'package:to_do_list/sharedpref/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initialize Shared Preferences
  await SharedPreference.init();

  const String localIp = "192.168.1.3";

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator(localIp, 8080);
      await FirebaseAuth.instance.useAuthEmulator(localIp, 9099);
    } catch (e) {
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      initialRoute: AppPages.LOGIN,
      getPages: AppPages.list,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
