class Quote {
  String quote;
  String author;

  Quote({
    required this.quote,
    required this.author,
  });

  factory Quote.fromMap({required Map<String, dynamic> data}) {
    return Quote(quote: data['quote'], author: data['author']);
  }
}
