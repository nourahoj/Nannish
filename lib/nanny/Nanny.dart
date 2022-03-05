import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nannyish/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nannyish/preferences/app_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nannyish/firebase/fb_auth_controller.dart';
import 'package:nannyish/firebase/fb_firestore.dart';
import 'add_skills_screen.dart';
import '../../main.dart';

class Nanny extends StatefulWidget {
// String uid;
// LoginScreen(this.uid);
  @override
  State<Nanny> createState() => _NannyState();
}

class _NannyState extends State<Nanny> {
  late int nowYear;
  late int yearBirth;
  late int age;

  XFile? _pickedFile;
  ImagePicker imagePicker = ImagePicker();
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowYear = DateTime.now().toLocal().year;
    yearBirth = int.parse(
        AppPreferences().getUserData.birthdata.toString().split('-').first);
    age = nowYear - yearBirth;
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
                    GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImage((AppPreferences()
                                    .getUserData
                                    .photoUrl
                                    .isEmpty)
                                ? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"
                                : AppPreferences().getUserData.photoUrl),
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
                          AppPreferences().getUserData.name,
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
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.zero),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      Text(
                        'Years of experience:  ${AppPreferences().getUserData.experience.toString()}',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'TimesNewRoman',

                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Age: ${age.toString()}',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'TimesNewRoman',

                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 180,
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
                            const Padding(
                              padding: EdgeInsets.only(top: 8, left: 8),
                              child: Text(
                                'Skills:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'TimesNewRoman',

                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: 300,
                                child: Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: AppPreferences()
                                          .getUserData
                                          .skills!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.all(5),
                                          height: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(AppPreferences()
                                                .getUserData
                                                .skills![index]),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: const Color(0xFFFAFAFA),
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddSkillsScreen()));
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
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () async {
                      FbAuthController().signOut(context);
                    },
                    child: const Text('Log Out',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    print('Start Function pickImage');
    _pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    if (_pickedFile != null) {
      bool editImageProfile = await uploadImage();
      if (editImageProfile) {
        print('done Upload To FireStorge');
        bool editUrlImage = await FbFireStoreController().updateState(
            uid: AppPreferences().getUserData.uid!,
            collectionName: 'users',
            data: {'photoUrl': url});
        if (editUrlImage) {
          await AppPreferences().saveAndChangeImageProfile(imageProfile: url);
          print('Done Save Url In FireStore');
          setState(() {});
        }
      }
    }
  }

  Future<bool> uploadImage() async {
    if (_pickedFile != null) {
      url = await postFile(imageFile: File(_pickedFile!.path));
      return true;
    } else {
      showMaterialDialog_login(context, 'select Image');
      return false;
    }
  }

  Future<String> postFile({required File imageFile}) async {
    String fileName = '${DateTime.now().toString().replaceAll(' ', '_')}';
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    TaskSnapshot storageTaskSnapshot = await reference.putFile(imageFile);
    String dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }
}
