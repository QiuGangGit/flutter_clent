import 'package:lottery/main.dart';

export 'package:hive/hive.dart';

class HiveTool {

  /// 用户信息
  static Box get userBox => HiveService.service(HiveService.user);

  static String token = "token";
  static String userId = "userId";

  static String getToken() => userBox.get(token, defaultValue: "");

  static String getUserId() => userBox.get(userId, defaultValue: "");

  static bool isLogin() => getToken().isNotEmpty && getUserId().isNotEmpty;

  static void login(
    String token,
    String userId,
  ) {
    userBox.put(HiveTool.token, token);
    userBox.put(HiveTool.userId, userId);
  }

  static void logout() => userBox.clear();
}
