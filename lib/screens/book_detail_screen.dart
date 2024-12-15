import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/book_to_read.dart'; // Ajouté pour l'importation de BookToRead

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final Function(Book) addBookToRead; // Fonction pour ajouter le livre à la liste

  BookDetailScreen({required this.book, required this.addBookToRead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.imageUrl.isNotEmpty)
              Image.network(
                book.imageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error); // Afficher une icône en cas d'erreur
                },
              ),
            SizedBox(height: 16),
            Text(
              'Auteur: ${book.author}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ajouter le livre à la liste "Livres à lire"
                addBookToRead(book);
                // Afficher un message de confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Livre ajouté à la liste de lecture!')),
                );
              },
              child: Text('Ajouter à la liste de lecture'),
            ),
          ],
        ),
      ),
    );
  }
}
