import 'package:flutter/material.dart';
import 'package:notes_app1/data/note_model.dart';
import 'package:notes_app1/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {

  final Note? note;
  const AddScreen({super.key, this.note});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _titleController=TextEditingController();
  TextEditingController _contentController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool> _showDiscardDialog() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Discard changes?"),
                content: const Text(
                  "Are you sure you want to discard your note?",
                ),
                actions: [
                  ElevatedButton(
                    child: const Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text("Discard"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
        ) ??
        false;
  }

@override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  
  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final viewModel = Provider.of<NoteViewModel>(context, listen: false);
      
      if (widget.note == null) {
        // Create new note
        viewModel.addNote(
          _titleController.text.trim(),
          _contentController.text.trim(),
        );
      } else {
        // Update existing note
        viewModel.updateNote(
          widget.note!,
          _titleController.text.trim(),
          _contentController.text.trim(),
        );
      }
      
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showDiscardDialog,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            title: const Text("Add new note"),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque, // Important
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _titleController,
                                maxLength: 100,
                                decoration: const InputDecoration(
                                  labelText: "Title",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _contentController,
                                minLines: 2,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: "Content",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Note description here...",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Description can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      bool discard = await _showDiscardDialog();
                                      if (discard) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Save note
                                        _saveNote();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      foregroundColor:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                    ),
                                    child: const Text("Submit"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ), // give some space to avoid last tap zone
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
