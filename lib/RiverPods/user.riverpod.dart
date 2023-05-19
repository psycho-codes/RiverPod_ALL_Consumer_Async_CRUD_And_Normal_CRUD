import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.model.dart';

var i = 3;
final List<User> fakedata = [
  User(id: 1, name: 'ilyas - 1', age: 20),
  User(id: 2, name: 'ilyas - 2', age: 21),
  User(id: 3, name: 'ilyas - 3', age: 22)
];

//! creating an instance of it which will be globally accessed :
final userControllerNotifier =
    StateNotifierProvider<UserControllerNotifier, List<User>>(
        (ref) => UserControllerNotifier());

//! riverpod controller definition
class UserControllerNotifier extends StateNotifier<List<User>> {
  UserControllerNotifier() : super(fakedata);

  void addElement() {
    i++;
    state = [...state, User(id: i, name: 'Ilays - $i', age: 20 + i)];

    print("called and updated");
  }
}
