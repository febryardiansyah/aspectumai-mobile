import 'package:flutter/material.dart';
import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:go_router/go_router.dart';
import 'package:aspectumai/features/auth/bloc/register/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/snackbar.dart';
import '../../../../dependency_injection.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(sl()),
      child: const _RegisterScreenBody(),
    );
  }
}

class _RegisterScreenBody extends StatefulWidget {
  const _RegisterScreenBody();

  @override
  State<_RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<_RegisterScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            AppSnackbar.showLoading(context);
          }
          if (state is RegisterSuccess) {
            AppSnackbar.hide(context);
            AppSnackbar.showSuccess(context, message: state.message);

            // redirect to OTP
            context.go(rOtp, extra: emailController.text);
          }
          if (state is RegisterFailure) {
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
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 40,
                          bottom: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: AppColors.white,
                              ),
                            ),
                            const AppSpacer.height(24),
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const AppSpacer.height(12),
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: "Already have an account?",
                                  children: [
                                    TextSpan(
                                      text: ' Sign in',
                                      style: TextStyle(
                                        color: AppColors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
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
                        label: 'Full name',
                        hint: 'Enter your full name',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: fullNameController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Full name is required'
                            : null,
                      ),
                      const AppSpacer.height(16),
                      AppTextForm(
                        label: 'Username',
                        hint: 'Enter your username',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: usernameController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Username is required'
                            : null,
                      ),
                      const AppSpacer.height(16),
                      AppTextForm(
                        label: 'Email',
                        hint: 'Enter your email',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const AppSpacer.height(16),
                      AppTextForm(
                        label: 'Password',
                        hint: 'Enter your password',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          //   return 'Password must contain at least 1 uppercase letter';
                          // }
                          // if (!RegExp(r'[a-z]').hasMatch(value)) {
                          //   return 'Password must contain at least 1 lowercase letter';
                          // }
                          // if (!RegExp(r'[0-9]').hasMatch(value)) {
                          //   return 'Password must contain at least 1 number';
                          // }
                          // if (!RegExp(r'[!@#\$&*~^%()_+\-=\[\]{};\'\\:"|,.<>\/?]').hasMatch(value)) {
                          //   return 'Password must contain at least 1 special character';
                          // }
                          return null;
                        },
                      ),
                      const AppSpacer.height(16),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const AppSpacer.height(32),
                      AppButton(
                        text: 'Register',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Handle registration logic here
                            context.read<RegisterCubit>().register(
                                  fullNameController.text,
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
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
