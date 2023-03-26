import 'package:lottery/main.dart';

class AwardLogic extends GetxController {
  static AwardLogic? logic() => Tool.capture(Get.find);
  final HttpTool _http = HttpTool.getHttp(AwardLogic);

  List list = [];

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() {
    _http.get(
      "/draw_record",
      query: {
        "user_id": HiveTool.getUserId(),
      },
      onSuccess: (body) {
        list = body["draw_records"];
        update();
      },
      onError: (type, error) {
        Tool.showToast(error);
      },
    );
  }
}

class AwardPage extends StatelessWidget {
  const AwardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text("中奖记录"),
            elevation: 1,
          ),
          Expanded(
            child: GetBuilder<AwardLogic>(
              init: AwardLogic(),
              builder: (logic) {
                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    16 + SafeTool.instance.safeBtm,
                  ),
                  itemBuilder: (context, index) {
                    return _buildItem(logic.list[index]);
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
      ),
    );
  }

  Widget _buildItem(Map item) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 去详情
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.8,
              child: ImageWidget(
                item["prize_icon"],
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
                    Text(
                      item["prize_desc"],
                      style: const TextStyle(
                        color: getTextWhite,
                        fontSize: 16,
                        fontWeight: getBold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                    child:  Text(
                      item["status"]==0?"未开奖": item["status"]==1?"已中奖":"未中奖",
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