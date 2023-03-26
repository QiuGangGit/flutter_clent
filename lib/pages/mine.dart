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
    return Column(
      children: [
        AppBar(
          title: const Text("我的"),
          actions: [
            IconButton(
              onPressed: () {
                HiveTool.logout();
                Get.offAllNamed(Routes.login);
              },
              icon: Padding(
                padding: EdgeInsets.only(right: 30),
                child: const Icon(
                  Icons.exit_to_app,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          elevation: 1,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + SafeTool.instance.safeBtm,
            ),
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildItem(
                "参与的抽奖",
                () {
                  Get.toNamed(Routes.award);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getPlaceholderColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          ClipOval(
            child: Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "手机号:18810866623",
            style: TextStyle(
              color: getTextBlack,
              fontSize: 20,
              fontWeight: getBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    String title,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          color: getPlaceholderColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: getTextBlack,
                fontSize: 16,
                fontWeight: getBold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
