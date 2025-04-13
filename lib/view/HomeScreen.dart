import 'package:flutter/material.dart';
import 'package:notes_app1/core/theme_notifier.dart';
import 'package:notes_app1/view/AddScreen.dart';
import 'package:notes_app1/view/widget/notes_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Notes Homepage", style: TextStyle()),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Toggle theme mode when the button is pressed
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: const Padding(padding: EdgeInsets.all(8), child: NotesGrid()),
    );
  }
}
