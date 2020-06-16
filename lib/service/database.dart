import 'package:flutter/material.dart';

List<Widget> makeIt(AsyncSnapshot snapshot){
    return snapshot.data.documents.map<Widget>(
      (doc){
        return Visibility(
          visible: doc['fullName']!=null,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(doc['fullName']??"Not available"),
                ),
              ),
              Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
            ],
          ),
        );
      }
      ).toList();
  }

  List<Widget> activeIt(AsyncSnapshot snapshot){
    return snapshot.data.documents.map<Widget>(
      (doc){
        return Visibility(
          visible: doc['isLog']??false,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text(doc['fullName']??"Not available"),
                ),
              ),
              Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
            ],
          ),
        );
      }
      ).toList();
  }