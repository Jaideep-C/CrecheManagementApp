import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:five/screens/addKid/churchKid.dart';
import 'package:five/service/auth.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  Home({Key key}) : super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  
    // DocumentSnapshot _currentDocument;

  // _updateData() async {
  //   await Firestore.instance
  //       .collection("kids-Church")
  //       .document(_currentDocument.documentID)
  //       .updateData({'isLog': true});
  // }

  int _currentIndex=0;
  PageController _pageController;
     @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Widget first(){

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: StreamBuilder<QuerySnapshot>(
        stream:Firestore.instance.collection("kids-Church").snapshots(),
        builder: (context,snapshot){
          if(snapshot.data == null) return Center(child: CircularProgressIndicator());
          // return ListView(
          //   children:makeIt(snapshot),
          //   );
          return Column(
                    children: snapshot.data.documents.map((doc) {
                      return Visibility(
                        visible: doc.data['isLog']??false,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(doc.data['fullName'] ?? 'nil'),
                              trailing: RaisedButton(
                                child: Text("Sign-Out"),
                                color: Colors.orange,
                                onPressed: () async {
                                  await Firestore.instance
                                  .collection("kids-Church")
                                  .document(doc.documentID)
                                  .updateData({'isLog': false});
                                },
                              ),
                            ),
                            Divider(thickness: 1,color: Colors.black,),
                          ],
                        ),
                      );
                    }).toList(),
                  );
        },
      ),
    );
  }

  Widget middle(){
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        heroTag: "btn",
        child: Icon(Icons.person_add),
        backgroundColor: Colors.blueAccent,
        onPressed:(){ Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>AddChurchKid()
            )
          );
        },
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream:Firestore.instance.collection("kids-Church").snapshots(),
        builder: (context,snapshot){
          if(snapshot.data == null) return Center(child: CircularProgressIndicator());
          // return ListView(
          //   children:makeIt(snapshot),
          //   );
          return Column(
                    children: snapshot.data.documents.map((doc) {
                      return Visibility(
                        visible: doc.data['fullName']!=null,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(doc.data['fullName'] ?? 'nil'),
                              trailing: RaisedButton(
                                child: Text("Sign-In"),
                                color: Colors.amber,
                                onPressed: () async {
                                  await Firestore.instance
                                  .collection("kids-Church")
                                  .document(doc.documentID)
                                  .updateData({'isLog': true});
                                },
                              ),
                            ),
                            Divider(thickness: 1,color: Colors.black,),
                          ],
                        ),
                      );
                    }).toList(),
                  );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Scaffold(        
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Text('Home',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Bellota',
              ),
            ),
            backgroundColor: Colors.blue[300],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Container(
                color: Colors.blue[50],
                child: first(),
                ),
              
              Container(
                child: middle(),
              ),
              
              // Container(
              //   color: Colors.blue[50],
              //   child: StreamProvider<QuerySnapshot>.value(
              //     value: Firestore.instance.collection("kids-Church").snapshots(),//DataBaseService().kids,
              //     child: middle()
              //     ),
              // ),





              Container(color: Colors.blue[50],),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: Text('Active'),
              icon: (_currentIndex!=0)?Icon(Icons.people_outline):Icon(Icons.people)
            ),
            BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home)
            ),
            BottomNavyBarItem(
              title: Text('Profile'),
              icon: (_currentIndex!=2)?Icon(Icons.person_outline):Icon(Icons.person)
            ),
          ],
        ),
        ),
      );
  }
}

