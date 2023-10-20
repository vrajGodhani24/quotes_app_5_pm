class Quotes {
  int id;
  String quote;
  String author;

  Quotes({required this.id, required this.quote, required this.author});

  factory Quotes.fromMap(Map<String, dynamic> data) {
    return Quotes(id: data['id'], quote: data['quote'], author: data['author']);
  }
}
