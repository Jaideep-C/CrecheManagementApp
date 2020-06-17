import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five/utilities/loading.dart';
import 'package:flutter/material.dart';

class AddChurchKid extends StatefulWidget {

  AddChurchKid({Key key}) : super(key:key);
  @override
  _AddChurchKidState createState() => _AddChurchKidState();
}

class _AddChurchKidState extends State<AddChurchKid> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  String _firstName,_lastName;
  DateTime _bornDay;
  String _gName;
  var _sex="Gender";
  String _gPhone;
  bool _loading=false;
  String _allergies,_error="nope";
  var gender=["Gender","Male","Female","Other"];

  Widget _newProfile(){
    return Form(
      key: _formKey,
        child: Column(
        children: <Widget>[
          //First Name
          Theme(
            data: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    _firstName=val;
                  });
                },
                validator: (String val) {
                  if(val.isEmpty) 
                    return "First Name shouldn't not be empty";
                  else return null;
                },
                onSaved: (String val){
                  _firstName=val;
                },
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "OpenSans",
                ),
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                  ),
                  alignLabelWithHint:true,
                  hoverColor: Colors.white,
                  hintText: "Keanu",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          //Last Name
          Theme(
            data: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                validator: (String val){
                  if(val.isEmpty){
                    return "Last Name shouldn't be empty";
                  } else return null;
                },
                onChanged: (val){
                  setState(() {
                    _lastName=val;
                  });
                },
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "OpenSans",
                ),
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                  ),
                  alignLabelWithHint:true,
                  hoverColor: Colors.white,
                  hintText: "Reeves",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:5,),
          //G Name
          Theme(
            data: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                validator: (String value) {
                  if(value.isEmpty){
                    return "Guardian's Name shouldn't be empty";
                  }else return null;
                },
                onChanged: (val){
                  setState(() {
                    _gName=val;
                  });
                },
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "OpenSans",
                ),
                decoration: InputDecoration(
                  labelText: "Guardian's Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                  ),
                  alignLabelWithHint:true,
                  hoverColor: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height:5,),
          //G Phone
          Theme(
            data: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                validator: (String val) {
                  if(val.isEmpty) 
                    return "Guardian Phone shouldn't not be empty";
                  else return null;
                },
                onChanged: (val){
                  setState(() {
                    _gPhone=val;
                  });
                },
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "OpenSans",
                ),
                decoration: InputDecoration(
                  labelText: "Guardian's Contact Number",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                  ),
                  alignLabelWithHint:true,
                  hoverColor: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height:10),
          //Birthday and Gender
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Gender
              Container(
                padding:EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                borderRadius: BorderRadius.circular(30)),
                child: Theme(
                  data: ThemeData(
                    fontFamily: "OpenSans",
                    canvasColor: Colors.orange,
                    ),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 15.6,
                      ),
                    items: gender.map((String dropDownStringItem){
                      return DropdownMenuItem(
                        value:dropDownStringItem,
                        child: Text(dropDownStringItem));
                    }).toList(), 
                    onChanged: (val){
                      setState(() {
                        // print(val);
                        this._sex=val;
                      });
                    },
                    value: _sex,
                  ),
                ),
              ),
              SizedBox(width:10),
              //Date Picker  
              FloatingActionButton.extended(
                heroTag: "Date of Birth",
                elevation:5,
                backgroundColor: Colors.orange,
                icon: Icon(Icons.cake),
                label: Text(
                  (_bornDay==null)?("Birthday"):(_bornDay.day.toString()+"/"+_bornDay.month.toString()+"/"+_bornDay.year.toString()),
                  style: TextStyle(
                      color:Colors.white,
                      fontFamily: "OpenSans",
                    ),
                ),
                onPressed: (){
                  showDatePicker(
                    context: context,
                    initialDate: (_bornDay==null)?DateTime.now():_bornDay, 
                    firstDate: DateTime(1950), 
                    lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        _bornDay=value;
                        print(_bornDay);
                      });
                    });
                },
              ),
            ],
          ),
          SizedBox(height:10),
          //Allergies
          Theme(
            data: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _allergies=value;
                  });
                },
                autocorrect: true,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.white,
                  fontFamily: "OpenSans",
                ),
                decoration: InputDecoration(
                  labelText: "Allergies",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                  ),
                  alignLabelWithHint:true,
                  hintText: "Allergie_1, Allergies_2, Allergies_3",
                  hintStyle: TextStyle(
                    color: Colors.white24,
                    fontFamily: "OpenSans",
                  ),
                  hoverColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );   
  }


  // Submit button:
    Widget _addBtn() {
    return FloatingActionButton.extended(
      onPressed:(){
        setState(() {
          if(_sex=="Gender"){
            _error="Gender Shouldn't be empty";
          }else if(_bornDay==null){
            _error="Birthday Shouldn't be empty";
          }else{
            _error="nope";
            if(_formKey.currentState.validate()){
              _formKey.currentState.save();
              try{
                _loading=true;
                doIt();
                Navigator.pop(context);
                print("Done");
              }catch(e){
                _loading=false;
                print(e.code);
                _error=e.code;
              }
            }
          }
        });
      } , 
      heroTag: "addButton",
      backgroundColor: Colors.amber,
      label: Padding(
        padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),//symmetric(vertical:0,horizontal:100),
        child: Text(
          "ADD ;)",
          style: TextStyle(
            fontFamily:"OpenSans",
          ),
          ),
      ),
      
      );
  }
  Future doIt() async{
    Firestore.instance.collection("kids-Church").document()
    .setData(
      {
        "firstName":_firstName,
        "lastName":_lastName,
        "gName":_gName,
        "gPhone":_gPhone, 
        "sex":(_sex=="gender")?("Did not provide"):(_sex),
        "allergies":_allergies,
        "bornDay":_bornDay,
        "isLog":false,
        "fullName":_firstName+" "+_lastName,
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    return (_loading)?(Loading()):Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF398AE5),
      ),
      body:Stack(
          children:<Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add a new profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'one',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 10,
                      ),
                      _newProfile(),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: Visibility(
                          visible: _error!="nope",
                          child: Center(
                            child: Text(
                              _error,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily:"OpenSans",
                                color: Colors.red
                              ),
                            ),
                          )),
                      ),
                      _addBtn(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}