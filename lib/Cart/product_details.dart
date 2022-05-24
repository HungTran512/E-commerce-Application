import 'package:flutter/material.dart';

import 'package:flutter_app/Cart/cart.dart';
import 'package:flutter_app/HomePage/topbar.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_old_price,
    this.product_detail_picture,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //AppBar
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 140,
            color: Colors.blueGrey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {Navigator.pop(context);}),
                    // Container(
                    //   height: 100,
                    //   child: Image(image: AssetImage('assets/loginlogo.png')),
                    // ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: Colors.white,
                              )),
                          IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));} ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.white,
                    child: ListTile(
                        title: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.search, color: Colors.blueGrey),
                              hintText: "thanh tim kiem...",
                              border: InputBorder.none),
                          validator: (value) {},
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.camera_alt_outlined,
                                color: Colors.blueGrey),
                            onPressed: () {}))),
              ],
            ),
          ),
        ),

        //Body
        body: new ListView(children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
                child: Container(
                  color: Colors.white70,
                  child: Image.asset(widget.product_detail_picture),
                ),
                footer: new Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: new Text(widget.product_detail_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      title: new Row(
                        children: <Widget>[
                          Expanded(
                              child: new Text(
                            "${widget.product_detail_old_price} vnd",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          )),
                          Expanded(
                              child: new Text(
                                  "${widget.product_detail_new_price} vnd",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ))),
                        ],
                      ),
                    ))),
          ),

          // =========first button===========
          Row(
            children: <Widget>[
              //========size button==========
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return new AlertDialog(
                            title: new Text("Kích thước "),
                            content: new Text("chon kich thước mong muốn"),
                            actions: <Widget>[
                              new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("Thoát "),
                                  color: Colors.red)
                            ]);
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(children: <Widget>[
                  Expanded(
                    child: new Text("Kích thước "),
                  ),
                  Expanded(child: new Icon(Icons.arrow_drop_down)),
                ]),
              )),

              // ==========the second button 2========
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return new AlertDialog(
                            title: new Text("Số lượng "),
                            content: new Text("chon số lượng mong muốn"),
                            actions: <Widget>[
                              new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("Thoát "),
                                  color: Colors.red)
                            ]);
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(children: <Widget>[
                  Expanded(
                    child: new Text("Số lượng "),
                  ),
                  Expanded(child: new Icon(Icons.arrow_drop_down)),
                ]),
              )),
            ],
          ),

          // Nút Mua ngay
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0.2,
                      child: new Text('Mua ngay'))),
              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.blueGrey,
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.blueGrey,
                  onPressed: () {}),
            ],
          ),

          Divider(),
          // Phần mô tả sản phẩm
          new ListTile(
              title: new Text("Mô tả sản phẩm"),
              subtitle: new Text(
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")),
          Divider(),
          new Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
              child: new Text("Tên Sản Phẩm",
                  style: TextStyle(color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: new Text(widget.product_detail_name),
            ),
          ]),
          new Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
              child:
                  new Text("Thương hiệu", style: TextStyle(color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: new Text("Random brand"),
            ),
          ]),
          new Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
              child: new Text("Số lượng trong kho",
                  style: TextStyle(color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: new Text("Random number"),
            ),
          ]),
          new Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
              child: new Text("Tình trạng sản ",
                  style: TextStyle(color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: new Text("Mới "),
            ),
          ]),

          // Divider(),

          Center(
            child: new Text("Các sản phẩm tương tự",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(),
          //==========Similar Product=========
          Container(
            height: 270,
            child: Similar_products(),
          )
        ]));
  }
}

// =======Similar Product Class======
class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  @override
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
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: Row(children: <Widget>[
              Expanded(
                child: Text(
                  prod_name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              new Text(
                "${prod_price} vnd",
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          child: Image.asset(
            prod_picture,
            fit: BoxFit.cover,
          ),
        ),
      )),
    ));
  }
}
