import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'horizontal_list.dart';
import 'package:flutter_app/Users/products.dart';

import 'package:flutter_app/Login_and_register/login.dart';
import 'package:flutter_app/Foundation.dart';
import 'HomePage2.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key, this.title}) : super (key: key);
  // final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> tabs = [
    HomePage2(),
    LoginDemo(),
    LoginDemo(),
    LoginDemo(),
    LoginDemo()
  ];

  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.transparent,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.blueGrey),
                title: Text(
                  'Trang Chủ ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.scanner, color: Colors.blueGrey),
                title: Text('Quét Voucher ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.blueGrey),
                title: Text('Thông báo ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.message, color: Colors.blueGrey),
                title: Text('Hỗ Trợ ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.blueGrey),
                title: Text('Tài khoản ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomePage2();
                break;
              case 1:
                return LoginDemo();
                break;
              case 2:
                return LoginDemo();
                break;
              case 3:
                return LoginDemo();
                break;
              case 4:
                return LoginDemo();
                break;
              default:
                return HomePage2();
                break;
            }
          });
    } else {
      return new Scaffold(
        // extendBody: true,
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),

        //Bottom Navigation Bar
        // appBar: AppBar(
        //   backgroundColor: Colors.deepPurple,
        //   title: Text('Trang Chủ'),
        //   actions: <Widget>[
        //     new IconButton(
        //         icon: Icon(
        //           Icons.search,
        //           color: Colors.white,
        //         ),
        //         onPressed: null),
        //     new IconButton(
        //         icon: Icon(
        //           Icons.shopping_cart,
        //           color: Colors.white,
        //         ),
        //         onPressed:(){
        //           Navigator.push(
        //               context, MaterialPageRoute(builder: (_) => LoginDemo()));
        //         }),
        //   ],
        // ),

        //Drawer
        // drawer: new Drawer(
        //   child: new ListView(
        //     children: <Widget>[
        //       //header
        //       new UserAccountsDrawerHeader(
        //           accountName: Text('Hưng '),
        //           accountEmail: Text('0123455'),
        //           currentAccountPicture: GestureDetector(
        //             child: new CircleAvatar(
        //               backgroundColor: Colors.grey,
        //               child: Icon(
        //                 Icons.person,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //           decoration: new BoxDecoration(
        //             color: Colors.deepPurple,
        //           )),
        //       //body
        //       // InkWell(
        //       //   onTap: () {},
        //       //   child: ListTile(
        //       //     title: Text('Trang Chủ'),
        //       //     leading: Icon(Icons.home, color: Colors.blueGrey),
        //       //   ),
        //       // ),
        //
        //       InkWell(
        //         onTap: () {
        //           Navigator.push(
        //               context, MaterialPageRoute(builder: (_) => LoginDemo()));
        //         },
        //         child: ListTile(
        //           title: Text('Tài Khoản '),
        //           leading: Icon(Icons.person, color: Colors.blueGrey),
        //         ),
        //       ),
        //       Divider(),
        //       // InkWell(
        //       //   onTap: () {},
        //       //   child: ListTile(
        //       //     title: Text('Lịch Sử Mua Hàng '),
        //       //     leading: Icon(Icons.shopping_basket, color: Colors.blueGrey),
        //       //   ),
        //       // ),
        //
        //       InkWell(
        //         onTap: () {},
        //         child: ListTile(
        //           title: Text('Điều khiển '),
        //           leading: Icon(Icons.dashboard, color: Colors.blueGrey),
        //         ),
        //       ),
        //
        //       // InkWell(
        //       //   onTap: () {},
        //       //   child: ListTile(
        //       //     title: Text('Yêu Thích '),
        //       //     leading: Icon(Icons.favorite, color: Colors.blueGrey),
        //       //   ),
        //       // ),
        //
        //       Divider(),
        //       InkWell(
        //         onTap: () {},
        //         child: ListTile(
        //           title: Text('Cài Đặt '),
        //           leading: Icon(Icons.settings, color: Colors.blueGrey),
        //         ),
        //       ),
        //       Divider(),
        //       InkWell(
        //         onTap: () {},
        //         child: ListTile(
        //           title: Text('Chính sách '),
        //           leading: Icon(Icons.help, color: Colors.blueGrey),
        //         ),
        //       ),
        //       Divider(),
        //       InkWell(
        //         onTap: () {
        //           Navigator.pop(context);
        //           Navigator.pop(context);
        //         },
        //         child: ListTile(
        //           title: Text('Đăng Xuất '),
        //           leading: Icon(Icons.logout, color: Colors.blueGrey),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // body: HomePage2(),

        body:  tabs[_currentIndex],
        bottomNavigationBar: new Container(
          color: Colors.transparent,
          child:  new BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              new BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.home, color: Colors.blueGrey),
                title: Text(
                  'Trang Chủ ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.scanner, color: Colors.blueGrey),
                title: Text('Quét Voucher ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.notifications, color: Colors.blueGrey),
                title: Text('Thông báo ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.message, color: Colors.blueGrey),
                title: Text('Hỗ Trợ ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              new BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.person, color: Colors.blueGrey),
                title: Text('Tài khoản ',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        )

          // extendBodyBehindAppBar: true,
          // extendBody: true,
      );
    }
  }
}
