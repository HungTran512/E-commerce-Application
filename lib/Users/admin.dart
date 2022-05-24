import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_app/HomePage/HomePage.dart';
import 'package:flutter_app/Database/category.dart';
import 'package:flutter_app/Database/brand.dart';
import 'package:flutter_app/Cart/add_product.dart';

enum Page { dashboard, manage }

class Brand extends StatefulWidget {
  @override
  _BrandState createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.orange;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryControler = TextEditingController();
  TextEditingController brandControler = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            title: Row(
              children: <Widget>[
                Expanded(
                    child: FlatButton.icon(
                        onPressed: () {
                          setState(() => _selectedPage = Page.dashboard);
                        },
                        icon: Icon(
                          Icons.dashboard,
                          color: _selectedPage == Page.dashboard
                              ? active
                              : notActive,
                        ),
                        label: Text("Thống Kê"))),
                Expanded(
                    child: FlatButton.icon(
                        onPressed: () {
                          setState(() => _selectedPage = Page.manage);
                        },
                        icon: Icon(
                          Icons.sort,
                          color:
                              _selectedPage == Page.manage ? active : notActive,
                        ),
                        label: Text("Quản Lý"))),
              ],
            )),
        body: loadScreen());
  }

  Widget loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.attach_money,
                    size: 30.0,
                    color: Colors.green,
                  ),
                  label: Text('999999 vnd ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0, color: Colors.green))),
              title: Text('Doanh Thu ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.grey)),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text(
                              'Users ',
                            )),
                        subtitle: Text('100 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text(
                              'Danh Mục ',
                            )),
                        subtitle: Text('23 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.track_changes),
                            label: Text(
                              'Sản Phẩm',
                            )),
                        subtitle: Text('120 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.tag_faces),
                            label: Text(
                              'Đã bán ',
                            )),
                        subtitle: Text('13 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.shopping_cart),
                            label: Text(
                              'Đơn hàng ',
                            )),
                        subtitle: Text('5 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text(
                              'Hoàn trả ',
                            )),
                        subtitle: Text('2',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0, color: active)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Trang chủ "),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Thêm sản phẩm"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("list sản phẩm"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Thêm danh mục"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("List Danh mục "),
              onTap: () {},
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.add_outlined),
                title: Text("Add Brands "),
                onTap: () {
                  _brandAlert();
                }),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("danh sách "),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Đăng Xuất "),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryControler,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Add category",
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (categoryControler.text != null) {
                _categoryService.createCategory(categoryControler.text);
                categoryControler.clear();
              }
              Fluttertoast.showToast(msg: ' New category added');
              Navigator.pop(context);
            },
            child: Text("ADD")),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("CLOSE")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandControler,
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Add Brand",
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (brandControler.text != null) {
                _brandService.createBrand(brandControler.text);
                brandControler.clear();
              }
              Fluttertoast.showToast(msg: ' New Brand added');
              Navigator.pop(context);
            },
            child: Text("ADD")),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("CLOSE")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
