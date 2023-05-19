import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all/RiverPods/user.async.riverpod.dart';
import 'package:riverpod_all/RiverPods/user.riverpod.dart';
import 'package:riverpod_all/models/user.model.dart';

class UserAsyncWidget extends StatefulWidget {
  const UserAsyncWidget({super.key});

  @override
  State<UserAsyncWidget> createState() => _UserAsyncWidgetState();
}

class _UserAsyncWidgetState extends State<UserAsyncWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.pink.shade100,
        child: Align(
          child: SizedBox(
              height: 500,
              width: 500,
              child: Consumer(
                builder: (context, ref, child) {
                  //! let's get the controller :
                  final riverPodController =
                      ref.watch(userAsyncRiverpodController);

                  return riverPodController.when(data: (data) {
                    return SizedBox(
                      height: 300,
                      width: 300,
                      child: Row(
                        children: [
                          FloatingActionButton(onPressed: () {
                            ref
                                .read(userAsyncRiverpodController.notifier)
                                .UpdatAsyncData();
                          }),
                          Container(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return MyTransformer(data[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }, error: (Object e, StackTrace s) {
                    return Text('$e : $s');
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  });
                },
              )),
        ),
      ),
    );
  }
}

Widget MyTransformer(User user) {
  return Container(
    margin: const EdgeInsets.all(20),
    height: 200,
    width: 200,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(20)),
    child: ListTile(
      title: Center(child: Text("${user.id} - ${user.name} : ${user.age}")),
      trailing: const Icon(
        Icons.favorite,
        color: Colors.white,
      ),
    ),
  );
}
