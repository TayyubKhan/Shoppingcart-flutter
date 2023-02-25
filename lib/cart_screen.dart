import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/db_helper.dart';
import 'cart_model.dart';
import 'cart_provider.dart';
import 'const/Color.dart';

class Cart_screen extends StatefulWidget {
  const Cart_screen({Key? key}) : super(key: key);

  @override
  State<Cart_screen> createState() => _Cart_screenState();
}

class _Cart_screenState extends State<Cart_screen> {
  DBHelper? db = DBHelper();
  CartProvider cp = CartProvider();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultcolor,
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Center(
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
          const SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getdata(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.data!.isEmpty) {
                return Image(image: Ass)
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: AssetImage(snapshot
                                              .data![index].image
                                              .toString()),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                        .productName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.07),
                                                  InkWell(
                                                      onTap: () {
                                                        db!.delete(snapshot
                                                            .data![index].id!);
                                                        cart.removecartcountr();
                                                        cart.removeTotalPrice(
                                                            double.parse(snapshot
                                                                .data![index]
                                                                .productPrice
                                                                .toString()));
                                                      },
                                                      child: const Icon(
                                                          Icons.delete))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'RS ${snapshot.data![index].productPrice.toString()}/.',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                            snapshot
                                                                .data![
                                                            index]
                                                                .quantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity--;
                                                            int? newprice =
                                                                price *
                                                                    quantity;
                                                            if (quantity >= 1) {
                                                              db!
                                                                  .update(Cart(
                                                                  id: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id,
                                                                  productId: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id
                                                                      .toString(),
                                                                  productName: snapshot
                                                                      .data![
                                                                  index]
                                                                      .productName
                                                                      .toString(),
                                                                  initialPrice: snapshot
                                                                      .data![
                                                                  index]
                                                                      .initialPrice,
                                                                  productPrice:
                                                                  newprice,
                                                                  quantity:
                                                                  quantity,
                                                                  image: snapshot
                                                                      .data![
                                                                  index]
                                                                      .image
                                                                      .toString()))
                                                                  .then(
                                                                      (value) {
                                                                    newprice = 0;
                                                                    quantity = 0;
                                                                    cart.removeTotalPrice(
                                                                        double.parse(snapshot
                                                                            .data![
                                                                        index]
                                                                            .initialPrice!
                                                                            .toString()));
                                                                  }).onError((error,
                                                                  stackTrace) {
                                                                print(error);
                                                              });
                                                            }
                                                          },
                                                          child: const Icon(
                                                              Icons.remove)),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        snapshot.data![index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 25),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                            snapshot
                                                                .data![
                                                            index]
                                                                .quantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity++;
                                                            int? newprice =
                                                                price *
                                                                    quantity;
                                                            if (quantity >= 1) {
                                                              db!
                                                                  .update(Cart(
                                                                  id: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id,
                                                                  productId: snapshot
                                                                      .data![
                                                                  index]
                                                                      .id
                                                                      .toString(),
                                                                  productName: snapshot
                                                                      .data![
                                                                  index]
                                                                      .productName
                                                                      .toString(),
                                                                  initialPrice: snapshot
                                                                      .data![
                                                                  index]
                                                                      .initialPrice,
                                                                  productPrice:
                                                                  newprice,
                                                                  quantity:
                                                                  quantity,
                                                                  image: snapshot
                                                                      .data![
                                                                  index]
                                                                      .image
                                                                      .toString()))
                                                                  .then(
                                                                      (value) {
                                                                    newprice = 0;
                                                                    quantity = 0;
                                                                    cart.addTotalPrice(
                                                                        double.parse(snapshot
                                                                            .data![
                                                                        index]
                                                                            .initialPrice!
                                                                            .toString()));
                                                                  }).onError((error,
                                                                  stackTrace) {
                                                                print(error);
                                                              });
                                                            }
                                                          },
                                                          child: const Icon(
                                                              Icons.add)),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
                }
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Column(
              children: [
                Visibility(
                  visible: cp.getTotalPrice() == 0 ? false : true,
                  child: Container(
                    width: 400,
                    height: 50,
                    color: defaultcolor,
                    child: Center(
                      child: ReuseableWidget(
                          title: 'Total= ',
                          value: 'Rs ${cp.getTotalPrice().toString()}'),
                    ),
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  String title, value;
  ReuseableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(title + value,
        style: const TextStyle(color: Colors.white, fontSize: 20));
  }
}
