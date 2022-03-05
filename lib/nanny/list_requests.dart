import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nannyish/firebase/fb_firestore.dart';
import 'package:nannyish/nanny/send_offer.dart';
import 'package:nannyish/preferences/app_preferences.dart';

class ListRequests extends StatefulWidget {
  ListRequests({Key? key}) : super(key: key);

  @override
  State<ListRequests> createState() => _ListRequestsState();
}

class _ListRequestsState extends State<ListRequests> {
  int tab = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[230],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          title: Text('Requests',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'TimesNewRoman',
                fontSize: 23.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
        ),
        body: Container(
          // padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tab = 1;
                          print(tab);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: (tab == 1)
                                ? Colors.grey.shade300
                                : Colors.white,
                            border: Border(
                                bottom: BorderSide(), right: BorderSide())),
                        child: Center(child: Text('General',
                        style: TextStyle(
                          fontFamily: 'TimesNewRoman',

                        ),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tab = 2;
                          print(tab);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: (tab == 2)
                                ? Colors.grey.shade300
                                : Colors.white,
                            border: Border(
                                bottom: BorderSide(), left: BorderSide())),
                        child: Center(child: Text('Private',
                        style: TextStyle(
                          fontFamily: 'TimesNewRoman',

                        ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FbFireStoreController().read(
                    nameCollection: 'request',
                    orderBy: 'sendTo',
                    descending: true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                    List<QueryDocumentSnapshot> generalRequest = [];
                    List<QueryDocumentSnapshot> privateRequest = [];
                    for (var req in data) {
                      if (req.get('sendTo') == 'all') {
                        generalRequest.add(req);
                      } else if (
                      req.get('sendTo') ==
                          AppPreferences().getUserData.uid!
                      ) {
                        privateRequest.add(req);
                      }
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        if (tab == 1) {
                          return RequestWidget(
                              name: generalRequest[index].get('from'),
                              date: generalRequest[index].get('date'),
                              time: generalRequest[index].get('time'),
                              kids: generalRequest[index].get('kidsName'),
                              isPrivate: false);
                        } else {
                          return RequestWidget(
                              name: privateRequest[index].get('from'),
                              date: privateRequest[index].get('date'),
                              time: privateRequest[index].get('time'),
                              kids: privateRequest[index].get('kidsName'),
                              isPrivate: true);
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: (tab == 1)
                          ? generalRequest.length
                          : privateRequest.length,
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning,
                              size: 85, color: Colors.grey.shade500),
                          Text(
                            'NO Requests',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimesNewRoman',

                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget RequestWidget(
      {required String name,
      required String date,
      required String time,
      required List<dynamic> kids,
      required bool isPrivate}) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$name',
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),
                ),
                Divider(
                  indent: 1,
                  thickness: 2,
                  endIndent: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Date : $date',
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',

                ),
                ),
                Text('Time :$time',
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),
                ),
                Text('Kids :',
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),
                ),
                ListView.builder(
                  itemCount: kids.length,
                  itemBuilder: (context, index) {
                    return Text(kids[index]);
                  },
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SendOffer(name,date,time,kids)));
                },
                child: Text('Offer'),
                style: ElevatedButton.styleFrom(primary: Color(0xFF455A64))),
            Visibility(
              visible: isPrivate,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Reject',
                    style: TextStyle(
                      fontFamily: 'TimesNewRoman',

                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF455A64))),
            ),
          ],
        ))
      ],
    );
  }
}
