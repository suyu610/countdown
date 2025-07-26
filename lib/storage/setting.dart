import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingStorageUtil {
  static const String IS_FIRST_OPEN = "isFirstOpen";

  ///是否第一次打开
  static bool isFirstOpen() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    return sp.getBool(IS_FIRST_OPEN) ?? true;
  }

  /// 当前github点赞数量
  static Future<int> githubCount() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getInt("githubCount") ?? 0;
  }

  static void setGithubCount(int count) {
    SharedPreferences.getInstance().then((sp) {
      sp.setInt("githubCount", count);
    });
  }

  /// 当前bilibili点赞数量
  static Future<int> bilibiliCount() async {
    // SharedPreferences sp = Get.find<SharedPreferences>();
    // return sp.getInt("bilibiliCount") ?? 0;

    var sp = await SharedPreferences.getInstance();
    return sp.getInt("bilibiliCount") ?? 0;
  }

  static void setBilibiliCount(int count) {
    SharedPreferences.getInstance().then((sp) {
      sp.setInt("bilibiliCount", count);
    });
  }
}
