import 'package:flutter/material.dart';
import 'package:account_book/colors.dart';
import 'package:account_book/monthly_account_sheet.dart';

class _IncomeType extends StatelessWidget {
  final String type;

  const _IncomeType({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.green,
      fontSize: 16.0,
    );
    return Text(
      type,
      style: textStyle,
    );
  }
}

class _ExpensesType extends StatelessWidget {
  final String type;

  const _ExpensesType({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.red,
      fontSize: 16.0,
    );
    return Text(
      type,
      style: textStyle,
    );
  }
}

class _Content extends StatelessWidget {
  final int content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        '${content}원',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class MonthlyAccount extends StatefulWidget {
  final int monthlyExpenses;
  final int monthlyIncome;
  final String incometype;
  final String expensestype;
  final DateTime date;

  const MonthlyAccount({
    required this.monthlyExpenses,
    required this.monthlyIncome,
    required this.incometype,
    required this.expensestype,
    required this.date,
    Key? key,
  }) : super(key: key);

  State<MonthlyAccount> createState() => _MonthlyAccount();
}

class _MonthlyAccount extends State<MonthlyAccount> {

  @override
  Widget build(BuildContext context) {
    int monthlyExpenses = widget.monthlyExpenses;
    int monthlyIncome = widget.monthlyIncome;
    String incometype = widget.incometype;
    String expensestype = widget.expensestype;
    DateTime date = widget.date;
    return TextButton(
      onPressed: () {
        showModalBottomSheet(context: context,
          isDismissible: true,
          builder: (_) => MonthlyAccountSheet(dateTime: date,),
          isScrollControlled: true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: PRIMARY_COLOR,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _IncomeType(
                      type: incometype,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    _Content(
                      content: monthlyIncome,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 1,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    _ExpensesType(
                      type: expensestype,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    _Content(
                      content: monthlyExpenses,
                    ),
                    SizedBox(
                      width: 8.0,
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
