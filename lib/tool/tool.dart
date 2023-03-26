import 'package:lottery/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'design_tool.dart';
export 'hive_tool.dart';
export 'http_tool.dart';
export 'safe_tool.dart';
export 'time_tool.dart';

const String baseUrl = "http://192.168.6.163:8080";

class Tool {
  static Logic? capture<Logic extends GetxController>(
    Function logic, {
    String? tag,
  }) {
    try {
      return logic<Logic>(tag: tag);
    } catch (_) {
      return null;
    }
  }

  static String getUUId() {
    return const Uuid().v1().replaceAll("-", "");
  }

  static void hideKeyboard() {
    Get.focusScope?.unfocus();
  }

  static String getThumbnail(
    String url, {
    double width = 0,
    double height = 0,
  }) {
    if (url.contains("aliyuncs.com")) {
      double ratio = 1.15;
      if (width > 0) {
        int w = (width * ratio).toInt();
        return "$url?x-oss-process=image/resize,w_$w/format,webp";
      } else if (height > 0) {
        int h = (height * ratio).toInt();
        return "$url?x-oss-process=image/resize,h_$h/format,webp";
      }
    }
    return url;
  }

  static void showToast(
    String msg, {
    Brightness? brightness,
  }) {
    Color backgroundColor = Colors.black;
    Color textColor = getTextWhite;
    if (brightness == Brightness.light) {
      backgroundColor = Colors.white;
      textColor = getTextBlack;
    }
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 12,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static Future<bool> requestPermission(
    Permission permission,
    String tips,
  ) async {
    return requestPermissions(
      [permission],
      tips,
    );
  }

  static Future<bool> requestPermissions(
    List<Permission> permissions,
    String tips,
  ) async {
    Map<Permission, PermissionStatus> result = await permissions.request();
    bool isGranted = true;
    for (PermissionStatus state in result.values) {
      if (!state.isGranted) {
        isGranted = false;
      }
    }
    if (!isGranted) {
      GetAlertDialog.show(
        Text(tips),
        actions: [
          TextButton(
            onPressed: () {
              GetAlertDialog.hide();
              openAppSettings();
            },
            child: const Text("打开"),
          ),
          TextButton(
            onPressed: () {
              GetAlertDialog.hide();
            },
            child: const Text("取消"),
          ),
        ],
      );
      return false;
    }
    return true;
  }
}
