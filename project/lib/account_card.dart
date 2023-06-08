import 'package:account_book/colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class _Type extends StatelessWidget {
  final String type;
  final Color typecolor;

  const _Type({
    required this.type,
    required this.typecolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: typecolor,
      fontSize: 16.0,
    );
    return Text(
      type,
      style: textStyle,
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: 16.0,
    );
    return Text(
      content,
      style: textStyle,
    );
  }
}

class _Account extends StatelessWidget {
  final int account;

  const _Account({
    required this.account,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        '${account}원',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final int account;
  final String type;
  final String content;
  final Color typecolor;

  const AccountCard({
    required this.account,
    required this.type,
    required this.content,
    required this.typecolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Type(
                type: type,
                typecolor: typecolor,
              ),
              SizedBox(
                width: 16.0,
              ),
              _Content(
                content: content,
              ),
              SizedBox(
                width: 16.0,
              ),
              _Account(
                account: account,
              ),
              SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
