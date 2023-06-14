import 'package:account_book/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropDown extends StatefulWidget {
  final String label;
  final typeList;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const CustomDropDown({
    required this.label,
    required this.typeList,
    required this.onSaved,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropDown createState() => _CustomDropDown();
}

class _CustomDropDown extends State<CustomDropDown> {

  // _contentList = ['식사', '교통', '취미', '유흥'];
  String? _typeListValue;
  @override
  Widget build(BuildContext context) {
    final List<String> _typeList = widget.typeList;

    String label = widget.label;
    FormFieldSetter<String> onSaved = widget.onSaved;
    FormFieldValidator<String> validator = widget.validator;

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
        child: DropdownButtonFormField(
          validator: validator,
          onSaved: onSaved,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0
          ),
          hint: Text('선택해주세요'),
          value: _typeListValue,
          items: _typeList.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              _typeListValue = value;
            });
          },
        ),
      ),
    ]);
  }
}
