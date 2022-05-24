import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter_app/Cart/cart.dart';
import 'horizontal_list.dart';
import 'package:flutter_app/Users/products.dart';
import 'topbar.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/login.png'),
          AssetImage('assets/login.jpg'),
          AssetImage('assets/login.png'),
          AssetImage('assets/login.jpg'),
          AssetImage('assets/login.png'),
          AssetImage('assets/login.jpg'),
          AssetImage('assets/login.png'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        // dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170),
        child: TopBar(),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.blueGrey,
      //
      //
      //   // Material(
      //   //   borderRadius: BorderRadius.circular(10.0),
      //   //   color: Colors.white.withOpacity(0.5),
      //   //   child: Padding(
      //   //       padding: const EdgeInsets.only(left: 12.0),
      //   //       child: ListTile(
      //   //         title: TextFormField(
      //   //           controller: _searchController,
      //   //           decoration: InputDecoration(
      //   //               icon: Icon(Icons.search, color: Colors.redAccent),
      //   //               hintText: "thanh tim kiem...",
      //   //               border: InputBorder.none),
      //   //           validator: (value) {
      //   //
      //   //           },
      //   //         ),
      //   //         // trailing: IconButton(
      //   //         //     icon: Icon(Icons.search, color: Colors.white),
      //   //         //     onPressed: () {})
      //   //       )),
      //   // ),
      //   // actions: <Widget>[
      //   //   new IconButton(
      //   //       icon: Icon(
      //   //         Icons.shopping_cart,
      //   //         color: Colors.redAccent,
      //   //       ),
      //   //       onPressed: null),
      //   // ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // image carousel
            image_carousel,
            //padding widget
            // new Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Center(child: Text(
            //     'Nổi Bật ',
            //     style: TextStyle(
            //         color: Colors.redAccent,
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   ),
            // ),
            HorizontalList(),
            //Horizontal list view

            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Danh muc'),
                )),

            Divider(),
            // HorizontalList(),

            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Danh sach san pham'),
                )),
            // Flexible(
            //   child: Products() ,
            // ),
            Products(),
          ],
        ),
      ),
    );
  }
}
