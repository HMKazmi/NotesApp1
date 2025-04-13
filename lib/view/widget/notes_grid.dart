import 'package:flutter/material.dart';
import 'package:notes_app1/core/utils.dart';
import 'package:notes_app1/data/note_model.dart';
import 'package:notes_app1/view/AddScreen.dart';
import 'package:notes_app1/view_model/note_view_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatefulWidget {
  const NotesGrid({super.key});

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: Consumer<NoteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.notes.isEmpty) {
            return const Center(
              child: Text(
                'No notes yet. Create one!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: viewModel.notes.length,
            itemBuilder: (context, index) {
              final note = viewModel.notes[index];
              return NoteTile(note: note);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteTile extends StatefulWidget {
  final Note note;

  const NoteTile({super.key, required this.note});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails _tapDownDetails, BuildContext context) {
    print("object");
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = renderBox.globalToLocal(_tapDownDetails.globalPosition);
      print(_tapPosition);
    });
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 16, 16),
        Rect.fromLTWH(
          0,
          0,
          overlay!.paintBounds.size.width,
          overlay!.paintBounds.size.height,
        ),
      ),
      items: [
        PopupMenuItem(
          child: Text("Edit Note"),
          value: "edit",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(note: widget.note),
              ),
            );
          },
        ),
        PopupMenuItem(
          child: Text("Delete Note"),
          value: "delete",
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return _deleteNote(context);
              },
            );
          },
        ),
        PopupMenuItem(
          child: Text("Close Menu"),
          value: "close",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _deleteNote(context) {
    return AlertDialog(
      title: const Text('Delete Note'),
      content: const Text('Are you sure you want to delete this note?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<NoteViewModel>(
              context,
              listen: false,
            ).deleteNote(widget.note);
            Navigator.pop(context);
          },
          child: const Text('DELETE'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (position) {
        _getTapPosition(position, context);
      },
      onLongPress: () {
        _showContextMenu(context);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          title: Text(
            widget.note.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Updated: ${DateFormatter.formatDate(widget.note.updatedAt)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(note: widget.note),
              ),
            );
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _deleteNote(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
