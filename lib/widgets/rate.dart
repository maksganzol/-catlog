import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final int initial, max;
  final Function(int)? onChanged;

  const Rate({
    Key? key,
    required this.initial,
    required this.max,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(max, (i) {
        final star = i < initial ? Icons.star : Icons.star_border;
        return SizedBox(
          width: 20,
          height: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onChanged != null ? () => onChanged!(i + 1) : null,
            icon: Icon(
              star,
              color: Colors.blue[400],
              size: 15,
            ),
          ),
        );
      }),
    );
  }
}
