import 'package:flutter/material.dart';
import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/snackbar.dart';
import '../../../../dependency_injection.dart';
import '../../bloc/reset_password/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(sl()),
      child: const _ResetPasswordScreenBody(),
    );
  }
}

class _ResetPasswordScreenBody extends StatefulWidget {
  const _ResetPasswordScreenBody();

  @override
  State<_ResetPasswordScreenBody> createState() => _ResetPasswordScreenBodyState();
}

class _ResetPasswordScreenBodyState extends State<_ResetPasswordScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            AppSnackbar.showLoading(context);
          }
          if (state is ResetPasswordSuccess) {
            AppSnackbar.hide(context);
            AppSnackbar.showSuccess(context, message: state.message);

            // redirect to Login
            context.go(rLogin);
          }
          if (state is ResetPasswordFailure) {
            AppSnackbar.hide(context);
            AppSnackbar.showError(context, message: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 219,
                width: context.screenWidth,
                child: Stack(
                  children: [
                    Container(
                      width: context.screenWidth,
                      height: double.infinity,
                      color: AppColors.primary,
                    ),
                    Image.asset(
                      ImageConstants.authBg,
                      width: context.screenWidth,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    /// content
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 40,
                          bottom: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppSpacer.height(24),
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// form
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextForm(
                        label: 'Password',
                        hint: 'Enter your password',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password must contain at least 1 uppercase letter';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain at least 1 lowercase letter';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least 1 number';
                          }
                          // if (!RegExp(r'[!@#\$&*~^%()_+\-=\[\]{};\'\\:"|,.<>\/?]').hasMatch(value)) {
                          //   return 'Password must contain at least 1 special character';
                          // }
                          return null;
                        },
                      ),
                      const AppSpacer.height(16),
                      AppTextForm(
                        label: 'Confirm Password',
                        hint: 'Enter your confirm password',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const AppSpacer.height(32),
                      AppButton(
                        text: 'Reset Password',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Handle registration logic here
                            context.read<ResetPasswordCubit>().resetPassword(
                              emailController.text,
                              passwordController.text,
                              "otp",
                            );
                          }
                        },
                        width: context.screenWidth,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
