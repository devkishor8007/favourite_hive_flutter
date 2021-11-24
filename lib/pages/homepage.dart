import 'package:flutter/material.dart';
import 'package:hive_fav_data/pages/favpage.dart';
import 'package:hive_fav_data/sample_list_data/list_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box boxFav = Hive.box<String>("favBox");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: boxFav.listenable(),
          builder: (context, Box box, widget) {
            return ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(quotes[index]),
                    trailing: IconButton(
                      onPressed: () {
                        if (box.containsKey(index)) {
                          box.delete(index);
                          return;
                        }
                        box.put(index, quotes[index]);
                      },
                      icon: Icon(
                        box.containsKey(index)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            box.containsKey(index) ? Colors.red : Colors.grey,
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
