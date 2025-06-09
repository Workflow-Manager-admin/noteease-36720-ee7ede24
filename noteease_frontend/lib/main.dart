import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
void main() {
  runApp(NoteEaseApp());
}

// Notebook skeuomorphic color themes and texture simulation
class AppThemes {
  // Light notebook: paper (off-white), leather brown, deep ink blue/black.
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF6F3EC), // realistic paper tone
    primaryColor: const Color(0xFF7C5C33), // leather-like brown for headers, appbars
    accentColor: const Color(0xFF28334A), // deep ink blue/black
    cardColor: const Color(0xFFFEF7E5), // card/paper note
    canvasColor: const Color(0xFFEBE3CF), // divider/secondary paper
    shadowColor: Colors.brown.withOpacity(0.23),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Georgia', color: Color(0xFF403531)),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Georgia'),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF9A7B4F),
      elevation: 3.7,
      // subtle shadow for skeuomorphic look
      shadowColor: Color(0xFF6C4D22),
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        color: Color(0xFFF6F3EC),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: Color(0xFFF6F3EC)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF705534),
    ),
    // Use subtle border and shadow for skeuomorphic depth
    cardTheme: CardTheme(
      color: const Color(0xFFFEF7E5),
      elevation: 8,
      shadowColor: Colors.brown.withOpacity(0.28),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.brown.shade100,
          width: 2.2,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF5E5C0),
      selectedColor: const Color(0xFFD7C49E),
      labelStyle: const TextStyle(color: Color(0xFF705534)),
      secondaryLabelStyle: const TextStyle(color: Color(0xFF363637)),
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF453827)),
    dividerColor: const Color(0xFFEAD8BB),
    dialogBackgroundColor: const Color(0xFFF6F3EC),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xFF7C5C33),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      textStyle: const TextStyle(color: Color(0xFFF6F3EC)),
    ),
  );

  // Dark notebook: dark brown/black for leather, warm mid-tan for paper, ink blue/white.
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF28231C), // leather binding
    primaryColor: const Color(0xFF4E3722),
    accentColor: const Color(0xFFCED2DB),
    cardColor: const Color(0xFF362C20), // deep brown paper
    canvasColor: const Color(0xFF3D3328),
    shadowColor: Colors.black.withOpacity(0.36),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF422D18),
      elevation: 5,
      shadowColor: Color(0xFF181008),
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        color: Color(0xFFD2B485),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: Color(0xFFD2B485)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6A5337),
      foregroundColor: Color(0xFFD2B485),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Georgia', color: Color(0xFFE7DEC7)),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Georgia'),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF3F362A),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.37),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.brown.shade700,
          width: 2.5,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF66543A),
      selectedColor: const Color(0xFFC1B18D),
      labelStyle: const TextStyle(color: Color(0xFFEEDCAA)),
      secondaryLabelStyle: const TextStyle(color: Color(0xFFC4B188)),
      brightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: Color(0xFFD8C7AC)),
    dividerColor: const Color(0xFF695A45),
    dialogBackgroundColor: const Color(0xFF3D3328),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xFF805A32),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade800.withOpacity(0.22),
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      textStyle: const TextStyle(color: Color(0xFFEEDCAA)),
    ),
  );
}

class NoteEaseApp extends StatefulWidget {
  @override
  State<NoteEaseApp> createState() => _NoteEaseAppState();
}

class _NoteEaseAppState extends State<NoteEaseApp> {
  bool _isDarkMode = false;

  // PUBLIC_INTERFACE
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteEase',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: NotesHomeScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

// -- Main Home Widget for Notes --
class NotesHomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const NotesHomeScreen({
    required this.isDarkMode,
    required this.onThemeToggle,
    Key? key,
  }) : super(key: key);

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  List<NoteItem> _notes = [];
  List<NoteItem> _filteredNotes = [];
  String _searchQuery = "";

  // Example categories for tags
  final List<String> _categories = [
    'Personal',
    'Work',
    'Ideas',
    'Lists',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _filteredNotes = _notes;
  }

  void _createNote() async {
    final NoteItem? newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(
          categories: _categories,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
    if (newNote != null) {
      setState(() {
        _notes.add(newNote);
        _filterNotes(_searchQuery);
      });
    }
  }

  void _editNote(int idx) async {
    final NoteItem? updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(
          note: _notes[idx],
          categories: _categories,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
    if (updatedNote != null) {
      setState(() {
        _notes[idx] = updatedNote;
        _filterNotes(_searchQuery);
      });
    }
  }

  void _deleteNote(int idx) {
    setState(() {
      _notes.removeAt(idx);
      _filterNotes(_searchQuery);
    });
  }

  void _pinNote(int idx) {
    setState(() {
      final note = _notes.removeAt(idx);
      note.isPinned = !note.isPinned;
      if (note.isPinned) {
        _notes.insert(0, note);
      } else {
        _notes.add(note);
      }
      _filterNotes(_searchQuery);
    });
  }

  void _filterNotes(String query) {
    _searchQuery = query;
    setState(() {
      if (query.trim().isEmpty) {
        _filteredNotes = [..._notes];
      } else {
        _filteredNotes = _notes
            .where((note) =>
                note.title.toLowerCase().contains(query.toLowerCase()) ||
                note.content.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      // Keep pinned notes at the top in filtered list
      _filteredNotes.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.lastModified.compareTo(a.lastModified);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteEase'),
        actions: [
          // Skeuomorphic toggle: button as a leather tab
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Tooltip(
              message: isDark ? "Switch to Light Notebook" : "Switch to Dark Notebook",
              child: GestureDetector(
                onTap: widget.onThemeToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF4E3722) : const Color(0xFFD4C2A2),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black45 : Colors.brown.withOpacity(0.23),
                        offset: const Offset(2, 5),
                        blurRadius: 6,
                      ),
                    ],
                    border: Border.all(
                        color: isDark
                            ? const Color(0xFF72592A)
                            : const Color(0xFF755835),
                        width: 2.1),
                  ),
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: isDark
                        ? const Color(0xFFD2B485)
                        : const Color(0xFF6A4A1B),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 65,
        centerTitle: true,
        shape: const RoundedBorderAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          // Simulated paper texture by overlaying old paper color streaks.
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF33281E),
                    const Color(0xFF262113),
                  ]
                : [
                    const Color(0xFFF6F3EC),
                    const Color(0xFFEDE3C5),
                  ],
          ),
          // Subtle inner shadow for skeuomorphic effect
          boxShadow: [
            BoxShadow(
                color: Colors.brown.withOpacity(isDark ? 0.32 : 0.16),
                blurRadius: 36,
                spreadRadius: 1,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(theme, isDark),
            Expanded(
              child: _filteredNotes.isEmpty
                  ? Center(
                      child: Text(
                        "No notes. Tap the '+' to add!",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: isDark
                              ? Colors.brown.shade100
                              : Colors.brown.shade400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 12, bottom: 70),
                      itemCount: _filteredNotes.length,
                      itemBuilder: (context, idx) {
                        final note = _filteredNotes[idx];
                        final originIdx = _notes.indexOf(note);
                        return _NoteCard(
                          note: note,
                          isDark: isDark,
                          onTap: () => _editNote(originIdx),
                          onDelete: () => _deleteNote(originIdx),
                          onPin: () => _pinNote(originIdx),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildNotebookFab(isDark, theme),
    );
  }

  Widget _buildSearchBar(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 19, 22, 7),
      child: Material(
        elevation: 7,
        borderRadius: BorderRadius.circular(16),
        color: isDark ? const Color(0xFF3B3224) : const Color(0xFFFFFDF4),
        child: TextField(
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 16,
            color:
                isDark ? const Color(0xFFF6DDC5) : const Color(0xFF252626),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search your notes...",
            hintStyle: TextStyle(
              color:
                  isDark ? Colors.brown.shade200 : Colors.brown.shade300,
              fontFamily: 'Georgia',
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDark
                  ? const Color(0xFFB5A078)
                  : const Color(0xFF765A39),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: _filterNotes,
        ),
      ),
    );
  }

  Widget _buildNotebookFab(bool isDark, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.brown.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 7))
        ],
      ),
      child: FloatingActionButton(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42)),
        onPressed: _createNote,
        child: Icon(Icons.add,
            size: 32,
            color: isDark
                ? const Color(0xFFD2B485)
                : const Color(0xFF624C27)),
        tooltip: "Create a New Note",
      ),
    );
  }
}

// Custom AppBar rounded bottom edge (skeuomorphic notebook tab)
class RoundedBorderAppBar extends ContinuousRectangleBorder {
  const RoundedBorderAppBar()
      : super(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        );
}

// Note card representation with skeuomorphic style
class _NoteCard extends StatelessWidget {
  final NoteItem note;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const _NoteCard({
    required this.note,
    required this.isDark,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Simulate hand-torn notebook edges and layered shadows
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      color: theme.cardColor,
      elevation: note.isPinned ? 22 : theme.cardTheme.elevation,
      shadowColor: note.isPinned
          ? Colors.amberAccent.withOpacity(0.24)
          : theme.cardTheme.shadowColor,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: note.isPinned
              ? Colors.amber.shade700
              : (isDark
                  ? Colors.brown.shade700
                  : Colors.brown.shade300),
          width: note.isPinned ? 3 : 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: isDark
            ? Colors.brown.withOpacity(0.13)
            : Colors.amber.withOpacity(0.18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 14, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (note.isPinned)
                    Icon(
                      Icons.push_pin,
                      color: isDark
                          ? Colors.amberAccent.shade100
                          : Colors.amber.shade700,
                      size: 22,
                    ),
                  Expanded(
                    child: Text(
                      note.title,
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.w700,
                        fontSize: 17.8,
                        // "embossed" with subtle shadow
                        shadows: [
                          Shadow(
                              blurRadius: 6,
                              color: isDark
                                  ? Colors.brown.shade900.withOpacity(0.18)
                                  : Colors.white.withOpacity(0.42),
                              offset: const Offset(0, 1.6))
                        ],
                        color: isDark
                            ? const Color(0xFFEEDCAA)
                            : const Color(0xFF372016),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.pin_drop,
                        color: note.isPinned
                            ? Colors.amber
                            : (isDark
                                ? Colors.brown.shade200
                                : Colors.brown.shade700)),
                    tooltip: note.isPinned ? "Unpin" : "Pin",
                    onPressed: onPin,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: isDark
                            ? Colors.red.shade300
                            : Colors.red.shade700),
                    tooltip: "Delete",
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                note.content,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.7,
                  color: isDark
                      ? Colors.brown.shade100
                      : const Color(0xFF3C2B14),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 8,
                runSpacing: 1,
                children: note.categories.map((c) {
                  return Chip(
                    label: Text(c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 2),
                  child: Text(
                    _timeAgo(note.lastModified),
                    style: TextStyle(
                      fontSize: 11.1,
                      fontFamily: 'Courier',
                      color: isDark
                          ? Colors.brown.shade300
                          : Colors.brown.shade500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Note data model
class NoteItem {
  String title;
  String content;
  List<String> categories;
  DateTime lastModified;
  bool isPinned;

  NoteItem({
    required this.title,
    required this.content,
    required this.categories,
    required this.lastModified,
    this.isPinned = false,
  });
}

// Note edit/create screen with skeuomorphic paper style
class NoteEditScreen extends StatefulWidget {
  final NoteItem? note;
  final List<String> categories;
  final bool isDarkMode;

  const NoteEditScreen({
    this.note,
    required this.categories,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late List<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
    _selectedCategories = List<String>.from(widget.note?.categories ?? []);
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) return;
    final createdNote = NoteItem(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      categories: _selectedCategories,
      lastModified: DateTime.now(),
      isPinned: widget.note?.isPinned ?? false,
    );
    Navigator.of(context).pop(createdNote);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "New Note" : "Edit Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: "Save Note",
            onPressed: _saveNote,
            color: isDark ? const Color(0xFFD2B485) : const Color(0xFF6A4A1B),
          ),
        ],
        toolbarHeight: 65,
        shape: const RoundedBorderAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF3E301F),
                    const Color(0xFF21190D),
                  ]
                : [
                    const Color(0xFFFEF7E5),
                    const Color(0xFFEEE1C6),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.brown.withOpacity(isDark ? 0.28 : 0.10),
                blurRadius: 32,
                offset: const Offset(0, 8))
          ],
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 18),
          children: [
            _paperField(
              controller: _titleController,
              hint: "Note Title",
              isDark: isDark,
              fontSize: 19.2,
              bold: true,
              maxLines: 2,
            ),
            const SizedBox(height: 14),
            _paperField(
              controller: _contentController,
              hint: "Your note...",
              isDark: isDark,
              fontSize: 15.7,
              maxLines: 14,
            ),
            const SizedBox(height: 18),
            Text(
              "Categories",
              style: TextStyle(
                fontFamily: 'Georgia',
                fontWeight: FontWeight.w500,
                color:
                    isDark ? Colors.brown.shade200 : Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 10,
              children: widget.categories.map((c) {
                final selected = _selectedCategories.contains(c);
                return FilterChip(
                  label: Text(
                    c,
                    style: TextStyle(
                        color: selected
                            ? (isDark
                                ? Colors.brown.shade900
                                : Colors.brown.shade800)
                            : (isDark
                                ? Colors.brown.shade200
                                : Colors.brown.shade700)),
                  ),
                  selected: selected,
                  onSelected: (sel) {
                    setState(() {
                      if (sel) {
                        _selectedCategories.add(c);
                      } else {
                        _selectedCategories.remove(c);
                      }
                    });
                  },
                  selectedColor: isDark
                      ? Colors.amber.shade200
                      : Colors.amber.shade100,
                  backgroundColor: isDark
                      ? Colors.brown.shade800.withOpacity(0.64)
                      : Colors.brown.shade100,
                  checkmarkColor: isDark
                      ? Colors.brown.shade900
                      : Colors.brown.shade700,
                  showCheckmark: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  elevation: 3,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paperField({
    required TextEditingController controller,
    required String hint,
    required bool isDark,
    double fontSize = 17,
    bool bold = false,
    int maxLines = 1,
  }) {
    return Material(
      color: isDark ? const Color(0xFF3E301F) : const Color(0xFFFEF7E5),
      elevation: 6.5,
      borderRadius: BorderRadius.circular(16),
      shadowColor: isDark
          ? Colors.brown.shade900.withOpacity(0.2)
          : Colors.brown.shade400.withOpacity(0.13),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: TextField(
          controller: controller,
          style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
              fontSize: fontSize,
              color: isDark
                  ? const Color(0xFFE7DEC7)
                  : const Color(0xFF332B19)),
          maxLines: maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                color:
                    isDark ? Colors.brown.shade700 : Colors.brown.shade400),
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(bottom: 0),
          ),
        ),
      ),
    );
  }
}

String _timeAgo(DateTime dt) {
  final dur = DateTime.now().difference(dt);
  if (dur.inDays > 0) return "${dur.inDays}d ago";
  if (dur.inHours > 0) return "${dur.inHours}h ago";
  if (dur.inMinutes > 0) return "${dur.inMinutes}m ago";
  if (dur.inSeconds > 15) return "${dur.inSeconds}s ago";
  return "now";
}
