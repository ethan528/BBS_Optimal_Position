import 'package:flutter_getx/data/services.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class Controller extends GetxController {
  var productList = <Product>[].obs;
  RxBool isLoading = false.obs;
  var cartItems = <Product>[].obs;
  int get count => cartItems.length;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    var products = await Services.fetchProducts();
    if (products != null) {
      productList.value = products;
    }
    isLoading.value = false;
  }

  void addToItem(Product product) {
    cartItems.add(product);
  }
}
