// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/islander_data.dart';
import '../models/islander.dart';

// Supabaseクライアントのプロバイダー
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// IslanderDataのプロバイダー
final islanderDataProvider = Provider<IslanderData>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return IslanderData(supabase);
});

// Islanderの状態を管理するプロバイダー
final islanderProvider = AsyncNotifierProvider<IslanderNotifier, Islander>(IslanderNotifier.new);

class IslanderNotifier extends AsyncNotifier<Islander> {
  @override
  Future<Islander> build() async {
    final data = ref.watch(islanderDataProvider);
    try {
      return await data.getIslander();
    } catch (e) {
      print('Error in build: $e'); // デバッグ用
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> updateExp(int exp) async {
    final current = state.value!;
    final updated = current.copyWith(exp: exp);
    
    await ref.read(islanderDataProvider).updateIslander(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> updateSats(int sats) async {
    final current = state.value!;
    final updated = current.copyWith(sats: sats);
    
    await ref.read(islanderDataProvider).updateIslander(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> updateLoginDays(int days) async {
    final current = state.value!;
    final updated = current.copyWith(loginDays: days);
    
    await ref.read(islanderDataProvider).updateIslander(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> updateLearningProgress(int progress) async {
    final current = state.value!;
    final updated = current.copyWith(learningProgress: progress);
    
    await ref.read(islanderDataProvider).updateIslander(updated);
    state = AsyncValue.data(updated);
  }
}
