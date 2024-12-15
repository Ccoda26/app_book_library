import 'package:flutter/material.dart';
import '../models/book_to_read.dart'; // Assurez-vous d'importer le bon fichier

class BookToReadListScreen extends StatefulWidget {
  final List<BookToRead> booksToRead; // Ajout d'un paramètre pour la liste des livres à lire

  // Constructor pour recevoir la liste des livres à lire
  BookToReadListScreen({required this.booksToRead});

  @override
  _BookToReadListScreenState createState() => _BookToReadListScreenState();
}

class _BookToReadListScreenState extends State<BookToReadListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livres à lire'),
      ),
      body: widget.booksToRead.isEmpty
          ? Center(child: Text('Aucun livre à lire pour le moment.'))
          : ListView.builder(
              itemCount: widget.booksToRead.length,
              itemBuilder: (context, index) {
                final book = widget.booksToRead[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  leading: book.imageUrl.isEmpty
                      ? Icon(Icons.book)
                      : Image.network(book.imageUrl, width: 50, height: 50),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter un livre à la liste
        },
        child: Icon(Icons.add),
        tooltip: 'Ajouter un livre',
      ),
    );
  }
}
