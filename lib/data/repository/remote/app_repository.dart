import 'package:multi_langthemfont/data/repository/local/local_data_access.dart';
import 'package:multi_langthemfont/di/di.dart';

class AppRepository {
  final sharedPreferences = getIt.get<LocalDataAccess>();

  getFontSize() {
    return sharedPreferences.getFontSize();
  }

  setFontSize(int fontSize) {
    sharedPreferences.setFontSize(fontSize);
  }
}
