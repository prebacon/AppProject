import 'package:account_book/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: TextStyle(
          color: PRIMARY_COLOR,
          fontWeight: FontWeight.w600,
        ),
      ),
      Expanded(
        flex: 0,
        child: TextFormField(
          cursorColor: Colors.grey,
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            suffixText:'원',
          ),
        ),
      ),
    ]);
  }
}
