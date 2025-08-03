import 'dart:developer';

import 'package:aspectumai/core/utils/shared_pref_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(SharePrefUtils sharePrefUtils)
      : _sharePrefUtils = sharePrefUtils,
        super(UnAuthenticatedState());

  final SharePrefUtils _sharePrefUtils;

  void checkLogin() async {
    try {
      final token = await _sharePrefUtils.getString('token');
      log('token: $token');
      if (token != null) {
        emit(AuthenticatedState());
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (e) {
      emit(UnAuthenticatedState());
    }
  }

  void loggedIn(String token) async {
    try {
      await _sharePrefUtils.setString('token', token);
      emit(AuthenticatedState());
    } catch (e) {
      emit(UnAuthenticatedState());
    }
  }
  
  void logout() async {
    try {
      await _sharePrefUtils.remove('token');
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthenticatedState());
    }
  }

}
