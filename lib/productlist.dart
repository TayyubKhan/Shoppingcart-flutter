import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/cart_model.dart';
import 'package:shoppingcart/cart_provider.dart';
import 'package:shoppingcart/cart_screen.dart';
import 'package:shoppingcart/const/Color.dart';
import 'package:shoppingcart/db_helper.dart';

class ProductListscreen extends StatefulWidget {
  const ProductListscreen({Key? key}) : super(key: key);
  @override
  State<ProductListscreen> createState() => _ProductListscreenState();
}

class _ProductListscreenState extends State<ProductListscreen> {
  DBHelper? db = DBHelper();
  var operator = 0;
  CartProvider cp = CartProvider();
  List<String> product_name = [
    'Wall Clock',
    'Dell Laptop',
    'HP Laptop',
    'Smart Watch',
    'Paper Bag',
    'Leather Bag',
    'Leather Bag',
    'Leather Bag',
    'Laptop Bag',
    'Leather Bag'
  ];
  List<int> Product_price = [
    10000,
    90000,
    85000,
    12000,
    500,
    5000,
    3000,
    1500,
    1800,
    2000
  ];
  List<String> Product_images = [
    'Images/wallclock.jpeg',
    'Images/laptop.jpeg',
    'Images/hp.jpeg',
    'Images/smartwatch.jpeg',
    'Images/paperbag.jpeg',
    'Images/bag1.jpeg',
    'Images/bag2.jpeg',
    'Images/bag3.jpeg',
    'Images/schoolbag.jpeg',
    'Images/bag4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultcolor,
        title: const Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Cart_screen()));
            },
            child: Center(
              child: Badge(
                showBadge: true,
                badgeColor: Colors.white,
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(value.getcartcounter().toString(),
                        style: const TextStyle(color: Colors.black));
                  },
                ),
                animationType: BadgeAnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: product_name.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: AssetImage(
                                    Product_images[index].toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product_name[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'RS${Product_price[index]}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              db!
                                                  .insert(Cart(
                                                      id: index,
                                                      productId:
                                                          index.toString(),
                                                      productName:
                                                          product_name[index]
                                                              .toString(),
                                                      initialPrice:
                                                          Product_price[index],
                                                      productPrice:
                                                          Product_price[index],
                                                      quantity: 1,
                                                      image:
                                                          Product_images[index]
                                                              .toString()))
                                                  .then((value) {
                                                cart.addTotalPrice(double.parse(
                                                    Product_price[index]
                                                        .toString()));
                                                cart.addcartcounter();
                                                const snackBar = SnackBar(
                                                  content: Text(
                                                    'Product is added to Cart',
                                                  ),
                                                  backgroundColor: defaultcolor,
                                                  duration:
                                                      Duration(seconds: 1),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }).onError((error, stackTrace) {
                                                const snackBar = SnackBar(
                                                    content: Text(
                                                        'Product is already added to Cart'),
                                                    backgroundColor:
                                                        defaultcolor,
                                                    duration:
                                                        Duration(seconds: 1));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: defaultcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Center(
                                                child: Text(
                                                  'Add to cart',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
