import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/book_data.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=2670&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: initialBooks.length,
          itemBuilder: (context, index) {
            final Book book = initialBooks[index];

            return Card(
              color: Colors.white.withOpacity(0.85),
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: book.isIssued ? Colors.red[100] : Colors.green[100],
                  child: Icon(
                    Icons.book,
                    color: book.isIssued ? Colors.red : Colors.green,
                  ),
                ),
                title: Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Author: ${book.author}\nISBN: ${book.isbn}'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: book.isIssued ? Colors.orange : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      book.isIssued = !book.isIssued;
                    });
                  },
                  child: Text(book.isIssued ? 'Return' : 'Issue'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}