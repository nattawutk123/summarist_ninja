import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/book.dart';
import '../../../widgets/book_list.dart';
import '../../../widgets/random_book.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final jsonFile = await rootBundle.loadString('assets/books.json');
    final parsedJson = json.decode(jsonFile);

    setState(() {
      _books = List.from(parsedJson.map((json) => Book.fromJson(json)));
    });
  }

  List<String> _getCategories() {
    final categories = _books.map((book) => book.category).toSet().toList();
    categories.sort();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Discover",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
            ),
            if (_books.isNotEmpty) RandomBookWidget(books: _books),
            const SizedBox(
              height: 20,
            ),
            for (final category in categories)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: BookListWidget(
                  title: category,
                  books: _books
                      .where((book) => book.category == category)
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
