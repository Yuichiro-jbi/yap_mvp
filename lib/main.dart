import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

const supabaseUrl = 'https://fomfdlextkmvafbgwctf.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZvbWZkbGV4dGttdmFmYmd3Y3RmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM0ODg4MDMsImV4cCI6MjA0OTA2NDgwM30.5L2Vxp4CgbmQN6pmwhZhSrcvr2_YSOP0sodLGZUqdBw';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
