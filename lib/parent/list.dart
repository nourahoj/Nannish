import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nannyish/firebase/fb_firestore.dart';
import 'package:nannyish/parent/request.dart';

class list extends StatefulWidget {
  list({Key? key}) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF455A64),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendRequest(nameReciver: 'all')));
          },
          child: Icon(Icons.send),
        ),
        backgroundColor: Colors.grey[230],
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            )
          ],
          backgroundColor: Colors.grey[200],
          title: Text('  Nannies list  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'TimesNewRoman',
                fontSize: 23.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FbFireStoreController().read(
                  nameCollection: 'users', orderBy: 'type', descending: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                  List<QueryDocumentSnapshot> onlyNannyList = [];
                  for (var nannies in data) {
                    if (nannies.get('type') == 'Nanny') {
                      onlyNannyList.add(nannies);
                    }
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return NannyWidget(
                          name: onlyNannyList[index].get('name'),
                          experience: onlyNannyList[index].get('experience'),
                          nameReciver: onlyNannyList[index].id);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: onlyNannyList.length,
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning,
                            size: 85, color: Colors.grey.shade500),
                        Text(
                          'No Nannies',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 18,
                            fontFamily: 'TimesNewRoman',

                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            )),
      ),
    );
  }

  Widget NannyWidget(
      {required String name,
      required String experience,
      required String nameReciver}
      ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'TimesNewRoman',

                ),
              ),
              SizedBox(
                width: 200,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Text(
                'Rating: 3.4/5 \n Years of experience:: $experience ',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'TimesNewRoman',

                ),
              ),
              SizedBox(
                width: 200,
                height: 20,
                child: Divider(
                  color: Color.fromARGB(255, 67, 73, 68),
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFF455A64)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SendRequest(nameReciver: nameReciver)));
                  },
                  child: Text('Request',
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',

                  ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
