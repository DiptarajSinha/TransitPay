import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app/core/services/supabase_service.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<User?> {
  late final SupabaseClient _client;
  final _storage = const FlutterSecureStorage();
  
  @override
  Future<User?> build() async {
    _client = SupabaseService().client;
    
    // Listen to Auth State changes
     _client.auth.onAuthStateChange.listen((data) {
       if (data.event == AuthChangeEvent.signedIn || 
           data.event == AuthChangeEvent.signedOut ||
           data.event == AuthChangeEvent.initialSession) {
         state = AsyncData(data.session?.user);
       }
    });

    return _client.auth.currentUser;
  }

  Future<void> signIn(String email, String password, {required String role}) async {
    state = const AsyncLoading();
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      final user = res.user;
      if (user != null) {
        // Strict Role Check with Legacy Support
        final userRole = user.userMetadata?['role'] ?? 'rider'; 
        
        if (userRole != role) {
           await signOut();
           throw Exception('Access Denied: Account registered as $userRole. Please use the correct app portal.');
        }
      }

      state = AsyncData(res.user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, {required String role}) async {
    state = const AsyncLoading();
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'role': role}, // Persist role during registration
      );
      
      state = AsyncData(res.user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _client.auth.signOut();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
