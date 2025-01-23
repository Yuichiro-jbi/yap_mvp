import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/islander.dart';

class IslanderData {
  final SupabaseClient _supabase;
  // このIDはislander_idとして使用
  static const _testIslanderId = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';

  IslanderData(this._supabase);

  Future<Islander> getIslander() async {
    try {
      final response = await _supabase
          .from('islanders')
          .select()
          .eq('islander_id', _testIslanderId)  // islander_idで検索
          .single();
      
      print('Supabase Response: $response'); // デバッグ用
      
      if (response == null) {
        throw Exception('Islander not found');
      }
      
      return Islander.fromJson(response);
    } catch (e) {
      print('Error getting islander: $e'); // デバッグ用
      throw Exception('Islanderの取得に失敗しました: $e');
    }
  }

  Future<void> updateIslander(Islander islander) async {
    try {
      final response = await _supabase
          .from('islanders')
          .upsert({
            ...islander.toJson(),
            'islander_id': _testIslanderId,  // islander_idを設定
          })
          .select()
          .single();
      
      print('Update Response: $response'); // デバッグ用
    } catch (e) {
      print('Error updating islander: $e'); // デバッグ用
      throw Exception('Islanderの更新に失敗しました: $e');
    }
  }
}
