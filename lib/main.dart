import 'dart:ui';
import 'package:lottery/component/component.dart';
import 'package:lottery/routes.dart';
import 'package:lottery/services.dart';
import 'package:lottery/tool/tool.dart';
import 'package:lottery/translation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

export 'package:flutter/material.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/services.dart' hide TextInput;
export 'package:get/get.dart' hide Response, MultipartFile, FormData;
export 'package:lottery/component/component.dart';
export 'package:lottery/pages/widgets/widgets.dart';
export 'package:lottery/tool/tool.dart';
export 'routes.dart';
export 'services.dart';
export 'translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
  errorWidget();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "抽奖".tr,
      theme: DesignTool.theme(Brightness.light),
      darkTheme: DesignTool.theme(Brightness.dark),
      initialRoute: Routes.launch,
      getPages: Routes.pages,
      unknownRoute: Routes.unknown,
      defaultTransition: Transition.cupertino,
      routingCallback: Routes.observer,
      enableLog: environment != Environment.release,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
            boldText: false,
          ),
          child: ScrollConfiguration(
            behavior: OverscrollBehavior(),
            child: child!,
          ),
        );
      },
      translations: Translation(),
      locale: window.locale,
      fallbackLocale: const Locale("zh", "CN"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("zh", "CN"),
        Locale('en', 'US'),
      ],
    );
  }
}

void errorWidget() {
  if (kReleaseMode) {
    ErrorWidget.builder = (details) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Text(
          "Error!",
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    };
  }
}
