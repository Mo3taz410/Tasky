import 'package:flutter/material.dart';
import 'package:tasky/core/services/shared_preferences_manager.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(path: 'assets/icons/app_logo.svg'),
                      SizedBox(width: AppSizes.w10),
                      Text("Tasky", style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                  SizedBox(height: AppSizes.h110),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome to Tasky", style: Theme.of(context).textTheme.displaySmall),
                      CustomSvgPicture.withoutColor(path: 'assets/icons/waving_hand.svg'),
                    ],
                  ),
                  SizedBox(height: AppSizes.h10),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.h20),
                  CustomSvgPicture.withoutColor(path: 'assets/images/welcome.svg'),
                  SizedBox(height: AppSizes.h20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        hintText: 'e.g. Sara Khaled',
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                        title: 'Full Name',
                      ),
                      // TextFormField(
                      //   validator: (String? value) {
                      //     if (value == null || value.trim().isEmpty) {
                      //       return 'Please enter your name.';
                      //     }
                      //     return null;
                      //   },
                      //   controller: nameController,
                      //   style: TextStyle(color: Colors.white),
                      //   cursorColor: Colors.white,
                      //   decoration: InputDecoration(
                      //     hintText: 'e.g. Sara Khaled',
                      //     hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                      //     filled: true,
                      //     fillColor: Color(0xFF282828),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(AppSizes.r16),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: AppSizes.h20),
                      SizedBox(
                        width: double.infinity,
                        height: AppSizes.h40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await SharedPreferencesManager().setString(StorageKeys.userName, nameController.text);
                              if (!context.mounted) return;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                            } else {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text('Please enter your name.')));
                            }
                          },
                          child: Text('Let\'s Get Started'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
