import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/dependency_injection.dart';
import 'package:aspectumai/core/bloc/image_picker/image_picker_cubit.dart';
import 'package:frosted_toast/frosted_toast.dart';

import 'features/auth/bloc/auth/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ImagePickerCubit(sl()),
        ),
        BlocProvider(
          create: (_) => sl<AuthCubit>()..checkLogin(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Aspectum AI',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.primary,
          dialogTheme: const DialogThemeData(
            surfaceTintColor: AppColors.white,
          ),
          appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
          ),
          colorScheme: const ColorScheme.light(
            surface: Colors.white,
            onSurface: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        builder: (context, child) {
          return FrostedToastOverlay(
            child: child ?? const Scaffold(),
          );
        },
      ),
    );
  }
}
