import 'package:firebase_flutter/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    if (brews != null)
      return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown[brews[index].strength],
              ),
              title: Text(brews[index].name),
              subtitle: Text('Takes ${brews[index].sugars} sugars'),
            ),
          );
        },
      );
    else
      return Container();
  }
}
