import 'package:account_book/colors.dart';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:account_book/drift_database.dart';

class _Form extends StatelessWidget {
  final String type;
  final String content;
  final DateTime dateTime;

  const _Form({
    required this.type,
    required this.content,
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = dateTime;

    return Row(
      children: [
        Text(
          content,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: StreamBuilder<List<AccountData>>(
            stream: GetIt.I<LocalDatabase>().watchMAccount(selectedDate),
            builder: (context, snapshot) {
              final monthlySalary = snapshot.data
                      ?.where((account) =>
                          account.type == type && account.content == content)
                      .map((account) => account.price)
                      .fold<int>(
                          0, (previousValue, price) => previousValue + price) ??
                  0;
              print(selectedDate);
              return Text(
                '$monthlySalary원',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MonthlyAccountSheet extends StatefulWidget {
  final DateTime dateTime;

  const MonthlyAccountSheet({
    required this.dateTime,
    Key? key
  }) : super(key: key);

  @override
  State<MonthlyAccountSheet> createState() => _MonthlyAccountSheet();
}

class _MonthlyAccountSheet extends State<MonthlyAccountSheet> {


  @override
  Widget build(BuildContext context) {
    //final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    DateTime selectedDate = widget.dateTime;
    print(selectedDate);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 3 * 2,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: 8,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: PRIMARY_COLOR,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '이번달 상세 가계부',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '상세 월 수입',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _Form(
                      type: '수입',
                      content: '소득',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '수입',
                      content: '기타',
                      dateTime: selectedDate,
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.black,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '상세 월 지출',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //'세금', '생활비', '외식', '교통', '취미', '자기개발', '정보통신', '기타'
                    _Form(
                      type: '지출',
                      content: '세금',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '생활비',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '외식',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '교통',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '취미',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '자기개발',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '정보통신',
                      dateTime: selectedDate,
                    ),
                    _Form(
                      type: '지출',
                      content: '기타',
                      dateTime: selectedDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
