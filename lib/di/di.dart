import 'package:get_it/get_it.dart';
import 'package:multi_langthemfont/data/repository/local/local_data_access.dart';
import 'package:multi_langthemfont/data/repository/local/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

configureInjection() async {
  final sharedPref = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<LocalDataAccess>(
      () => SharedPrefHelper(sharedPref));
}
