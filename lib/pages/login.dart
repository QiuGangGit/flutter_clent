import 'package:lottery/component/xx_input_widget.dart';
import 'package:lottery/main.dart';

class LoginLogic extends GetxController {
  static LoginLogic? logic() => Tool.capture(Get.find);
  final HttpTool _http = HttpTool.getHttp(LoginLogic);
  static const String phone = "";
  static const String code = "";
  TextEditingController phoneController = TextEditingController(text: phone);
  TextEditingController codeController = TextEditingController(text: code);

  Future sendSms(
    String phone,
  ) async {
    if (phoneController.text == "") {
      Tool.showToast("请输入手机号");
      return;
    }
    _http.get(
      "/get_code",
      query: {
        "phone": phone,
      },
      onSuccess: (body) {
        Tool.showToast("验证码是"+ body["code"].toString());
      },
      onError: (type, error) {
        Tool.showToast(error);
      },
    );
  }

  ///登陆接口
  Future login() async {
    String text = phoneController.text;
    if (text == "") {
      Tool.showToast("请输入手机号");
      return;
    }
    String textCode = codeController.text;
    if (textCode == "") {
      Tool.showToast("请输入验证码");
      return;
    }

    _http.get(
      "/login",
      query: {
        "phone": phone,
        "code": textCode,
      },
      onSuccess: (body) {
        Tool.showToast("登录成功");
        Get.toNamed(Routes.menu);
        HiveTool.login(phone);
      },
      onError: (type, error) {},
    );
  }

  @override
  void onReady() {
    super.onReady();
    // Get.toNamed(Routes.menu);
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginLogic logic = Get.put(LoginLogic());
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          logic.login();
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
          child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: getMainColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  "登录",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              )),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 170,
            ),
            XXInputWidget(
                title: "手机号",
                inputFormatters: [],
                maxLength: 13,
                hintTitle: '请输入手机号',
                controller: logic.phoneController,
                voidCallback: (value) {}),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XXInputWidget(
                    title: "验证码",
                    inputFormatters: [],
                    maxLength: 13,
                    width: 200,
                    hintTitle: '请输入验证码',
                    controller: logic.codeController,
                    voidCallback: (value) {}),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    logic.sendSms(logic.phoneController.text);
                  },
                  child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: getMainColor,
                      ),
                      child: const Center(
                        child: Text(
                          "获取验证码",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
