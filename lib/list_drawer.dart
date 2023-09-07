import 'package:flutter/material.dart';
import 'package:webnfcflutter/home.dart';

class ListDrawer extends StatefulWidget {
  const ListDrawer({super.key});

  @override
  State<ListDrawer> createState() => _ListDrawerState();
}

class _ListDrawerState extends State<ListDrawer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.input,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Input ID",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
