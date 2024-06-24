import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_brew/screens/home/brew_tile.dart';
import 'package:custom_brew/models/brew.dart';

class BrewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        final brew = brews[index];
        return ListTile(
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
          trailing: Text('Strength: ${brew.strength}'),
        );
      },
    );
  }
}
