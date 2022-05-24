import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Users/productdb.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_app/Database/category.dart';
import 'package:flutter_app/Database/brand.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  List<String> selectedSizes = <String>[];
  PickedFile _image1;
  PickedFile _image2;
  PickedFile _image3;

  String _currentCategory;
  String _currentBrand;

  bool isLoading = false;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < categories.length; i++) {
      setState(() {
        // print('categories[$i] is: ${categories[i].data()['category']}');
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data()['category']),
                value: categories[i].data()['category']));
      });
      // print('Categories length: ${categories.length}');
      // print('categories [1] = ${categories[1].data()['category']}');
      // print('getcategoriesDropDown: ${items.length}');
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data()['brand']),
                value: brands[i].data()['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          elevation: 0.1,
          title: Text(
            "Them San Pham",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: isLoading == true ? CircularProgressIndicator() : ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          onPressed: () {
                            _selectImage(
                                ImagePicker()
                                    .getImage(source: ImageSource.gallery),
                                1);
                          },
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 2.5),

                          child: _displayChild1(),
                          // child: Padding(
                          //   padding:
                          //       const EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
                          //   child: Icon(
                          //     Icons.add,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          onPressed: () {
                            _selectImage(
                                ImagePicker()
                                    .getImage(source: ImageSource.gallery),
                                2);
                          },
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 2.5),
                          // child: Padding(
                          //   padding:
                          //       const EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
                          //   child: Icon(
                          //     Icons.add,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          child: _displayChild2(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          onPressed: () {
                            _selectImage(
                                ImagePicker()
                                    .getImage(source: ImageSource.gallery),
                                3);
                          },
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 2.5),
                          // child: Padding(
                          //   padding:
                          //       const EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
                          //   child: Icon(
                          //     Icons.add,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          child: _displayChild3(),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      labelText: "Nhap Ten San Pham (toi da 10 ky tu)",
                      labelStyle: TextStyle(color: Colors.black26),
                      hintText: "Ten San Pham",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Ban phai nhap ten san pham ";
                      } else if (value.length > 10) {
                        return "Ten san pham khong duoc qua 10 ky tu";
                      }
                      return null;
                    },
                  ),
                ),

                //========== Chon Category va Brand=======
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Danh Muc:  ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DropdownButton(
                        items: categoriesDropDown,
                        onChanged: changeSelectedCategory,
                        value: _currentCategory),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Brand:  ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DropdownButton(
                        items: brandsDropDown,
                        onChanged: changeSelectedBrand,
                        value: _currentBrand),
                  ],
                ),

                // ======== So luong san pham ==========
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "So luong san pham",
                      labelStyle: TextStyle(color: Colors.black26),
                      hintText: "Nhap so luong san pham",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Ban phai nhap so luong san pham ";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    // initialValue: '0',
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: "Gia san pham",
                      labelStyle: TextStyle(color: Colors.black26),
                      hintText: "Nhap gia san pham",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Ban phai nhap gia san pham ";
                      }
                      return null;
                    },
                  ),
                ),
                Divider(),

                Center(child: Text("Available Sizes")),

                Row(
                  children: <Widget>[
                    // Checkbox(
                    //   value: false,
                    //   onChanged: null,
                    // ),
                    // Text("XS"),
                    Checkbox(
                      value: selectedSizes.contains('S'),
                      onChanged: (value) => changeSelecteSize('S'),
                    ),
                    Text("S"),
                    Checkbox(
                      value: selectedSizes.contains('M'),
                      onChanged: (value) => changeSelecteSize('M'),
                    ),
                    Text("M"),
                    Checkbox(
                      value: selectedSizes.contains('L'),
                      onChanged: (value) => changeSelecteSize('L'),
                    ),
                    Text("L"),
                    // Checkbox(
                    //   value: false,
                    //   onChanged: null,
                    // ),
                    // Text("XL"),
                  ],
                ),

                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Them san pham'),
                  onPressed: () {
                    validateAndUpload();
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      // _currentCategory = categories[0].data()['category'];
      // print('_getCategories: ${categoriesDropDown.length}');
      // print('_currentCategory is: $_currentCategory');
    });
  }

  void _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      // print('_getBrands: ${brandsDropDown.length}');
      // _currentBrand = brands[0].data()['brand'];
      // print('_currentBrand is: $_currentBrand');
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  changeSelecteSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<PickedFile> pickImage, int imageNumber) async {
    PickedFile _tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = _tempImg);
        break;
      case 2:
        setState(() => _image2 = _tempImg);
        break;
      case 3:
        setState(() => _image3 = _tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        File(_image1.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        File(_image2.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        File(_image3.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {

      setState(() => isLoading =true);

      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          // ==== chuyen ten image thanh ngay thang nam.jpg roi luu vao database====
          final String picture1 =
              '1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
          final FirebaseStorage storage = FirebaseStorage.instance;
          UploadTask task1 =
              storage.ref().child(picture1).putFile(File(_image1.path));

          final String picture2 =
              '2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
          UploadTask task2 =
              storage.ref().child(picture2).putFile(File(_image2.path));

          final String picture3 =
              '3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
          UploadTask task3 =
              storage.ref().child(picture3).putFile(File(_image3.path));

          TaskSnapshot snapshot1 = await task1.whenComplete(() => null);
          TaskSnapshot snapshot2 = await task2.whenComplete(() => null);
          TaskSnapshot snapshot3 = await task3.whenComplete(() => null);

          imageUrl1 = await snapshot1.ref.getDownloadURL();
          imageUrl2 = await snapshot2.ref.getDownloadURL();
          imageUrl3 = await snapshot3.ref.getDownloadURL();
          List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

          productService.uploadProduct(
              productName: productNameController.text,
              brand: _currentBrand,
              category: _currentCategory,
              price: int.parse(priceController.text),
              sizes: selectedSizes,
              images: imageList,
              quantity: int.parse(quantityController.text));

          print('image 1:$imageUrl1');
          print('image 2:$imageUrl2');
          print('image 3:$imageUrl3');

          _formKey.currentState.reset();
          setState(() => isLoading = false);
          
          Fluttertoast.showToast(msg: 'Da them san pham danh sach cua ban');
          Navigator.pop(context);
        } else {
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: "Phai chon it nhat 1 size");
        }
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: "Cần phải đưa đủ hình ảnh sản phẩm");
      }
    }
  }
}
