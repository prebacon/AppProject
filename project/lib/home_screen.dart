import 'package:flutter/material.dart';
import 'package:account_book/main_calendar.dart';
import 'package:account_book/account_card.dart';
import 'package:account_book/today_banner.dart';
import 'package:account_book/account_bottom_sheet.dart';
import 'package:account_book/colors.dart';
import 'package:account_book/monthly_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => AccountBottomSheet(),
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //선택 날짜
            //SizedBox(height: 0.0),
            TodayBanner(
              selectedDate: selectedDate,
              count: 0,
            ),
            //달력
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),

            MonthlyAccount(
                monthlyExpenses: 12000,
                monthlyIncome: 100000,
                incometype: '월 수입',
                expensestype: '월 지출'),

            //수입, 지출 확인
            AccountCard(
              type: '지출',
              content: '식사',
              typecolor: Colors.red,
              account: 12000,
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
