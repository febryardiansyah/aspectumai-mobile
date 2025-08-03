import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/utils/dialog_utils.dart';
import 'package:aspectumai/core/widgets/snackbar.dart';
import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/features/auth/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/illustrations.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(sl()),
      child: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody();

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final emailEdc = TextEditingController();
  final passwordEdc = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // <-- Add this

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            DialogUtils.showLoadingDialog(context);
          }
          if (state is LoginSuccess) {
            context.pop(); // Close the loading dialog
            AppSnackbar.showSuccess(context, message: 'Login Success');
            context.read<AuthCubit>().loggedIn(state.token);

            // redirect to home screen
            context.go(rHome);
          }
          if (state is LoginFailure) {
            context.pop(); // Close the loading dialog
            AppSnackbar.showError(context, message: state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// header
              SizedBox(
                height: 263,
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
                            const Text(
                              'Sign in to your Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const AppSpacer.height(12),
                            GestureDetector(
                              onTap: () {
                                context.push(rRegister);
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: "Don't have an account?",
                                  children: [
                                    TextSpan(
                                      text: ' Sign up',
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

              /// main form
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextForm(
                        label: 'Email',
                        hint: 'Enter your email',
                        type: AppTextFormType.outlined,
                        backgroundColor: AppColors.white,
                        controller: emailEdc,
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
                        controller: passwordEdc,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
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
                      ),
                      const AppSpacer.height(16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            context.push(rForgotPassword);
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const AppSpacer.height(32),
                      AppButton(
                        text: 'Log in',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginCubit>().login(
                              emailEdc.text,
                              passwordEdc.text,
                            );
                          }
                        },
                        width: context.screenWidth,
                      ),
                      const AppSpacer.height(24),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.stroke,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or login with',
                              style: TextStyle(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.stroke,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const AppSpacer.height(16),
                      AppButton(
                        onPressed: () {},
                        width: context.screenWidth,
                        type: AppButtonType.outlined,
                        body: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              IllustrationConstants.google,
                              width: 24,
                              height: 24,
                            ),
                            const AppSpacer.width(10),
                            const Text(
                              'Google',
                              style: TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      )
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
