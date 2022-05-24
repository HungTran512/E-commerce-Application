import 'package:flutter/material.dart';

class Cart_product extends StatefulWidget {
  @override
  _Cart_productState createState() => _Cart_productState();
}

class _Cart_productState extends State<Cart_product> {
  var products_on_cart = [
    {
      'name': 'Mặt Hàng 1',
      'picture': 'assets/login.png',
      'price': 30,
      "size": "M",
      "qty": 1,
    },
    {
      'name': 'Mặt Hàng 4',
      'picture': 'assets/login.jpg',
      'price': 150,
      "size": "M",
      "qty": 1,
    },
    {
      'name': 'Mặt Hàng 5',
      'picture': 'assets/login.png',
      'price': 120,
      "size": "M",
      "qty": 1,
    },
    {
      'name': 'Mặt Hàng 6',
      'picture': 'assets/login.jpg',
      'price': 85,
      "size": "M",
      "qty": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: products_on_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: products_on_cart[index]['name'],
            cart_prod_picture: products_on_cart[index]['picture'],
            cart_prod_price: products_on_cart[index]['price'],
            cart_prod_qty: products_on_cart[index]['qty'],
            cart_prod_size: products_on_cart[index]['size'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_picture,
    this.cart_prod_qty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ===============IMAGE OF PRODUCT ADDED=======
        leading: new Image.asset(
          cart_prod_picture,
          width: 80,
          height: 80,
        ),
        title: new Text(cart_prod_name),
        subtitle: new Column(
          children: <Widget>[
            // ====== Row inside Column
            new Row(
              children: <Widget>[
                // ========== PRODUCT SIZE========
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Kich thuoc"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                //==========PRODUCT QUANTITY========
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                //   child: new Text(" So Luong "),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(4.0),
                //   child: new Text(
                //     "${cart_prod_qty}",
                //     style: TextStyle(color: Colors.red),
                //   ),
                // ),
                // Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: new Text(" ${cart_prod_price} vnd",
                //         style: TextStyle(
                //             color: Colors.red,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold))),
              ],
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(" Tổng: ${cart_prod_price} vnd",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        trailing: new Column(
          children: <Widget> [
            // new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
            // new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
          ],
        ),
      ),
    );
  }
}
