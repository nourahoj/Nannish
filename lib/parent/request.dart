import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyish/firebase/fb_firestore.dart';
import 'package:nannyish/preferences/app_preferences.dart';

import '../../main.dart';

class SendRequest extends StatefulWidget {
  late String nameReciver;
  List<dynamic> childer = [];

  SendRequest({required this.nameReciver});

  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  TextEditingController date = new TextEditingController();
  TextEditingController time = new TextEditingController();
  TextEditingController startAt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              child: Align(
                  alignment: Alignment.centerLeft, child: Icon(Icons.cancel)),
            ),
            Row(
              children: [
                Expanded(child: Center(child: Text('Date'
                ,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),
                ))),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      final date_paker = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1960),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      setState(() {
                        print(date_paker);
                        date.text =
                            DateFormat("yyyy-MM-dd").format(date_paker!);
                      });
                    },
                    child: Container(
                      color: Color(0xFF455A64),
                      width: 130,
                      height: 50,
                      child: Center(
                          child: Text(
                        date.text != null ? date.text.toString() : "",
                        style: TextStyle(fontSize: 16,
                          fontFamily: 'TimesNewRoman',

                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: Center(child: Text('Time' ,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),))),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: time,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontWeight: FontWeight.w600,
                      ),
                      fillColor: Color(0xFF455A64),
                      filled: true,
                      border: InputBorder.none,
                      hintText: '',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: Center(child: Text('Start at' ,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),))),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: startAt,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontWeight: FontWeight.w600,
                      ),
                      fillColor: Color(0xFF455A64),
                      filled: true,
                      border: InputBorder.none,
                      hintText: '',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(border: Border.all()),
              child: Text('Kids to sit' ,
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',

                ),),
            ),
            FutureBuilder(
              future: getKids(),
              builder: (index, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center();
                } else {
                  List<dynamic> kids = snapshot.data['kidsList'];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: kids.length,
                    itemBuilder: (context, index) {
                      String name = kids[index].toString().substring(
                          kids[index].toString().indexOf('Name:') + 5,
                          kids[index].toString().indexOf('/Age:'));
                      return selectKids(
                        name: name,
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () async {
                  if (date.text.isNotEmpty &&
                      time.text.isNotEmpty &&
                      startAt.text.isNotEmpty) {
                    Send();
                  } else {
                    showMaterialDialog_login(
                        context, "please enter data correctly");
                  }
                },
                child: const Text('Send' ,
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                    fontSize: 22,

                  ),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'MeltowSan300',
                  ),
                  primary: Color(0xFF455A64),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getKids() async {
    var data;
    var list = [];
    DocumentReference doc_ref = FirebaseFirestore.instance
        .collection("kids")
        .doc(AppPreferences().getUserData.uid);
    await doc_ref.get().then((value) {
      data = value.data();
      list = value.get('kidsList');
    });
    widget.childer.clear();
    for (var newDate in list) {
      String name = newDate.toString().substring(
          newDate.toString().indexOf('Name:') + 5,
          newDate.toString().indexOf('/Age:'));
      widget.childer.add(name);
    }
    return data;
  }

  Widget selectKids({required String name}) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(), left: BorderSide(), bottom: BorderSide())),
      child: Row(
        children: [
          Text(name),
          Spacer(),
        ],
      ),
    );
  }

  Future<void> Send() async {
    Map<String, dynamic> data = {
      'from': AppPreferences().getUserData.name,
      'sendTo': widget.nameReciver,
      'date': date.text,
      'time': time.text,
      'startAt': startAt.text,
      'location': '0.0 , 0.0',
      'kidsName': widget.childer
    };

    bool state = await FbFireStoreController().addRequest(data: data);

    if (state) {
      Navigator.pop(context);
    } else {
      showMaterialDialog_login(context, 'try Again');
    }
  }


}
