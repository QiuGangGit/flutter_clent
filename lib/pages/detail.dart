import 'package:lottery/main.dart';

class DetailLogic extends GetxController {
  static DetailLogic? logic(int drawId) =>
      Tool.capture(Get.find, tag: drawId.toString());

  DetailLogic(this.drawId);

  final HttpTool _http = HttpTool.getHttp(DetailLogic);

  late int drawId;
  List personList = [];
  late Map prizeInfo = {};

  @override
  void onInit() {
    getDetail();

    super.onInit();
  }

  void getDetail() {
    _http.get(
      "/check_draw",
      query: {
        "draw_record_id": drawId,
      },
      onSuccess: (body) {
        personList = body["user_draw_records"];
        prizeInfo = body["prize"];
        update();
      },
      onError: (type, error) {
        Tool.showToast(error);
      },
    );
  }

  void goDraw() {
    _http.get(
      "/draw",
      query: {
        "draw_record_id": drawId,
        "user_id": HiveTool.getUserId(),
      },
      onSuccess: (body) {
        Map map = {"name": HiveTool.getUserId()};
        personList.add(map);
        update();
      },
      onError: (type, error) {
        Tool.showToast(error);
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int drawId = Get.arguments;
    DetailLogic logic = Get.put(DetailLogic(drawId));
    return Scaffold(
      appBar: AppBar(
        title: const Text("奖品介绍"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              _buildProductWidget(),
              const SizedBox(
                height: 20,
              ),
              _buildListWidget(),
              // const Spacer(),
              _buildBtnWidget(logic),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductWidget() {
    return GetBuilder<DetailLogic>(
      builder: (logic) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              ImageWidget(
                logic.prizeInfo["icon"].toString().isEmpty
                    ? ""
                    : logic.prizeInfo["icon"],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      logic.prizeInfo["name"].toString().isEmpty
                          ? ""
                          : logic.prizeInfo["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        color: getTextBlack,
                        fontWeight: getMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      logic.prizeInfo["desc"].toString().isEmpty
                          ? ""
                          : logic.prizeInfo["desc"],
                      style: const TextStyle(
                        fontSize: 13,
                        color: getHintBlack,
                        fontWeight: getRegular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListWidget() {
    return GetBuilder<DetailLogic>(builder: (logic) {
      return logic.personList.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Map item = logic.personList[index];
                return _buildItemWidget(item);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: logic.personList.length,
            )
          : const SizedBox();
    });
  }

  Widget _buildItemWidget(Map item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // ImageWidget(item["avatar"]),
          // const SizedBox(
          //   width: 10,
          // ),
          Text(
            item["name"].toString(),
            style: const TextStyle(
              fontSize: 15,
              color: getTextBlack,
              fontWeight: getMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtnWidget(DetailLogic logic) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        logic.goDraw();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: getHintBlack,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          "去抽奖",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: getRegular,
          ),
        ),
      ),
    );
  }
}
