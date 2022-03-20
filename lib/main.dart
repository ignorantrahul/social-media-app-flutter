import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';
import 'package:social_media_app/routes/app_pages.dart';

import 'modules/auth/controllers/auth_controller.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initServices();
    runApp(const MyApp());
  } catch (err) {
    debugPrint(err.toString());
  }
}

Future<void> initServices() async {
  await GetStorage.init();
  Get.put(AppThemeController());
  Get.put(AuthController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: () => NxOverlayWidget(
          child: GetMaterialApp(
            title: StringValues.appName,
            debugShowCheckedModeBanner: false,
            themeMode: logic.themeMode == StringValues.system
                ? ThemeMode.system
                : logic.themeMode == StringValues.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            getPages: AppPages.pages,
            initialRoute: AppRoutes.splash,
          ),
        ),
      ),
    );
  }
}