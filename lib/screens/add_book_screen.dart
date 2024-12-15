import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../services/book_service.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _controller = TextEditingController();
  final BookService bookService = BookService();

  void _addBook() async {
    final query = _controller.text;
    final books = await bookService.fetchBooks(query);
    if (books.isNotEmpty) {
      Navigator.pop(context, books[0]); // Retourner le premier livre trouvé
    } else {
      // Gérer l'absence de résultats
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Aucun livre trouvé')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Livre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Titre du livre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addBook,
              child: Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }
}
