import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/islander.dart';

class IslanderData {
  final SupabaseClient _supabase;
  // このIDはislander_idとして使用
  static const _testIslanderId = '0e76015d-0406-4ebf-920b-dd53e7a0dce6';

  IslanderData(this._supabase);

  Future<Islander> getIslander() async {
    try {
      final response = await _supabase
          .from('islanders')
          .select()
          .eq('id', _testIslanderId)  // islander_idで検索
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
            'id': _testIslanderId,  // islander_idを設定
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
