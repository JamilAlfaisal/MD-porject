// lib/providers/app_data.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Data model (simple class)
class AppData {
  final int hearts;
  final int rubies;
  final bool isPurpleSold;
  final bool isBlueSold;
  AppData({this.hearts = 5, this.rubies = 1000,this.isBlueSold = false, this.isPurpleSold = false});
}

// Provider to manage state
final appDataProvider = StateNotifierProvider<AppDataNotifier, AppData>((ref) {
  return AppDataNotifier();
});

// State management logic
class AppDataNotifier extends StateNotifier<AppData> {
  AppDataNotifier() : super(AppData()) {
    _loadData(); // Load saved data on startup
  }

  // Load data from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppData(
      hearts: prefs.getInt('hearts') ?? 5,
      rubies: prefs.getInt('rubies') ?? 1000,
      isBlueSold: prefs.getBool('blue') ?? false,
      isPurpleSold: prefs.getBool('purple') ?? false,
    );
  }

  // Update and persist data
  Future<void> updateData(int hearts, int rubies, bool blue, bool purple) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hearts', hearts);
    await prefs.setInt('rubies', rubies);
    await prefs.setBool('blue', blue);
    await prefs.setBool('purple', purple);
    state = AppData(hearts: hearts, rubies: rubies, isBlueSold: blue, isPurpleSold: purple);
  }
}