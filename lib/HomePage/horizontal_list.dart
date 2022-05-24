import 'package:flutter/material.dart';

import 'package:flutter_app/Cart/product_details.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'assets/login.jpg',
            image_caption: 'sample 1',
          ),
          Category(
            image_location: 'assets/login.png',
            image_caption: 'sample 2',
          ),
          Category(
            image_location: 'assets/login.jpg',
            image_caption: 'sample 3',
          ),
          Category(
            image_location: 'assets/login.png',
            image_caption: 'sample 4 ',
          ),
          Category(
            image_location: 'assets/login.jpg',
            image_caption: 'sample 5',
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        //     Navigator.of(context).push(
        //         new MaterialPageRoute(
        //             builder: (context) => new ProductDetails())),
        child: Container(
          // color: Colors.yellowAccent,
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 60.0,
                height: 60.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: new TextStyle(color: Colors.white, fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
