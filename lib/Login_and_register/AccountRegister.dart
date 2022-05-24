import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Users/admin.dart';
import 'package:flutter_app/Login_and_register/auth.dart';
import 'package:flutter_app/Users/user.dart';
import 'package:flutter_app/HomePage/HomePage.dart';
import 'auth.dart';

class AccountRegister extends StatefulWidget {
  @override
  _AccountRegisterState createState() => _AccountRegisterState();
}

class _AccountRegisterState extends State<AccountRegister> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();

  TextEditingController _account = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _ConfirmPassword = TextEditingController();
  TextEditingController _name = TextEditingController();

  String _role;
  String groupValue;
  bool hidePass = true;
  bool loading = false;

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          iconTheme: IconThemeData(
            color: Colors.white60,
          ),
          title: Text('Đăng kí tài khoản '),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          'https://wallpapercave.com/wp/wp2252568.jpg'))),
            ),
            Center(
              child: Visibility(
                  visible: loading ?? true,
                  child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ))),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(40.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Container(
                          width: 200,
                          height: 100,
                          // decoration: BoxDecoration(
                          //     color: Colors.blue,
                          //     borderRadius: BorderRadius.circular(50.0)),
                          child: Image.asset('assets/loginlogo.png')),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Material(
                      borderRadius: BorderRadius.circular((20.0)),
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                          // padding: const EdgeInsets.only(
                          //     left: 15, right: 15, top: 10, bottom: 0),
                          // // padding: EdgeInsets.symmetric(horizontal: 15),
                          children: <Widget>[
                            TextFormField(
                              // keyboardType: TextInputType.phone,
                              controller: _account,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                  ),
                                  labelStyle: TextStyle(color: Colors.black54),
                                  labelText: 'Số Điện Thoại',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  fillColor: Colors.black,
                                  hintText: 'Vui Lòng nhập số điện thoại'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'name cannot be empty';
                                }
                                return null;
                              },
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            ListTile(
                              title: TextFormField(
                                obscureText: hidePass,
                                controller: _password,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black54),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    labelText: 'Nhập Mật khẩu ',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    fillColor: Colors.black,
                                    hintText: 'Mật khẩu phải trên 6 ký tự '),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'password cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'password has to be at least 6 character long';
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    if (hidePass == true) {
                                      hidePass = false;
                                    } else {
                                      hidePass = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            ListTile(
                              title: TextFormField(
                                obscureText: hidePass,
                                controller: _ConfirmPassword,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black54),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    labelText: 'Xác Nhận Mật khẩu ',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    fillColor: Colors.black,
                                    hintText: 'Mật khẩu phải trên 6 ký tự '),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'password cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'password has to be at least 6 character long';
                                  } else if (_ConfirmPassword.text != value) {
                                    return 'Confirm Password did not match original Password';
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    if (hidePass == true) {
                                      hidePass = false;
                                    } else {
                                      hidePass = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black54,
                                    ),
                                    labelStyle:
                                        TextStyle(color: Colors.black54),
                                    labelText: 'Họ Và Tên ',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    fillColor: Colors.black,
                                    hintText: 'Nhập Họ Và Tên '),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'name cannot be empty';
                                  }
                                  return null;
                                }),
                          ]),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Nhà phân phối",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Radio(
                              value: "Nhà phân phối",
                              groupValue: groupValue,
                              activeColor: Colors.red,
                              onChanged: (e) => valueChanged(e)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Người tiêu dùng",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Radio(
                              value: "Người tiêu dùng",
                              groupValue: groupValue,
                              activeColor: Colors.red,
                              onChanged: (e) => valueChanged(e)),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  RaisedButton(
                    onPressed: () async {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => HomePage()));
                      validateForm();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Đăng Kí Tài Khoản ',
                        )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Divider(),
                  //         ),
                  //         Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text('Dang ki bang facebook',
                  //                 style: TextStyle(
                  //                     fontSize: 20, color: Colors.grey))),
                  //         Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Divider(
                  //               color: Colors.black,
                  //             ))
                  //       ],
                  //     )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Bằng việc chọn đăng kí tài khoản, bạn xác nhận đồng ý với Điều Khoản và Điều Kiện của chúng tôi ',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ));
  }

  valueChanged(e) {
    setState(() {
      groupValue = e;
      _role = e;
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      User user = firebaseAuth.currentUser;
      if (user != null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _account.text, password: _password.text)
            .then((user) => {
                  _userServices.createUser({
                    "username": _name.text,
                    "phone": _account.text,
                    "userID": user.user.uid,
                    "role": _role,
                  })
                })
            .catchError((err) => {print(err.toString())});
        if (groupValue == "Người tiêu dùng") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Brand()));
        }
      }
      formState.reset();
    }
  }
}
