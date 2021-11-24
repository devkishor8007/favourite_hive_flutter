import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavPage extends StatelessWidget {
  FavPage({Key? key}) : super(key: key);

  final Box boxFav = Hive.box<String>("favBox");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Favourite Quote"),
          ),
          body: ValueListenableBuilder(
              valueListenable: Hive.box<String>("favBox").listenable(),
              builder: (context, Box box, watch) {
                List favD = List.from(box.values);
                debugPrint(favD.toString());
                if (box.isEmpty) {
                  return const Center(
                      child: Text("There is No Favourite Quote"));
                } else {
                  return ListView(
                    children: [
                      ...favD.map(
                        (e) => ListTile(
                          title: Text(e),
                          trailing: IconButton(
                            onPressed: () {
                              // boxFav.containsKey(index) ?

                              box.deleteAt(0);
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              })),
    );
  }
}
