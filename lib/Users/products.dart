import 'package:flutter/material.dart';

import 'package:flutter_app/Cart/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      'name': 'Mặt Hàng 1',
      'picture': 'assets/login.png',
      'old_price': 20,
      'price': 30,
    },
    {
      'name': 'Mặt Hàng 2',
      'picture': 'assets/login.jpg',
      'old_price': 100,
      'price': 50,
    },
    {
      'name': 'Mặt Hàng 3',
      'picture': 'assets/login.jpg',
      'old_price': 200,
      'price': 150,
    },
    {
      'name': 'Mặt Hàng 4',
      'picture': 'assets/login.png',
      'old_price': 200,
      'price': 150,
    },
    {
      'name': 'Mặt Hàng 5',
      'picture': 'assets/login.png',
      'old_price': 200,
      'price': 150,
    },
    {
      'name': 'Mặt Hàng 6',
      'picture': 'assets/login.jpg',
      'old_price': 200,
      'price': 150,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap : true,
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
          child: Hero(
        tag: prod_name,
        child: Material(
            child: InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              //passing value of prod to the product_details page.
              builder: (context) => new ProductDetails(
                    product_detail_name: prod_name,
                    product_detail_new_price: prod_price,
                    product_detail_old_price: prod_old_price,
                    product_detail_picture: prod_picture,
                  ))),
          child: GridTile(
            footer: Container(
                color: Colors.white70,
                child: ListTile(
                  title: Text(
                    prod_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "$prod_price",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                  // subtitle: Text(
                  //   "$prod_old_price",
                  //   style: TextStyle(
                  //       color: Colors.black54,
                  //       fontWeight: FontWeight.w800,
                  //       decoration: TextDecoration.lineThrough),
                  // ),
                )),
            child: Image.asset(
              prod_picture,
              fit: BoxFit.fill,
            ),
          ),
        )),
      )),
    );
  }
}
