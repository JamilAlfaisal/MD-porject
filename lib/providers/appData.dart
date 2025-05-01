import 'package:untitled/WordTranslation.dart';

class AppData{
  static final _appData = new AppData._internal();
  late List<WordTranslation> selected = [];
  List<WordTranslation>words = [WordTranslation("hello", "Hola"),WordTranslation("goodbye", "adiós"),WordTranslation("h", "a"),WordTranslation("s", "w"),WordTranslation("hello", "Hola"),WordTranslation("goodbye", "adiós"),WordTranslation("h", "a"),WordTranslation("s", "w")];
  factory AppData(){
    return _appData;
  }

  AppData._internal();

}
final appData = AppData();