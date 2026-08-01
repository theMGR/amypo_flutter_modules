class Book {
  String title;
  String author;
  String isbn;
  bool isIssued;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.isIssued = false,
  });
}