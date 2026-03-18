import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rgenrkojurrqdhhtbzts.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnZW5ya29qdXJycWRoaHRienRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3ODc5MDksImV4cCI6MjA4OTM2MzkwOX0.c7wCnJxDnW9eixtjXyyAI6Y-v1h4hWKJkX-w7e1xkPU',
  );

  runApp(FluttetFoodLogApp());
}

class FluttetFoodLogApp extends StatefulWidget {
  const FluttetFoodLogApp({super.key});

  @override
  State<FluttetFoodLogApp> createState() => _FluttetFoodLogAppState();
}

class _FluttetFoodLogAppState extends State<FluttetFoodLogApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
