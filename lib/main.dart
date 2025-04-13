import 'package:flutter/material.dart';
import 'package:notes_app1/core/theme.dart';
import 'package:notes_app1/core/theme_notifier.dart';
import 'package:notes_app1/view/HomeScreen.dart';
import 'package:notes_app1/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),  // Provide the ThemeNotifier
      ],
      child: Consumer2<NoteViewModel, ThemeNotifier>(
        builder: (context, noteViewModel, themeNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}