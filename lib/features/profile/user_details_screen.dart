import 'package:flutter/material.dart';
import 'package:tasky/core/services/shared_preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

import '../../core/constants/storage_keys.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.name,
    required this.motivationQuote,
  });

  final String name;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  /// TODO : DISPOSE CONTROLLERS
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController motivationQuoteController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.name;
    motivationQuoteController.text = widget.motivationQuote ?? '';
  }

  // void initState() {
  //   super.initState();
  //   _loadUserName();
  //   _loadMotivationQuote();
  // }
  //
  // void _loadUserName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   name = prefs.getString('name') ?? "";
  //   setState(() {});
  // }
  //
  // void _loadMotivationQuote() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   motivationQuote = prefs.getString('motivation_quote') ?? "";
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        CustomTextFormField(
                          controller: usernameController,
                          hintText: 'Usama Elgendy',
                          title: 'Username',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a username.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 8),
                        CustomTextFormField(
                          title: 'Motivation Quote',
                          controller: motivationQuoteController,
                          hintText: 'One task at a time.One step closer.',
                          maxLines: 5,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a motivation quote.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await SharedPreferencesManager().setString(
                        StorageKeys.userName,
                        usernameController.text,
                      );
                      await SharedPreferencesManager().setString(
                        'motivation_quote',
                        motivationQuoteController.text,
                      );
                      if (!context.mounted) return;
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
