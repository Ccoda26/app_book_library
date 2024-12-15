import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import '../config.dart';

class BookService {
  // Proxy CORS pour contourner les restrictions CORS
  final String corsProxy = 'https://cors-anywhere.herokuapp.com/';
  
  // Clé API Google Books
  final String apiKey = Config.apiKey; // Remplacez par votre clé API Google Books
  
  // Méthode pour récupérer les livres depuis l'API de Google Books
  Future<List<Book>> fetchBooks(String query) async {
    // URL avec la clé API incluse
    final url = 'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey';
    
    // Effectuer la requête HTTP
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['items'];

      return data.map((item) {
        // Extraire les informations du livre
        final title = item['volumeInfo']['title'];
        final author = item['volumeInfo']['authors']?.join(', ') ?? 'Auteur inconnu';
        final description = item['volumeInfo']['description'] ?? 'Aucune description';
        final imageUrl = item['volumeInfo']['imageLinks']?['thumbnail'] ?? '';

        // Remplacer 'http' par 'https' si l'URL de l'image commence par 'http://'
        String secureImageUrl = imageUrl.replaceAll('http://', 'https://');
        // Utiliser le proxy CORS pour contourner les problèmes CORS
        secureImageUrl = corsProxy + secureImageUrl;

        // Retourner l'objet Book avec les informations extraites
        return Book(
          title: title,
          author: author,
          description: description,
          imageUrl: secureImageUrl,  // Utiliser l'URL sécurisée et proxifiée
        );
      }).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
