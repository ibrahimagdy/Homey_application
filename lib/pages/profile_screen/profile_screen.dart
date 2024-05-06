import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homey/core/network_layer/firebase_utils.dart';
import 'package:homey/core/widgets/custom_divider.dart';
import 'package:homey/core/widgets/custom_text_form_field.dart';
import 'package:homey/pages/about_us_screen/about_us_screen.dart';
import 'package:homey/pages/notifications_screen/notifications_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../core/services/snackbar_service.dart';
import '../login_screen/login_screen.dart';

class ProfileView extends StatefulWidget {
  static const String routeName = "profile";

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String? profileImagePic;

  @override
  void initState() {
    profileImagePic = FirebaseAuth.instance.currentUser!.photoURL;
    super.initState();
  }

  File? image;
  String? url;
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile == null) return;
    image = File(pickedFile.path);
    var imageName = basename(pickedFile.path);
    var refStorage = FirebaseStorage.instance.ref(imageName);
    await refStorage.putFile(image!);
    url = await refStorage.getDownloadURL();
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    profileImagePic = FirebaseAuth.instance.currentUser!.photoURL;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var email = FirebaseAuth.instance.currentUser?.email;
    var name = FirebaseAuth.instance.currentUser?.displayName ?? "";
    return Scaffold(
      backgroundColor: const Color(0xff0A1128),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheetForImageSource(context);
                        },
                        child: Stack(
                          children: [
                            if (profileImagePic != null)
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(profileImagePic!),
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
                StreamBuilder(
                  initialData: name,
                  stream: FirebaseUtils.personalInformationStream.map((_) {
                    return FirebaseAuth.instance.currentUser?.displayName ?? '';
                  }),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: const Color(0xffC6FAFF),
                      ),
                    );
                  },
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
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xff0096A4),
                        size: 28,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          initialValue: name,
                          onChanged: (value) {
                            name = value;
                          },
                          inputStyle: const TextStyle(
                              color: Color(0xff0096A4), fontSize: 17),
                          style: const TextStyle(
                            color: Color(0xff040710),
                            fontSize: 16,
                          ),
                          hintText: "Name",
                          color: const Color(0xffCBEFF2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 100,
                  height: 47,
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7DD7DF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      editProfileOnClick(context, name);
                    },
                    child: Text(
                      "Edit Your Name",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: const Color(0xff0A1128),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const CustomDivider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "Notifications",
                    style: TextStyle(
                      color: Color(0xffC6FAFF),
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NotificationScreen.routeName,
                        arguments: const RemoteMessage(),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
                      title: Text(
                        "Notifications",
                        style:
                            TextStyle(color: Color(0xff0096A4), fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "More info and support",
                    style: TextStyle(
                      color: Color(0xffC6FAFF),
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AboutUsScreen.routeName);
                    },
                    child: const ListTile(
                      leading: Icon(
                        CupertinoIcons.exclamationmark_circle,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
                      title: Text(
                        "About",
                        style:
                            TextStyle(color: Color(0xff0096A4), fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xffC6FAFF),
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      showLogoutConfirmationDialog(context);
                    },
                    child: const ListTile(
                      title: Text(
                        "Logout",
                        style:
                            TextStyle(color: Color(0xffEA2929), fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDeleteAccountConfirmationDialog(context);
                    },
                    child: const ListTile(
                      title: Text(
                        "Delete account",
                        style:
                            TextStyle(color: Color(0xffEA2929), fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        size: 30,
                        color: Color(0xff0096A4),
                      ),
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

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure to logout?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style:
                              TextStyle(color: Color(0xff0A1128), fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Close the dialog
                          var auth = FirebaseAuth.instance;
                          auth.signOut().then((value) {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          });
                        },
                        child: const Text("Logout",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure to delete Account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style:
                              TextStyle(color: Color(0xff0A1128), fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          var auth = FirebaseAuth.instance;
                          auth.currentUser?.delete().then((value) {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          });
                        },
                        child: const Text("Delete",
                            style: TextStyle(color: Colors.red, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetForImageSource(BuildContext context) {
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
                pickImage(ImageSource.gallery);
              },
            ),
            Divider(
              thickness: 3,
              color: const Color(0xff0A1128).withOpacity(0.26),
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
                pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  void editProfileOnClick(BuildContext context, String name) {
    FirebaseUtils.editPersonalInformation(name).then((changed) {
      if (changed) {
        SnackBarService.showSuccessMessage("Name edited successfully");
      } else {
        SnackBarService.showErrorMessage("No changes were made");
      }
    });
  }
}