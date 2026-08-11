import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.validator,
    required this.title,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSizes.h8),
        TextFormField(
          // textInputAction: TextInputAction.done,
          // onFieldSubmitted: (_) {
          //   FocusScope.of(context).unfocus();
          // },
          maxLines: maxLines,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText),
          validator: validator,
        ),
      ],
    );
  }
}
