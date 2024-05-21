import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:to_do_list/page/home_page.dart';
import 'package:to_do_list/page/login_page.dart';
import 'package:to_do_list/widgets/to_do_list_item/view.dart';

class AppPages {
  static const String LOGIN = '/login';
  static const String HOME = '/home';
  static const String TO_DO_LIST_ITEM = '/to_do_list_item';

  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: TO_DO_LIST_ITEM,
      page: () => ToDoListItem(),
    ),
  ];
}
