import 'package:book_list_app/models/book.dart';  // Importation du modèle Book

class BookToRead {
  final int? id;            // Identifiant unique pour SQLite
  final String title;       // Titre du livre
  final String author;      // Auteur du livre
  final String imageUrl;    // URL de l'image de couverture
  final String description; // Description du livre

  // Constructeur
  BookToRead({
    this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });

  // Méthode pour créer un objet BookToRead à partir d'un objet Book
  factory BookToRead.fromBook(Book book) {
    return BookToRead(
      title: book.title,
      author: book.author,
      imageUrl: book.imageUrl,
      description: book.description,
    );
  }

  // Convertir un objet BookToRead en un Map pour le stockage dans SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,             // L'id est facultatif si ce n'est pas encore généré par la DB
      'title': title,       // Le titre du livre
      'author': author,     // L'auteur du livre
      'imageUrl': imageUrl, // L'URL de l'image de couverture
      'description': description, // La description du livre
    };
  }

  // Convertir un Map (généralement issu de la base de données) en un objet BookToRead
  factory BookToRead.fromMap(Map<String, dynamic> map) {
    return BookToRead(
      id: map['id'],                     // Récupérer l'ID depuis la base de données
      title: map['title'],               // Récupérer le titre
      author: map['author'],             // Récupérer l'auteur
      imageUrl: map['imageUrl'],         // Récupérer l'URL de l'image
      description: map['description'],   // Récupérer la description
    );
  }
}
