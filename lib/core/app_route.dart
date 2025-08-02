import 'package:go_router/go_router.dart';

import '../features/auth/pages/login/login_screen.dart';
import '../features/auth/pages/register/register_screen.dart';
import '../features/auth/pages/otp/otp_screen.dart';
import '../features/auth/pages/forgot_password/forgot_password_screen.dart';
import '../features/chat/pages/chat/chat_screen.dart';
import '../features/home/page/home_screen.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: rHome,
      routes: [
        // GoRoute(
        //   path: '/',
        //   builder: (context, state) => const SplashScreen(),
        // ),
        GoRoute(
          path: rLogin,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: rRegister,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: rOtp,
          builder: (context, state) => OtpScreen(email: state.extra as String),
        ),
        GoRoute(
          path: rForgotPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: rResetPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: rHome,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: rChat,
          builder: (context, state) => const ChatScreen(),
        ),
      ],
    );
  }
}

String get rSplash => '/';
String get rLogin => '/login';
String get rRegister => '/register';
String get rOtp => '/otp';
String get rForgotPassword => '/forgot-password';
String get rResetPassword => '/reset-password';
String get rHome => '/home';
String get rChat => '/chat';
