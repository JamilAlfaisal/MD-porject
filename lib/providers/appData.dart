import 'package:untitled/WordTranslation.dart';

class AppData{
  static final _appData = new AppData._internal();
  List<WordTranslation> selected = [];
  factory AppData(){
    return _appData;
  }

  AppData._internal();

}
final appData = AppData();