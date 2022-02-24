import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/Firebase/DBFireStore.dart';
import 'package:fooddeliveryapp/Firebase/FBAuth.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:fooddeliveryapp/model/orderModel.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderTodays extends StatefulWidget {
  static String id = "OrderHistory";

  @override
  _OrderTodaysState createState() => _OrderTodaysState();
}

class _OrderTodaysState extends State<OrderTodays> {
  final DBFireStore dbFireStore = DBFireStore();
  final FBAuth fbAuth = FBAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  "Order Today's",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: dbFireStore.loadOrdersHistory(),
                    builder: (context, snapshot) {
                      /*
                   i use try catch inside builder because (snapshot.data.docs.length == 0)
                   throw error message
                  */

                      try {
                        if (snapshot.data == null) {
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    height: 260,
                                    width: 260,
                                    child: SvgPicture.asset(order_empty)),
                                const Text(
                                  "No Order yet",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat",
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          List<OrderModel> orders = [];
                          for (var doc in snapshot.data.docs) {
                            var data = doc.data();

                            orders.add(OrderModel(
                                orderNumber: data["orderNumber"],
                                totalPrice: data["totalPrice"],
                                totalQuantity: data["totalQuantity"],
                                shippingPrice: data["ShippingPrice"],
                                phoneNumber: data["phoneNumber"],
                                userName: data["userName"],
                                address: data["address"],
                                orderStatus: data["orderStatus"],
                                dateTime: data["dateTime"],
                                listFood: data["ListFood"]));
                          }
                          return ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "-----  ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff707070),
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                          Text(
                                            orders[index]
                                                .dateTime
                                                .toDate()
                                                .toString()
                                                .substring(0, 16),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff707070),
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "/",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff707070),
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            timeago.format(
                                                orders[index].dateTime.toDate()),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff707070),
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                          const Text(
                                            "  ------",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff707070),
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15,
                                            left: 15,
                                            top: 10,
                                            bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width,
                                            height: 510,
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 20,
                                                        right: 15,
                                                        left: 15),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [

                                                          Expanded(
                                                            child: Container(
                                                              height: 40,
                                                              width: 80,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                color: Colors.black,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius: 3,
                                                                    blurRadius: 4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  const Text(
                                                                    "Total",
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                      "Montserrat",
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Quantity",
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                      "Montserrat",
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 22,
                                                                  ),
                                                                  Text(
                                                                    "${orders[index].totalQuantity}",
                                                                    style:
                                                                    const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Color(
                                                                          0xff0A9400),
                                                                      fontFamily:
                                                                      "Montserrat",
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: const Icon(
                                                              Icons_foodApp
                                                                  .order_number,
                                                              size: 18,
                                                              color:
                                                              Color(0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          orders[index].orderNumber,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            "Montserrat",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: const Icon(
                                                              Icons_foodApp
                                                                  .phone_call,
                                                              size: 18,
                                                              color:
                                                              Color(0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          orders[index].phoneNumber,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Color(0xff707070),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            "Montserrat",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: const Icon(
                                                              Icons_foodApp
                                                                  .customers,
                                                              size: 18,
                                                              color:
                                                              Color(0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          orders[index].userName,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Color(0xff707070),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            "Montserrat",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: const Icon(
                                                              Icons_foodApp.address,
                                                              size: 18,
                                                              color:
                                                              Color(0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          orders[index].address,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Color(0xff707070),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            "Montserrat",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: Icon(
                                                              orders[index]
                                                                  .orderStatus ==
                                                                  "Order Received"
                                                                  ? Icons_foodApp
                                                                  .order
                                                                  : orders[index]
                                                                  .orderStatus ==
                                                                  "Being Prepared"
                                                                  ? Icons_foodApp
                                                                  .order
                                                                  : orders[index]
                                                                  .orderStatus ==
                                                                  "On The Way"
                                                                  ? Icons_foodApp
                                                                  .order_ontheway
                                                                  : orders[index].orderStatus ==
                                                                  "Delivered"
                                                                  ? Icons_foodApp
                                                                  .order_success
                                                                  : Icons_foodApp
                                                                  .order,
                                                              size: 18,
                                                              color: const Color(
                                                                  0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          orders[index].orderStatus,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                            Color(0xff0A9400),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily:
                                                            "Montserrat",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 17,
                                                  ),
                                                  const Text(
                                                    " ------------------- Food List ------------------- ",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xff707070),
                                                      fontFamily: "Montserrat",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 35,
                                                            decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        0.1),
                                                                    spreadRadius:
                                                                    3,
                                                                    blurRadius:
                                                                    4,
                                                                    offset: const Offset(
                                                                        0,
                                                                        2), // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    30)),
                                                            child: const Icon(
                                                              Icons_foodApp.order,
                                                              size: 18,
                                                              color:
                                                              Color(0xff544646),
                                                            )),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        SizedBox(
                                                          width: 250,
                                                          child: Text(
                                                            "${List.from(orders[index].listFood)}",
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color:
                                                              Color(0xff707070),
                                                              fontFamily:
                                                              "Montserrat",
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      } catch (e) {
                        return  Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: 260,
                                  width: 260,
                                  child: SvgPicture.asset(order_empty)),
                              const Text(
                                "No Order yet",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ));
  }
}