import 'package:custom_brew/models/user.dart';
import 'package:custom_brew/services/database.dart';
import 'package:custom_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:custom_brew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Update your brew settings",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  initialValue: userData?.name,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                const SizedBox(height: 20.0),
                // Dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars ?? '0',
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) =>
                      setState(() => _currentSugars = val as String),
                ),
                const SizedBox(height: 20.0),
                // Slider
                Slider(
                  value: (_currentStrength ?? (userData?.strength ?? 100))
                      .toDouble(),
                  activeColor: Colors
                      .brown[_currentStrength ?? userData?.strength ?? 100],
                  inactiveColor: Colors
                      .brown[_currentStrength ?? userData?.strength ?? 100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars,
                        _currentName.isEmpty
                            ? (userData?.name ?? '')
                            : _currentName,
                        _currentStrength, // Assuming updateUserData expects a String
                      );
                      Navigator.pop(context); // Close the bottom sheet
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading(); // Show loading indicator while waiting for data
        }
      },
    );
  }
}
