import 'package:catalog/widgets/rate.dart';
import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  final Function(String, int) onSubmit;

  const ReviewDialog({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ReviewDialogState();
}

class ReviewDialogState extends State<ReviewDialog> {
  int _rate = 3;
  final contentController = TextEditingController();

  _applyRate(int rate) => setState(() => _rate = rate);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(color: Colors.red[200]),
          ),
        ),
        TextButton(
          onPressed: () async {
            await widget.onSubmit(contentController.text, _rate);
            Navigator.of(context).pop();
          },
          child: Text(
            'Submit',
          ),
        ),
      ],
      content: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: [
          Text('Leave review'),
          Rate(
            initial: _rate,
            max: 5,
            onChanged: _applyRate,
          ),
          TextFormField(
            controller: contentController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Your review',
            ),
            minLines: 2,
            maxLines: 15,
          ),
        ],
      ),
    );
  }
}
