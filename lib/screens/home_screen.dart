import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book.dart';
import '../models/book_to_read.dart'; // Importer le modèle BookToRead
import '../services/book_service.dart';
import '/screens/book_detail_screen.dart'; // Assurez-vous que ce fichier est bien importé
import '/screens/book_to_read_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];
  final BookService bookService = BookService();
  List<BookToRead> booksToRead = []; // Liste des livres à lire sous forme de BookToRead

  // Rechercher des livres
  void _searchBooks(String query) async {
    if (query.isEmpty) {
      setState(() {
        books = [];
      });
      return;
    }

    try {
      final result = await bookService.fetchBooks(query);
      setState(() {
        books = result;
      });
    } catch (e) {
      print("Erreur de recherche : $e");
      setState(() {
        books = [];
      });
    }
  }

  // Ajouter un livre à la liste "Livres à lire"
  void _addBookToRead(Book book) {
    setState(() {
      // Convertir Book en BookToRead et ajouter à la liste
      booksToRead.add(BookToRead.fromBook(book));
    });
    // Afficher un message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Livre ajouté à la liste de lecture!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma Liste de Livres'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              // Naviguer vers la page des livres à lire en passant la liste des livres à lire
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookToReadListScreen(booksToRead: booksToRead), // Passage de la liste de livres à lire
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchBooks,
              decoration: InputDecoration(
                labelText: 'Rechercher un livre...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? Center(child: Text('Aucun livre trouvé.'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        leading: book.imageUrl.isEmpty
                            ? Icon(Icons.book) // Affiche une icône si l'URL est vide
                            : CachedNetworkImage(
                                imageUrl: book.imageUrl,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                width: 50,
                                height: 50,
                              ),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _addBookToRead(book); // Ajouter le livre à la liste "Livres à lire"
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(
                                book: book,
                                addBookToRead: _addBookToRead,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
