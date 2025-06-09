import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// NoteEase App Main Container (Primary Screen)
// Features: list, search, pin/pinned, sorting, categories, FAB for add, theme.
// ----------------------------------------------------------------------------

// PUBLIC_INTERFACE
void main() {
  runApp(const NoteEaseApp());
}

// Note data model.
class Note {
  String id;
  String title;
  String content;
  bool pinned;
  DateTime lastModified;
  List<String> categories;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.pinned = false,
    required this.lastModified,
    required this.categories,
  });
}

// Dummy categories and associated tag colors.
final Map<String, Color> categoryTagColors = {
  'Personal': Colors.orange.shade200,
  'Work': Colors.blue.shade200,
  'Study': Colors.green.shade200,
  'Ideas': Colors.purple.shade200,
  'Other': Colors.grey.shade300,
};

// Dummy notes for demonstration.
List<Note> getInitialDummyNotes() => [
      Note(
        id: '1',
        title: "Pinned Idea",
        content: "Pin this idea for later consideration on project improvements.",
        pinned: true,
        lastModified: DateTime.now().subtract(const Duration(hours: 1)),
        categories: ['Ideas'],
      ),
      Note(
        id: '2',
        title: "Grocery list",
        content: "Apples, eggs, bread. See if there are sales at the local store.",
        pinned: false,
        lastModified: DateTime.now().subtract(const Duration(days: 1)),
        categories: ['Personal'],
      ),
      Note(
        id: '3',
        title: "Client meeting",
        content:
            "Discuss deliverables and deadline extension with client tomorrow.",
        pinned: false,
        lastModified: DateTime.now().subtract(const Duration(hours: 6)),
        categories: ['Work'],
      ),
      Note(
        id: '4',
        title: "Exam Revision",
        content: "Revise chapters 7, 8, and 9 before Friday.",
        pinned: true,
        lastModified: DateTime.now().subtract(const Duration(hours: 2)),
        categories: ['Study'],
      ),
      Note(
        id: '5',
        title: "New Note Example",
        content: "This is an example of a note with no category.",
        pinned: false,
        lastModified: DateTime.now().subtract(const Duration(hours: 10)),
        categories: [],
      ),
    ];

// Theme colors from the design.
const kBrandPrimary = Color(0xFF4A90E2);
const kBrandSecondary = Color(0xFFF5F7FA);
const kBrandAccent = Color(0xFFFFD700);

final ThemeData noteEaseTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: kBrandPrimary,
    secondary: kBrandSecondary,
    surface: kBrandSecondary,
    background: kBrandSecondary,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black87,
    onBackground: Colors.black,
    onError: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kBrandAccent,
    foregroundColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kBrandPrimary,
    foregroundColor: Colors.white,
    elevation: 1,
  ),
  scaffoldBackgroundColor: kBrandSecondary,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14.0),
    labelMedium: TextStyle(fontWeight: FontWeight.w500),
  ),
);

// PUBLIC_INTERFACE
class NoteEaseApp extends StatelessWidget {
  const NoteEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteEase',
      theme: noteEaseTheme,
      home: const NotesMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// PUBLIC_INTERFACE
class NotesMainScreen extends StatefulWidget {
  const NotesMainScreen({super.key});

  @override
  State<NotesMainScreen> createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  List<Note> _notes = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _notes = getInitialDummyNotes();
  }

  // Filtered, sorted, and partitioned notes for display.
  List<Note> get _filteredNotes {
    final query = _searchQuery.trim().toLowerCase();
    final notesFiltered = query.isEmpty
        ? _notes
        : _notes.where((n) {
            final inTitle = n.title.toLowerCase().contains(query);
            final inContent = n.content.toLowerCase().contains(query);
            final inCategory =
                n.categories.any((cat) => cat.toLowerCase().contains(query));
            return inTitle || inContent || inCategory;
          }).toList();
    // Sort: pinned above, then lastModified desc.
    notesFiltered.sort((a, b) {
      if (a.pinned == b.pinned) {
        return b.lastModified.compareTo(a.lastModified);
      } else if (a.pinned) {
        return -1;
      } else {
        return 1;
      }
    });
    return notesFiltered;
  }

  // Callback for pinning or unpinning a note.
  void _togglePin(Note note) {
    setState(() {
      note.pinned = !note.pinned;
      note.lastModified = DateTime.now();
    });
  }

  // Callback to simulate creating a new note.
  void _addNote() {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "Untitled Note",
      content: "",
      pinned: false,
      lastModified: DateTime.now(),
      categories: [],
    );
    setState(() {
      _notes.insert(0, newNote);
    });
    // For demonstration, normally you would navigate to an edit/new screen.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New note created. Tap to edit.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Callback to simulate deleting a note.
  void _deleteNote(Note note) {
    setState(() {
      _notes.removeWhere((n) => n.id == note.id);
    });
  }

  // Callback to simulate editing a note.
  void _editNote(Note note) async {
    // For demonstration: show a dialog to rename + content.
    TextEditingController titleController =
        TextEditingController(text: note.title);
    TextEditingController contentController =
        TextEditingController(text: note.content);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Content"),
              minLines: 1,
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                note.title = titleController.text;
                note.content = contentController.text;
                note.lastModified = DateTime.now();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Callback to assign a category/tag.
  void _assignCategory(Note note, String category) {
    setState(() {
      if (note.categories.contains(category)) {
        note.categories.remove(category);
      } else {
        note.categories.add(category);
      }
      note.lastModified = DateTime.now();
    });
  }

  // UI helpers.
  Widget _buildCategoryChips(Note note) {
    if (note.categories.isEmpty) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 6,
      children: note.categories
          .map((cat) => Chip(
                label: Text(cat),
                backgroundColor:
                    categoryTagColors[cat] ?? Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                    VisualDensity(horizontal: -2.0, vertical: -3.0),
              ))
          .toList(),
    );
  }

  // UI: Each Note Card in list
  Widget _buildNoteCard(Note note) {
    return Card(
      elevation: note.pinned ? 4 : 1,
      color: note.pinned ? kBrandPrimary.withOpacity(0.08) : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            note.pinned ? Icons.push_pin : Icons.push_pin_outlined,
            color: note.pinned ? kBrandAccent : Colors.grey,
          ),
          tooltip: note.pinned ? 'Unpin' : 'Pin',
          onPressed: () => _togglePin(note),
        ),
        title: Text(
          note.title.isNotEmpty ? note.title : "(No Title)",
          style: note.pinned
              ? const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBrandPrimary,
                )
              : null,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content snippet, truncated to 2 lines
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
              child: Text(
                note.content.replaceAll('\n', ' '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            _buildCategoryChips(note),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                "Modified: ${_friendlyDate(note.lastModified)}",
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (action) {
            if (action == 'delete') _deleteNote(note);
            if (action == 'edit') _editNote(note);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () => _editNote(note),
      ),
    );
  }

  String _friendlyDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0)
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} today";
    if (diff.inDays == 1)
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} yesterday";
    return "${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  // Main build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteEase'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.category_outlined),
            tooltip: 'Manage categories',
            onPressed: () {
              // Show dropdown for assigning category to dummy note (for demo).
              showDialog(
                context: context,
                builder: (context) {
                  if (_notes.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final note = _notes.first;
                  return AlertDialog(
                    title: const Text('Assign Categories (demo: first note)'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: categoryTagColors.keys
                          .map((cat) => CheckboxListTile(
                                title: Text(cat),
                                value: note.categories.contains(cat),
                                activeColor: categoryTagColors[cat],
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (_) => _assignCategory(note, cat),
                              ))
                          .toList(),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Done'))
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search notes...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: kBrandPrimary.withOpacity(0.18)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          // Notes List
          Expanded(
            child: _filteredNotes.isEmpty
                ? Center(
                    child: Text(
                      "No notes found.\nCreate your first note!",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, idx) {
                      final note = _filteredNotes[idx];
                      return _buildNoteCard(note);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: "Create Note",
        child: const Icon(Icons.add),
      ),
    );
  }
}
