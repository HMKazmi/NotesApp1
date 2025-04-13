# 📝 FlutterNotes

A beautiful simple notes app built with Flutter using MVVM architecture, Provider state management, and SQLite database.

## 📱 Screenshots

### Home Screen (Empty)
![Home Screen - No Notes]((https://github.com/HMKazmi/NotesApp1/blob/master/app_ss/without.jpg))
*getting started? Add your first note!*

### Home Screen (With Notes)
![Home Screen - With Notes](https://github.com/HMKazmi/NotesApp1/blob/master/app_ss/with_notes.jpg)
*Keep all your thoughts organized in one place*

### Add/Edit Note Screen
![Add/Edit Note Screen](https://github.com/HMKazmi/NotesApp1/blob/master/app_ss/add_screen.jpg)
*Simple interface for capturing your ideas*

## 🚀 Features

- Create, read, update, and delete notes
- Clean and intuitive UI
- Persistent storage with SQLite
- Dark mode support
- Sort notes by last updated

## 🏗️ Architecture

This project follows the MVVM (Model-View-ViewModel) architecture pattern:

```
lib/
  ├── core/       # Theme, utils, constants
  ├── data/       # Models, local storage (SQLite)
  ├── view/       # UI screens and widgets
  ├── view_model/ # Providers/ViewModels
  └── main.dart
```

## 💻 Tech Stack

- Flutter & Dart
- Provider for state management
- SQLite for local database
- MVVM architecture

## 🛠️ Installation

1. Clone this repo
   ```bash
   git clone https://github.com/yourusername/flutter_notes.git
   ```

2. Navigate to the project folder
   ```bash
   cd flutter_notes
   ```

3. Install dependencies
   ```bash
   flutter pub get
   ```

4. Run the app
   ```bash
   flutter run
   ```

## 📚 What I Learned

Building this app was a super cool learning experience! I got to dive deep into:

- Implementing MVVM in Flutter (way cleaner code!)
- Working with SQLite (my first time using a local DB in mobile)
- Provider state management (much easier than I expected)
- Form handling and validation

The hardest part was definitely setting up the database helper class, but once I got that working, everything else fell into place.

## 🔮 Future Improvements

I'm planning to add:
- Note categories/tags
- Search functionality
- Cloud sync (Firebase maybe?)
- Rich text formatting
- Share notes with friends
- Reminder notifications

## 📄 License

This project is licensed under the HussainMehdi License - see the LICENSE file for details.

---

Made with ☕ and Flutter by HMKazmi
