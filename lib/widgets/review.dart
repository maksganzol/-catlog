import 'package:catalog/entities/product.dart';
import 'package:catalog/widgets/rate.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final Comment comment;

  const Review({Key? key, required this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[400] ?? Colors.grey),
        ),
        // borderRadius: BorderRadius.circular(10),
      ),
      width: 500,
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          Text(
            comment.creator.username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Rate(initial: comment.rate, max: 5),
          Text(comment.content)
        ],
      ),
    );
  }
}
