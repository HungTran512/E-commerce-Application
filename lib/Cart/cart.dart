import 'package:flutter/material.dart';

import 'package:flutter_app/Cart/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBAr
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(Icons.keyboard_return),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       }),
          // ]
      ),

      // =====body=======
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                      'https://wallpapercave.com/wp/wp2252568.jpg'))),
        ),
        new Cart_product(),
      ],),

      //======checkout bar=====
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Tổng Hoá Đơn: "),
                subtitle: new Text("\$230 vnd"),
              ),
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                child: new Text(
                  " Thanh Toán ",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
