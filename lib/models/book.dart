class Book {
  int? id;
  String title;
  String author;
  String imageUrl;
  String description;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.description,
  });
  
  // Convertir un Map en objet Book
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}
