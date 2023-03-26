import 'package:lottery/main.dart';

class HomeLogic extends GetxController {
  static HomeLogic? logic() => Tool.capture(Get.find);
  final HttpTool _http = HttpTool.getHttp(HomeLogic);
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeLogic logic = Get.put(HomeLogic());
    return const Placeholder();
  }
}
