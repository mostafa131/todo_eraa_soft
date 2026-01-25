import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/app_contstans.dart';
import 'package:todo_app/core/widgets/custom_app_button.dart';
import 'package:todo_app/features/home/models/user_model.dart';
import 'package:todo_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final user =Hive.box<UserModel>(AppConstants.userBox).getAt(0);

  final ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController nameController = TextEditingController();

  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 100.h),
        child: Column(
          spacing: 20.h,
          children: [
            Visibility(
              visible: image == null,
              child: CircleAvatar(
                radius: 100.r,
                child: Icon(Icons.person, size: 100.r),
              ),
              replacement: Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.file(File(image?.path ?? "")).image,
                  ),
                ),
              ),
            ),

            CustomAppButton(
              title: "Upload From Camera",
              onPressed: () {
                openCamera();
              },
            ),
            CustomAppButton(
              title: "Upload From Gallery",
              onPressed: () {
                openGallery();
              },
            ),
            Divider(color: Colors.indigo),
            TextFormField(
              controller: nameController,
              onTapOutside: (v) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
            ),
            CustomAppButton(
              title: "Login",
              onPressed: () {
                print("user data: ${user?.name}");

                Hive.box<UserModel>(AppConstants.userBox).add(
                  UserModel(
                    image: image?.path ?? "",
                    name: nameController.text,
                  ),
                ).then((v){
                  print(v);
                }).catchError((e){
                  print("erroe$e");
                });
              },
            ),


          ],
        ),
      ),
    );
  }
}
