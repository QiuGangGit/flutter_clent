import 'package:lottery/main.dart';
import 'package:lottery/pages/home.dart';
import 'package:lottery/pages/mine.dart';

class MenuLogic extends GetxController {
  static MenuLogic? logic() => Tool.capture(Get.find);

  late PageController controller;
  RxInt index = 0.obs;

  @override
  void onInit() {
    controller = PageController(
      initialPage: index.value,
    );
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void switchPage(int index) {
    if (this.index.value == index) return;
    controller.jumpToPage(index);
    this.index.value = index;
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuLogic logic = Get.put(MenuLogic());
    return Scaffold(
      body: PageView(
        controller: logic.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          GetKeepAlive(child: HomePage()),
          GetKeepAlive(child: MinePage()),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(logic),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildNavigationBar(MenuLogic logic) {
    double height = getNavigationBarHeight + SafeTool.instance.safeBtm;
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
        maxHeight: height,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: getDividerColor,
          ),
        ),
      ),
      child: Obx(
        () => BottomNavigationBar(
          items: _buildItems(logic),
          onTap: logic.switchPage,
          currentIndex: logic.index.value,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 30,
          selectedItemColor: getTextBlack,
          unselectedItemColor: getHintBlack,
          selectedFontSize: 10,
          unselectedFontSize: 10,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildItems(MenuLogic logic) {
    return [
      _buildItem(
        "assets/images/ic_home_nor_30.png",
        "assets/images/ic_home_sel_30.png",
        "首页",
      ),
      _buildItem(
        "assets/images/ic_mine_nor_30.png",
        "assets/images/ic_mine_sel_30.png",
        "我的",
      ),
    ];
  }

  BottomNavigationBarItem _buildItem(
    String icon,
    String activeIcon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: _buildIcon(icon),
      activeIcon: _buildIcon(activeIcon),
      label: label,
      tooltip: "",
    );
  }

  Widget _buildIcon(String icon) {
    return Image.asset(
      icon,
      width: 30,
      height: 30,
    );
  }
}
