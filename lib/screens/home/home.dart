import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text('Buttom sheet'),
        );
      });
    }


    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () {
                print('Signing Out ...');
                _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(''),
            ),
            TextButton.icon(
                onPressed: (){
                  _showSettingsPanel();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,

                ),
                label: Text(''),
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
