import 'package:lottery/main.dart';
import 'package:lottery/pages/award_page.dart';
import 'package:lottery/pages/detail.dart';
import 'package:lottery/pages/launch.dart';
import 'package:lottery/pages/login.dart';
import 'package:lottery/pages/menu.dart';

export 'package:lottery/pages/unknown.dart';

class Routes {
  static String launch = "/launch";
  static String login = "/login";
  static String menu = "/menu";
  static String detail = "/detail";

  static String award = "/award";
  static List<GetPage> get pages {
    return [
      GetPage(
        name: launch,
        page: () => const LaunchPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: login,
        page: () => const LoginPage(),
        transition: Transition.fade,
        showCupertinoParallax: false,
      ),
      GetPage(
        name: award,
        page: () => const AwardPage(),
        transition: Transition.fade,
        showCupertinoParallax: false,
      ),
      GetPage(
        name: menu,
        page: () => const MenuPage(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: detail,
        page: () => const DetailPage(),
      ),
    ];
  }

  static GetPage get unknown {
    return GetPage(
      name: "/unknown",
      page: () => const UnknownPage(),
    );
  }

  static void untilMenu() {
    Get.until((route) {
      return Get.currentRoute == Routes.menu;
    });
  }

  static void observer(Routing? routing) {}
}
