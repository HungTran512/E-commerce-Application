
import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  createUser(Map value) {
    String id = value["userId"];
    _database
        .reference()
        .child("$ref/$id")
        .set(value)
        .catchError((e) => {print(e.toString())});
  }


// final String id;
// final String fullName;
// final String phone;
// final String userRole;
// UserServices({this.id, this.fullName, this.phone, this.userRole});
// UserServices.fromData(Map<String, dynamic> data)
//     : id = data['id'],
//       fullName = data['fullName'],
//       phone = data['phone'],
//       userRole = data['userRole'];
// Map<String, dynamic> toJson() {
//   return {
//     'id': id,
//     'fullName': fullName,
//     'phone': phone,
//     'userRole': userRole,
//   };
// }
}
