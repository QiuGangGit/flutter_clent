import 'package:lottery/main.dart';

class MineLogic extends GetxController {
  static MineLogic? logic() => Tool.capture(Get.find);
  final HttpTool _http = HttpTool.getHttp(MineLogic);
}

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MineLogic logic = Get.put(MineLogic());
    return const Placeholder();
  }
}
