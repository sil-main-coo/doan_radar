
import 'package:controlradar/providers/local/session/shared_pref_manager.dart';
import 'package:controlradar/providers/local/session/shared_preferences_keys.dart';

import '../../../get_it.dart';

class SessionPref {
  static void saveSession(
      {String accessToken}) {
    var preferencesManager = locator.get<SharedPreferencesManager>();
    preferencesManager.putString(SharedPrefsKeys.token, accessToken);
  }

  static String getAccessToken() =>
      locator.get<SharedPreferencesManager>().getString(SharedPrefsKeys.token);

  static bool isSessionValid() {
    try {
      return locator
          .get<SharedPreferencesManager>()
          .getString(SharedPrefsKeys.token)
          ?.isNotEmpty ==
          true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> clearUserData() async {
    await locator.get<SharedPreferencesManager>().clear();
  }
}