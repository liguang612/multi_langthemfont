import 'package:multi_langthemfont/data/repository/local/local_data_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPreferences;

  SharedPrefHelper(this.sharedPreferences);

  @override
  int getFontSize() {
    return sharedPreferences.getInt('fontSize') ?? 16;
  }

  @override
  void setFontSize(int fontSize) {
    sharedPreferences.setInt('fontSize', fontSize);
  }
}
