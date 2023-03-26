import 'package:lottery/main.dart';

class HomeLogic extends GetxController {
  static HomeLogic? logic() => Tool.capture(Get.find);
  final HttpTool _http = HttpTool.getHttp(HomeLogic);

  List list = [{}, {}, {}, {}, {}];
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text("首页"),
          elevation: 1,
        ),
        Expanded(
          child: GetBuilder<HomeLogic>(
            init: HomeLogic(),
            builder: (logic) {
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  16 + SafeTool.instance.safeBtm,
                ),
                itemBuilder: (context, index) {
                  return _buildItem({});
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemCount: logic.list.length,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(Map item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            const AspectRatio(
              aspectRatio: 1.8,
              child: ImageWidget(
                "https://t7.baidu.com/it/u=852388090,130270862&fm=193&f=GIF",
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned.fill(
              top: null,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: getBlack25,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "这是一个抽奖奖品的描述信息，那应该显示什么呢，你觉得呢，哈哈哈哈哈这是一个抽奖奖品的描述信息，那应该显示什么呢，你觉得呢，哈哈哈哈哈",
                      style: TextStyle(
                        color: getTextWhite,
                        fontSize: 16,
                        fontWeight: getBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text(
                          "开奖人数：10人",
                          style: TextStyle(
                            color: getTextWhite,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "参与人数：5人",
                          style: TextStyle(
                            color: getTextWhite,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "剩余人数：5人",
                          style: TextStyle(
                            color: getTextWhite,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: getBlack25,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: 25,
                    child: const Text(
                      "已开奖",
                      style: TextStyle(
                        color: getTextWhite,
                        fontSize: 55,
                        fontWeight: getBold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
