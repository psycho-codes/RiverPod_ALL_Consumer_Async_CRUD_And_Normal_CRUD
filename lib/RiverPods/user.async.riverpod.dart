import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all/models/user.model.dart';

var j = 3;

Future<List<User>> fakeDtb() async {
  await Future.delayed(const Duration(seconds: 1));

  final futureData = [
    User(id: 1, name: 'async - 1', age: 20),
    User(id: 2, name: 'async - 2', age: 21),
    User(id: 3, name: 'async - 3', age: 22)
  ];
  return futureData;
}

//! definition of the Controller Provider :
class AsyncControllerStateProvider
    extends StateNotifier<AsyncValue<List<User>>> {
  AsyncControllerStateProvider() : super(const AsyncLoading()) {
    print('We are initializing the async data');
    _init();
  }

  void _init() async {
    final data = await fakeDtb();
    state = AsyncData(data);

    print("Data initialazed and stata updated");
  }

  void UpdatAsyncData() async {
    print("here we are async updating");
    j++;

    final List<User> newListData = [
      ...state.value!,
      User(id: j, name: 'Ilays - $j', age: 20 + j),
    ];
     state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 2));

    state = AsyncData(newListData);
  }
}

//! exposing the ControllerProvider

final userAsyncRiverpodController =
    StateNotifierProvider<AsyncControllerStateProvider, AsyncValue<List<User>>>(
        (ref) => AsyncControllerStateProvider());
