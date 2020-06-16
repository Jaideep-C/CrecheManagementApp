import 'package:flutter/material.dart';
import 'package:five/modules/kid.dart';

class KidTile extends StatelessWidget {
  final ChurchKid kid;

  const KidTile({ this.kid}) ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(kid.fullName),
        ),
      ),
    );
  }
}