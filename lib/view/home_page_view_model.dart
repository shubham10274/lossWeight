import 'package:flutter/cupertino.dart';
import 'package:lossy/database/weightEntry.dart';


class HomeScreenViewModel {//extends BaseModel 
  //-------------VARIABLES-------------//
  final TextEditingController addweightController = TextEditingController();
  int selectedIndex = 0;
  final PageController pageController = PageController();

  ///On tapping bottom nav bar items
  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    // notifyListeners();
  }

  ///Adding new value to SQLite database
  Future<void> save() async {
    try {
      final double weight = double.parse(addweightController.text);
      final String? note = ''; // No note for now
      final int id = await weightEntry().create(weight: weight, note: note);

      print('Weight saved with id: $id');
    } catch (e) {
      print('Error saving weight: $e');
      throw Exception('Failed to save weight');
    } finally {
      addweightController.clear();
    }
  }
}
