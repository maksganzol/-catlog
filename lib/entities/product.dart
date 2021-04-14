class Comment {
  final String id;
  final int rate;
  final String content;

  Comment({
    this.id,
    this.rate,
    this.content,
  });

  static Comment fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      content: map['text'],
      rate: map['rate'],
    );
  }
}

class Product {
  final String id;
  final String img;
  final String decription;
  final String title;

  final List<Comment> comments;

  Product({
    this.id,
    this.img,
    this.decription,
    this.title,
    this.comments = const [],
  });

  static Product fromMap(Map<String, dynamic> map) {
    final comments = map['comments'] ?? [];

    return Product(
      id: map['id'],
      img: map['img'],
      decription: map['text'],
      title: map['title'],
      comments: comments.map(Comment.fromMap),
    );
  }
}
