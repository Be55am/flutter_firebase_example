import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/models/user_data.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:firebase_flutter/shared/constants.dart';
import 'package:firebase_flutter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  late String _currentName = '';
  late String _currentSugars = '';
  late int _currentStrength = 0 ;

  late DatabaseService databaseService;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    databaseService = DatabaseService(uid: user.uid);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew Settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    initialValue: userData!.name,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _currentSugars =='' ?  userData.sugars: _currentSugars,
                    hint: Text(
                      'choose one',
                    ),
                    // isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        _currentSugars = value.toString();
                      });
                    },
                    items: sugars.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text('${val} sugars'),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Slider(
                    value: _currentStrength == 0 ? userData.strength.toDouble(): _currentStrength.toDouble(),
                    min: 100,
                    activeColor: Colors.brown[_currentStrength == 0 ? userData.strength : _currentStrength],
                    inactiveColor: Colors.brown[_currentStrength == 0 ? userData.strength : _currentStrength],
                    divisions: 8,
                    max: 900,
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        print(_currentStrength);
                        await databaseService.updateUserData(
                            _currentSugars == '' ? userData.sugars : _currentSugars,
                            _currentName == '' ? userData.name : _currentName,
                            _currentStrength == 0 ? userData.strength : _currentStrength
                        );
                        Navigator.pop(context);
                      }

                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(primary: Colors.pink),
                  )
                ],
              ),
            );
          } else
            return Loading();
        });
  }
}
