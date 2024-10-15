import 'package:flutter/material.dart';
import 'package:flutter_getx/controller/cart_controller.dart';
import 'package:flutter_getx/controller/shopping_controller.dart';
import 'package:get/get.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Expanded(
            child: GetX<ShoppingController>(builder: (controller) {
              return Scrollbar(
                child: ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.products[index].productName}',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                        '${controller.products[index].productDescription}'),
                                  ],
                                ),
                                Text(
                                  '\$${controller.products[index].price}',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                cartController.addToItem(controller.products[index]);
                              },
                              child: Text('Add to cart'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          SizedBox(
            height: 30,
          ),
          GetX<CartController>(
            builder: (controller) {
              return Text(
                'Total amount \$${controller.totalPrice}',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              );
            }
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: GetX<CartController>(
          builder: (controller) {
            return Text(
              controller.count.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            );
          }
        ),
        icon: Icon(Icons.add_shopping_cart_rounded),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
