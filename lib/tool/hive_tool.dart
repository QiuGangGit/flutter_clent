import 'package:lottery/main.dart';

export 'package:hive/hive.dart';

class HiveTool {
  /// 用户信息
  static Box get userBox => HiveService.service(HiveService.user);

  static String userId = "userId";

  static String getUserId() => userBox.get(userId, defaultValue: "");

  static bool isLogin() => getUserId().isNotEmpty;

  static void login(String userId) {
    userBox.put(HiveTool.userId, userId);
  }

  static void logout() => userBox.clear();
}
