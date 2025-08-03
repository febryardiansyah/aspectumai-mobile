import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/core/utils/shared_pref_utils.dart';
import 'package:aspectumai/features/auth/bloc/email_verification/email_verification_cubit.dart';
import 'package:aspectumai/features/auth/bloc/otp/otp_cubit.dart';
import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:aspectumai/features/chat/repositories/chat_repository.dart';
import 'package:aspectumai/features/chat/bloc/chat/chat_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'features/auth/bloc/auth/auth_cubit.dart';
import 'features/auth/bloc/login/login_cubit.dart';
import 'core/bloc/image_picker/image_picker_cubit.dart';
import 'features/auth/bloc/reset_password/reset_password_cubit.dart';
import 'features/chat/bloc/create_chat_session/create_chat_session_cubit.dart';
import 'features/chat/bloc/delete_chat_session/delete_chat_session_cubit.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  final imagePicker = ImagePicker();

  sl.registerLazySingleton(() => imagePicker);

  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerFactory(() => SharePrefUtils());

  _repositories();
  _bloc();
}

/* data sources */
void _repositories() {
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<IChatRepository>(() => ChatRepository(sl()));
}


/* blocs */
void _bloc() {
  sl.registerFactory(() => ImagePickerCubit(sl()));
  sl.registerFactory(() => ChatBloc(sl()));

  /* auth */
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => EmailVerificationCubit(sl()));
  sl.registerFactory(() => OTPCubit(sl()));
  sl.registerFactory(() => ResetPasswordCubit(sl()));

  /* create chat session */
  sl.registerFactory(() => CreateChatSessionCubit(sl()));
  sl.registerFactory(() => DeleteChatSessionCubit(sl()));
}
