import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homey/core/widgets/custom_divider.dart';
import 'package:homey/core/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? image;
  String? url;

  @override
  void initState() {
    super.initState();
    loadImageUrl();
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    image = File(pickedFile.path);
    var imageName = basename(pickedFile.path);
    var refStorage = FirebaseStorage.instance.ref(imageName);
    await refStorage.putFile(image!);
    url = await refStorage.getDownloadURL();
    saveImageUrl(url!);
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(imageName);
    setState(() {});
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) return;
    image = File(pickedFile.path);
    var imageName = basename(pickedFile.path);
    var refStorage = FirebaseStorage.instance.ref(imageName);
    await refStorage.putFile(image!);
    url = await refStorage.getDownloadURL();
    saveImageUrl(url!);
    setState(() {});
  }

  Future<void> saveImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImageUrl', imageUrl);
  }

  Future<void> loadImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('profileImageUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var email = FirebaseAuth.instance.currentUser?.email;
    var name = FirebaseAuth.instance.currentUser?.displayName;
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: const Color(0xffCBEFF2),
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.photo_library,
                                    color: Color(0xff0096A4),
                                  ),
                                  title: const Text(
                                    'Gallery',
                                    style: TextStyle(
                                        color: Color(0xff163A51),
                                        fontSize: 21,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    pickImageFromGallery();
                                  },
                                ),
                                Divider(
                                  thickness: 3,
                                  color:
                                      const Color(0xff0A1128).withOpacity(0.26),
                                  endIndent: 10,
                                  indent: 10,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xff0096A4),
                                  ),
                                  title: const Text(
                                    'Camera',
                                    style: TextStyle(
                                        color: Color(0xff163A51),
                                        fontSize: 21,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    pickImageFromCamera();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Stack(
                        children: [
                          if (url != null)
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(url!),
                            )
                          else
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/profile_pic_picker.png",
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/picker_pic.png",
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Text(
                name!,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: const Color(0xffC6FAFF),
                ),
              ),
              Text(
                email!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff66B4BB),
                  fontSize: 12,
                ),
              ),
              const CustomDivider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                    color: Color(0xffC6FAFF),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Color(0xff0096A4),
                          size: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            inputStyle: const TextStyle(
                                color: Color(0xff0096A4), fontSize: 17),
                            style: const TextStyle(
                              color: Color(0xff040710),
                              fontSize: 16,
                            ),
                            controller: phoneController,
                            hintText: "Phone",
                            color: const Color(0xffCBEFF2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Image.asset("assets/images/gender_icon.png"),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}