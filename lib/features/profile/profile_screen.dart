import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/services/shared_preferences_manager.dart';
import '../../core/theme/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? profilePicturePath;
  late String name;
  String? motivationQuote;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    name = SharedPreferencesManager().getString(StorageKeys.userName) ?? "";
    motivationQuote =
        SharedPreferencesManager().getString(StorageKeys.motivationQuote) ??
        'One task at a time.One step closer.';
    profilePicturePath = SharedPreferencesManager().getString(
      StorageKeys.profilePicture,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profilePicturePath != null
                                ? FileImage(File(profilePicturePath!))
                                : AssetImage('assets/images/person.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {
                              showImageSourceDialog(context, (XFile file) {
                                _saveProfilePicture(file);
                                setState(() {
                                  profilePicturePath = file.path;
                                });
                              });
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(name, style: Theme.of(context).textTheme.labelLarge),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote ??
                            'One task at a time.One step closer.',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ListTile(
                  onTap: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          name: name,
                          motivationQuote: motivationQuote,
                        ),
                      ),
                    );
                    result != null && result ? _loadData() : null;
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person_outline),
                  title: Text('User Details'),
                  trailing: Icon(Icons.arrow_forward),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.dark_mode_outlined),
                  title: Text('Dark Mode'),
                  trailing: ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeController.themeNotifier,
                    builder:
                        (
                          BuildContext context,
                          ThemeMode themeMode,
                          Widget? child,
                        ) {
                          return Switch(
                            value: themeMode == ThemeMode.dark,
                            onChanged: (bool value) {
                              ThemeController.toggleTheme();
                            },
                          );
                        },
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    SharedPreferencesManager().remove(StorageKeys.userName);
                    SharedPreferencesManager().remove(
                      StorageKeys.motivationQuote,
                    );
                    SharedPreferencesManager().remove(StorageKeys.tasks);
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Logout'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          );
  }

  void showImageSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Select Image Source',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                }
              },
              child: Row(
                children: [
                  Icon(Icons.image_outlined),
                  SizedBox(width: 8),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveProfilePicture(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    SharedPreferencesManager().setString(
      StorageKeys.profilePicture,
      newFile.path,
    );
  }
}
