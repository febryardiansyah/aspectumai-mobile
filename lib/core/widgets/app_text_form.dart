import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';

enum AppTextFormType { normal, outlined }

class AppTextForm extends StatelessWidget {
  final String? hint;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? label;
  final Color? backgroundColor;
  final AppTextFormType type;
  final bool obscureText;
  final FormFieldValidator<String>? validator; // <-- Add this

  const AppTextForm({
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.backgroundColor,
    this.type = AppTextFormType.normal,
    this.obscureText = false,
    this.validator, // <-- Add this
  });

  @override
  Widget build(BuildContext context) {
    final isOutlined = type == AppTextFormType.outlined;
    final currentBackgroundColor = backgroundColor ?? AppColors.secondary;
    final isDarkBackground =
        ThemeData.estimateBrightnessForColor(currentBackgroundColor) ==
            Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrey,
            ),
          ),
          const AppSpacer.height(4),
        ],
        TextFormField(
          style: TextStyle(
            color: isDarkBackground ? AppColors.white : AppColors.black,
          ),
          controller: controller,
          obscureText: obscureText,
          validator: validator, // <-- Add this
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            // isDense: true,
            filled: true,
            fillColor: currentBackgroundColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: isOutlined
                  ? const BorderSide(
                      color: AppColors.stroke,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: isOutlined
                  ? const BorderSide(
                      color: AppColors.stroke,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: isOutlined
                  ? const BorderSide(
                      color: AppColors.secondary,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
