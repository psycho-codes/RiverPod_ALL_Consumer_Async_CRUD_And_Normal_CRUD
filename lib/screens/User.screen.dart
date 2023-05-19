import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all/RiverPods/user.riverpod.dart';
import 'package:riverpod_all/models/user.model.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
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
                  //! let's get the norifier (controller ) then access the state it has :
                  final stateController =
                      ref.watch(userControllerNotifier);
                  return Row(
                    children: [
                      FloatingActionButton(onPressed: () {
                        ref.read(userControllerNotifier.notifier).addElement();
                      }),
                      Container(
                        height: 300,
                        width: 300,
                        child: ListView.builder(
                          itemCount: stateController.length,
                          itemBuilder: (context, index) {
                            return MyTransformer(stateController[index]);
                          },
                        ),
                      ),
                    ],
                  );
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
