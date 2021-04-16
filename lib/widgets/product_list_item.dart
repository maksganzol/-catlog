import 'package:flutter/cupertino.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final Image logo;

  const ProductListItem({
    Key? key,
    required this.title,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 30),
            child: ClipRRect(
              child: logo,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
