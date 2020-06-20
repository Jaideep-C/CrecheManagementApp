
import 'package:cloud_firestore/cloud_firestore.dart';

class ChurchKid {

  String firstName,lastName;
  String fullName;
  Timestamp bornDay;
  String gName;
  String gPhone;
  String allergies;
  String sex;
  bool isLog;

  ChurchKid({this.fullName,this.firstName,this.lastName,this.gName,this.gPhone,this.sex,this.bornDay,this.isLog,this.allergies});

  ChurchKid.fromData(Map<dynamic, dynamic> data)
      : fullName = data['fullName'].toString(),
        firstName = data['firstName'].toString(),
        lastName = data['lastName'].toString(),
        bornDay = data['bornDay'],
        gName = data['gName'].toString(),
        gPhone=data['gPhone'].toString(),
        allergies = data['allergies'].toString(),
        isLog = data['isLog'],
        sex = data['sex'].toString();
}

class CrecheKid {
  String firstName,lastName;
  int age;
  String gName;
  String gPhone;
  List allergies=new List(20);
  

}
