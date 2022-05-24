import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/HomePage/HomePage.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _account = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _ConfirmPassword = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          iconTheme: IconThemeData(
            color: Colors.white60,
          ),
          title: Text('Đặt Lại Mật Khẩu '),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
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
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Container(
                          width: 200,
                          height: 150,
                          // decoration: BoxDecoration(
                          //     color: Colors.blue,
                          //     borderRadius: BorderRadius.circular(50.0)),
                          child: Image.asset('assets/loginlogo.png')),
                    ),
                  ),

                  Form(
                    key: _formKey,
                    child: Material(
                      borderRadius: BorderRadius.circular((20.0)),
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            // style: TextStyle(color: Colors.black54),
                            keyboardType: TextInputType.phone,
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
                                return 'phone number cannot be empty';
                              } else {
                                Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Tài khoản hoặc mật khẩu không phù hợp';
                                else
                                  return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              obscureText: true,
                              controller: _password,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.black54),
                                  labelStyle: TextStyle(color: Colors.black54),
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
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            // obscureText: true,
                            controller: _name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black54,
                                ),
                                labelStyle: TextStyle(color: Colors.black54),
                                labelText: 'Họ Và Tên ',
                                hintStyle: TextStyle(color: Colors.black54),
                                fillColor: Colors.black,
                                hintText: 'Nhập Họ Và Tên '),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'name cannot be empty';
                                  }
                                  return null;
                                }
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Đặt lại mậr khẩu ',
                        )),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
