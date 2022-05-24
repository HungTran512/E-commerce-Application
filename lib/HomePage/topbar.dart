  import 'package:flutter/material.dart';
  import 'package:flutter_app/Cart/cart.dart';
// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  TextEditingController _searchController = TextEditingController();
  // final double height;
  //
  // TopBar({this.height = kToolbarHeight});
  //
  // Size get PreferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 140,
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {}),
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
    );
  }
}
