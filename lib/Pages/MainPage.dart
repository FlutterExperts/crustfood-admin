import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/Firebase/DBFireStore.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:fooddeliveryapp/Pages/CartPage.dart';
import 'package:fooddeliveryapp/Pages/Home.dart';
import 'package:fooddeliveryapp/Pages/OrderTracking.dart';
import 'package:fooddeliveryapp/Pages/SearchPage.dart';
import 'package:fooddeliveryapp/Provider/CartItem.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import 'Edit.dart';
import 'OrderTodays.dart';

class MainPage extends StatefulWidget {
  static String id = "MainPage";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  DBFireStore dbFireStore = DBFireStore();

  // getCurrentUser() async{
  //
  //   await _auth.loadUserData();
  //   print("current user : $phoneNumber");
  // }

  // void getUserData() async {
  //   User user = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .get()
  //       .then((userData) {
  //
  //     setState(() {
  //       phoneNumber = userData.data()['PhoneNumber'].toString();
  //       userName = userData.data()['UserName'].toString();
  //
  //     });
  //
  //       });
  //
  //   print("current phoneNumber : $phoneNumber");
  //       }

  List<Widget> _pages = <Widget>[
    Home(),
    CartPage(),
    OrderTodays(),
    Edit()
  ];

  @override
  Widget build(BuildContext context) {
    var cartFood = Provider.of<CartItems>(context);

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) =>
              BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 4, sigmaY: 4),
                child: AlertDialog(
                  title: const Text(
                    "Exit",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  content: const Text(
                    "are you sure?",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Montserrat",
                      color: Color(0xff707070),
                    ),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    const BorderRadius.all(
                      const Radius.circular(15),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(false);
                        },
                        child: const Text(
                          "No",
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Color(0xff707070),
                              fontFamily: "Montserrat"),
                        )),
                    ElevatedButton(
                        onPressed: () => exit(0),
                        child: const Text(
                          "Exit",
                          style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: Color(0xff707070),
                              fontFamily: "Montserrat"),
                        ))
                  ],
                ),
              ),
        );
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: StreamBuilder<QuerySnapshot>(
              stream: dbFireStore.loadOrdersForUser(),
              builder: (context, snapshot) {
                /*
                       i use try catch inside builder because (snapshot.data.docs.length == 0)
                       throw error message
                      */
                try {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: _pages.elementAt(_selectedIndex),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, right: 15, left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: GNav(
                                  curve: Curves.easeOutExpo,
                                  gap: 3,
                                  color: Colors.white,
                                  activeColor: Colors.black,
                                  iconSize: 24,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6.7),
                                  duration: const Duration(milliseconds: 900),
                                  tabBackgroundColor: Colors.white,
                                  tabs: [
                                    const GButton(
                                      icon: Icons.home,
                                      text: 'Home',
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: "Montserrat"),
                                    ),
                                    GButton(
                                      text: 'Cart',
                                      icon: Icons.shopping_cart,

                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: "Montserrat"),
                                      // if i clicked in icon cart disable the badge widget
                                      leading: _selectedIndex != 1
                                          ? Badge(
                                        animationType:
                                        BadgeAnimationType.scale,
                                        animationDuration: const Duration(
                                            milliseconds: 400),
                                        badgeColor:
                                        const Color(0xffff124d),
                                        elevation: 0,
                                        position: BadgePosition.topEnd(
                                            top: -12),
                                        badgeContent: Text(
                                          // when add itemCount in Cart page show numberOfCount in Badge widget
                                          cartFood.itemCount.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        child: const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white),
                                      )
                                          : Badge(
                                        animationType:
                                        BadgeAnimationType.scale,
                                        animationDuration: const Duration(
                                            milliseconds: 400),
                                        badgeColor:
                                        const Color(0xffff124d),
                                        elevation: 0,
                                        position: BadgePosition.topEnd(
                                            top: -12),
                                        badgeContent: Text(
                                          // when add itemCount in Cart page show numberOfCount in Badge widget
                                          cartFood.itemCount.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: _selectedIndex == 2
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    GButton(
                                      icon: Icons.shopping_bag,
                                      text: 'Orders',
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: "Montserrat"),
                                      leading: _selectedIndex == 2 ||
                                          snapshot.data.docs.isEmpty
                                          ? null

                                          : Badge(
                                        animationType:
                                        BadgeAnimationType.scale,
                                        animationDuration: const Duration(
                                            milliseconds: 400),
                                        badgeColor:
                                        const Color(0xffff124d),
                                        elevation: 0,
                                        position: BadgePosition.topEnd(
                                            top: -3, end: -2),

                                        child: Icon(
                                          Icons.shopping_bag,
                                          color: _selectedIndex == 3
                                              ? Colors.white
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    const GButton(
                                      icon: Icons.settings,
                                      text: 'Admin',
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                  selectedIndex: _selectedIndex,
                                  onTabChange: (index) {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } catch (e) {
                  return const Text("");
                }
              })),
    );
  }
}
