import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five/modules/kid.dart';
import 'package:flutter/material.dart';
import 'edit.dart';

class Profile extends StatefulWidget {
  final ChurchKid kid;
  final String docId;
  const Profile({
    this.docId, this.kid,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    // print(widget.docId);
    print(widget.kid.bornDay.toDate());

    return _profile();
  }

  Widget _table(){

    return DataTable(
      columnSpacing: 100,
      columns: <DataColumn>[
        DataColumn(label: Text("Info",style: TextStyle(fontSize:25,fontFamily: "OpenSans"))),
        DataColumn(label: Text("Data",style: TextStyle(fontSize:25,fontFamily: "OpenSans")))
      ], 
      rows: <DataRow>[
        DataRow(
          cells:<DataCell>[
            DataCell(Text("First Name",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.firstName.toString(),style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),

        DataRow(
          cells:<DataCell>[
            DataCell(Text("Last Name",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.lastName.toString(),style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),

        DataRow(
          cells:<DataCell>[
            DataCell(Text("Guardian Name",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.gName.toString(),style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),

        DataRow(
          cells:<DataCell>[
            DataCell(Text("Guardian Phone",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.gPhone,style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),

        DataRow(
          cells:<DataCell>[
            DataCell(Text("Gender",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.sex,style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),

        DataRow(
          cells:<DataCell>[
            DataCell(Text("Birthday\n(YYYY-MM-DD)",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text(widget.kid.bornDay.toDate().toString().substring(0,11),style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),
        
        DataRow(
          cells:<DataCell>[
            DataCell(Text("Allergies",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
            DataCell(Text((widget.kid.allergies??"NONE").isEmpty?"NONE":widget.kid.allergies??"NONE",style: TextStyle(fontSize:15,fontFamily: "OpenSans"))),
          ]),
      ]
      );
  }
  
  Widget _profile(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(fontFamily:"OpenSans"),)),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
           child:Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Text(widget.kid.fullName,
              style: TextStyle(fontFamily:"One",fontSize:45),
              ),
              SizedBox(height: 20,),
              // Divider(thickness: 1.5,color: Colors.black,),
              _table(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 10, 20),
                    child: FloatingActionButton.extended(
                      heroTag: "delet",
                      onPressed: () async {
                        try{
                          print("fucnk");
                          await Firestore.instance.collection("kids-Church").document(widget.docId.toString()).delete();
                          Navigator.pop(context);
                        }catch(e){
                          print(e.message);
                        }
                      }, 
                      label: Text("DELETE"),
                      backgroundColor: Colors.red,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 20),
                    child: FloatingActionButton.extended(
                      heroTag: "Edit",
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditThat(kid: widget.kid,docId: widget.docId,)),
                          );
                      }, 
                      label: Text(" EDIT IT "),
                      backgroundColor: Colors.purple,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}