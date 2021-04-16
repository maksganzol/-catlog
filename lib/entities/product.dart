class Creator {
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;

  Creator({
    required this.username,
    this.firstName,
    this.lastName,
    this.email,
  });

  static Creator fromMap(Map<String, dynamic> map) {
    return Creator(
      username: map['username'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
    );
  }
}

class Comment {
  final int rate;
  final String content;
  final Creator creator;

  Comment({
    required this.creator,
    required this.rate,
    required this.content,
  });

  static Comment fromMap(Map<String, dynamic> map) {
    final creator = map['created_by'];
    return Comment(
      content: map['text'],
      rate: map['rate'],
      creator: Creator.fromMap(creator),
    );
  }
}

class Product {
  final int id;
  final String img;
  final String decription;
  final String title;

  List<Comment> comments;

  Product({
    required this.id,
    required this.img,
    required this.decription,
    required this.title,
    this.comments = const [],
  });

  static Product fromMap(Map<String, dynamic> map) {
    final comments = map['comments'] ?? [];
    return Product(
      id: map['id'],
      img: map['img'],
      decription: map['text'],
      title: map['title'],
      comments: List.from(comments)
          .cast<Map<String, dynamic>>()
          .map(Comment.fromMap)
          .toList(),
    );
  }
}
