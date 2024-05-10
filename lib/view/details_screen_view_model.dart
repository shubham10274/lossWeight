import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lossy/database/weightEntry.dart';


class DetailsScreenViewModel {
  final TextEditingController editWeightController = TextEditingController();

  Future<void> edit({required String docId}) async {
    final weight = double.tryParse(editWeightController.text);
    if (weight != null) {
      await weightEntry().updateWeight(id: int.parse(docId), weight: weight);
    }
    editWeightController.clear();
  }

  Future<void> delete({required String docId}) async {
    await weightEntry().delete(int.parse(docId));
  }

  bool checkWeight(int value) {
    return value < 74;
  }
}