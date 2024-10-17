import 'package:flutter/material.dart';
import 'package:flutter_getx/view/product_tile.dart';
import 'package:get/get.dart';
import 'package:flutter_getx/controller/controller.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Shop'),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.view_list_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Obx(() {
            if (controller.isLoading.value)
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductTile(
                  controller.productList[index],
                );
              },
              itemCount: controller.productList.length,
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<Controller>(builder: (controller) {
          return Text(
            'Item: ${controller.count.toString()}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          );
        }),
        icon: Icon(
          Icons.shopping_cart_checkout,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
