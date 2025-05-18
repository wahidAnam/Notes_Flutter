import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../data/auth_api.dart';

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier() : super(null);

  Future<bool> login(String email, String password) async {
    final user = await AuthApi.login(email, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    return await AuthApi.register(name, email, password);
  }
}