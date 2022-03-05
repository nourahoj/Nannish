import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nannyish/parent/addKids.dart';
import 'package:nannyish/preferences/app_preferences.dart';
import 'package:nannyish/firebase/fb_auth_controller.dart';

class parent extends StatefulWidget {
  parent({Key? key}) : super(key: key);

  @override
  State<parent> createState() => _parentState();
}

class _parentState extends State<parent> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppPreferences().getUserData.name,
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                        SizedBox(
                          width: 260,
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          'Rating: 3.4/5',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'TimesNewRoman',

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.zero),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8, left: 8),
                              child: Row(
                                children: [
                                  Text(
                                    'kids:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'TimesNewRoman',

                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    margin: EdgeInsets.only(right: 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        primary: Colors.white,
                                        alignment: Alignment.center,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddKidsScreen()));
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outlined,
                                        color: Colors.black,
                                        // size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                              future: getKids(),
                              builder: (index, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  List<dynamic> kids =
                                      snapshot.data['kidsList'];
                                  if (kids.length != 0) {
                                    return Expanded(
                                      child: ListView.builder(
                                        itemCount: kids.length,
                                        itemBuilder: (context, index) {
                                          print(index);
                                          String name = kids[index]
                                              .toString()
                                              .substring(
                                                  kids[index]
                                                          .toString()
                                                          .indexOf('Name:') +
                                                      5,
                                                  kids[index]
                                                      .toString()
                                                      .indexOf('/Age:'));
                                          String years = kids[index]
                                              .toString()
                                              .substring(
                                                  kids[index]
                                                          .toString()
                                                          .indexOf('Age:') +
                                                      4,
                                                  kids[index]
                                                      .toString()
                                                      .indexOf('/Notes:'));
                                          String notes = kids[index]
                                              .toString()
                                              .substring(kids[index]
                                                      .toString()
                                                      .indexOf('Notes:') +
                                                  6);
                                          return informationKids(
                                            name: name,
                                            notes: notes,
                                            years: years,
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () async {
                      FbAuthController().signOut(context);
                    },
                    child: const Text('Log Out'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'TimesNewRoman',
                        fontSize: 19,

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
        ),
      ),
    );
  }

  Widget informationKids(
      {required String name,
      required String years,
      required String notes,
      bool check = true}) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.zero),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'TimesNewRoman',

                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    '${years} years',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'TimesNewRoman',

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    'Notes : ${notes}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'TimesNewRoman',

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getKids() async {
    var data;
    DocumentReference doc_ref = FirebaseFirestore.instance
        .collection("kids")
        .doc(AppPreferences().getUserData.uid);
    await doc_ref.get().then((value) {
      data = value.data();
    });
    print(data);
    return data;
  }
}
