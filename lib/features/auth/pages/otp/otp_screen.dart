import 'package:aspectumai/core/utils/dialog_utils.dart';
import 'package:aspectumai/core/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/features/auth/bloc/otp/otp_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_route.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OTPCubit>(),
      child: _OtpScreenBody(email: email),
    );
  }
}

class _OtpScreenBody extends StatefulWidget {
  final String email;
  const _OtpScreenBody({required this.email});

  @override
  State<_OtpScreenBody> createState() => _OtpScreenBodyState();
}

class _OtpScreenBodyState extends State<_OtpScreenBody> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _countdown = 300; // 5 minutes in seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _countdown = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  String get _formattedTime {
    final minutes = (_countdown ~/ 60).toString().padLeft(2, '0');
    final seconds = (_countdown % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      // Move to next field
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      _focusNodes[index - 1].requestFocus();
    }
  }

  String _getOtpCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _resendOtp() {
    if (_canResend) {
      context.read<OTPCubit>().resendOTP(widget.email);
      // The response will be handled by the BlocListener
    }
  }

  void _verifyOtp() {
    final otpCode = _getOtpCode();
    if (otpCode.length == 6) {
      // Verify OTP
      context.read<OTPCubit>().verifyOTP(
            widget.email,
            otpCode,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP code'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  Widget _buildContent() {
    return BlocBuilder<OTPCubit, OTPState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// header
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
                              const AppSpacer.height(24),
                              const Text(
                                'Verify OTP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: AppColors.white,
                                ),
                              ),
                              const AppSpacer.height(12),
                              Text.rich(
                                TextSpan(
                                  text:
                                      'Enter the 6-digit code sent to your email ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '\n${widget.email}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// main content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppSpacer.height(32),

                      /// OTP Input Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 45,
                            height: 55,
                            child: TextFormField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => _onOtpChanged(value, index),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.stroke,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.stroke,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const AppSpacer.height(32),

                      /// Timer and Resend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: _canResend ? _resendOtp : null,
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                color: _canResend
                                    ? AppColors.blue
                                    : AppColors.grey,
                                fontWeight: FontWeight.w500,
                                decoration: _canResend
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const AppSpacer.height(32),

                      /// Verify Button
                      AppButton(
                        text: 'Verify',
                        onPressed: _verifyOtp,
                        width: context.screenWidth,
                      ),

                      const AppSpacer.height(16),

                      /// Timer Text
                      GestureDetector(
                        onTap: _canResend ? _resendOtp : null,
                        child: Text(
                          _canResend
                              ? 'Code expired'
                              : 'Code expires in $_formattedTime',
                          style: TextStyle(
                            color:
                                _canResend ? AppColors.primary : AppColors.grey,
                            fontSize: 12,
                            fontWeight: _canResend
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OTPCubit, OTPState>(
      listener: (context, state) {
        if (state is OTPLoading) {
          DialogUtils.showLoadingDialog(context);
        }
        if (state is OTPSuccess) {
          context.pop();

          if (state.isResend) {
            // If OTP was resent successfully, restart the timer
            _startTimer();
          } else {
            // If OTP was verified successfully, navigate to home screen
            context.go(rLogin);
          }
        }
        if (state is OTPFailure) {
          AppSnackbar.showError(context, message: state.error);
        }
      },
      child: _buildContent(),
    );
  }
}
