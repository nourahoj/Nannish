import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:nannyish/firebase/fb_firestore.dart';
import 'package:nannyish/main.dart';
import 'package:nannyish/preferences/app_preferences.dart';

class SendOffer extends StatefulWidget {
String? name,date,time;
List<dynamic> kids;
SendOffer(this.name,this.date,this.time,this.kids);
  @override
  _SendOfferState createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  TextEditingController priceController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: ()=>Navigator.pop(context),
        ),
        backgroundColor: Colors.grey[200],
        title: Text("Send Offer",style: TextStyle(
          fontFamily: 'TimesNewRoman',
          fontSize: 23.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    // pickImage();
                  },
                  child: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage("https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.transparent,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'TimesNewRoman',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(
                        color: Color.fromARGB(255, 5, 5, 5),
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
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1,color: Colors.black),
                  right: BorderSide(width: 1,color: Colors.black),
                  left: BorderSide(width: 1,color: Colors.black),
                  bottom: BorderSide(width: 1,color: Colors.black),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Kids No :",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                        Text("${widget.kids.length}",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Date :",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                        Text("${widget.date}",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Duration :",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                        Text("${widget.time}",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',

                          ),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1,color: Colors.black),
                    right: BorderSide(width: 1,color: Colors.black),
                    left: BorderSide(width: 1,color: Colors.black),
                    bottom: BorderSide(width: 1,color: Colors.black),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Price : ",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',
                          ),),
                        Container(
                          width: 50,
                          child: TextFormField(controller: priceController,
                            decoration: InputDecoration(

                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Notes : ",
                          style: TextStyle(
                            fontFamily: 'TimesNewRoman',
                          ),),

                        Container(
                          width: 200,
                          child: TextFormField(
                            controller: noteController,
                            decoration: InputDecoration(

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(priceController.text == ""){

                        }else{
                          SendToParent(widget.name,priceController.text,noteController.text,context);
                        }
                      },
                      child: const Text('Send offer',
                        style: TextStyle(
                            fontSize: 20
                        ),),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'TimesNewRoman',
                        ),
                        primary: Color(0xFF455A64),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> SendToParent(name,price,note,context) async {
  Map<String, dynamic> data = {
    'from': AppPreferences().getUserData.name,
    'sendTo':name,
    'price': price,
    'note': note,
  };

  bool state = await FbFireStoreController().addRequestToParent(data: data);

  if (state) {
    print(state.toString());
    Navigator.pop(context);
  } else {
    showMaterialDialog_login(context, 'try Again');
  }
}