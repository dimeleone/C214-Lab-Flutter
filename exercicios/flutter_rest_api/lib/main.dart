import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Book> fetchBook(int index) async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=sherlock&startIndex=$index'));

  if (response.statusCode == 200) {
    return Book.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao carregar o livro');
  }
}

class Book {
  final String id;
  final String title;
  final String author;

  const Book({
    required this.id,
    required this.title,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final item = json['items'][1];
    final volumeInfo = item['volumeInfo'];

    return Book(
      id: item['id'],
      title: volumeInfo['title'],
      author: volumeInfo['authors'][0],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Book> futureBook;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureBook = fetchBook(currentIndex);
  }

  void getNextBook() {
    setState(() {
      currentIndex++;
      futureBook = fetchBook(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livro',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Livros sobre Sherlock Holmes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: getNextBook,
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder<Book>(
            future: futureBook,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final book = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_online, size: 80, color: Colors.blueGrey),
                    const SizedBox(height: 20),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'por ${book.author}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
