import 'package:flutter/material.dart';
import 'package:notes_app1/view/AddScreen.dart';
import 'package:notes_app1/view/widget/notes_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Notes Homepage", style: TextStyle()),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => AddScreen()),
        //       );
        //     },
        //     icon: Icon(Icons.add),
        //   ),
        // ],
      ),
      body: const Padding(padding: EdgeInsets.all(8), child: NotesGrid()),
    );
  }
}
