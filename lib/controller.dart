import 'package:flutter_getx/model.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final person = Person().obs;

  void updateInfo() {
    person.update((val) {
      val?.age++;
      val?.name = 'Coding Chef';
    });
  }
}