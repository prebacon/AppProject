import 'package:flutter/material.dart';
import 'package:account_book/main_calendar.dart';
import 'package:account_book/account_card.dart';
import 'package:account_book/today_banner.dart';
import 'package:account_book/account_bottom_sheet.dart';
import 'package:account_book/colors.dart';
import 'package:account_book/monthly_account.dart';

import 'package:get_it/get_it.dart';
import 'package:account_book/drift_database.dart';

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
    print(selectedDate);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => AccountBottomSheet(
              selectedDate: selectedDate,
            ),
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
            StreamBuilder<List<AccountData>>(
              stream: GetIt.I<LocalDatabase>().watchAccount(selectedDate),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.length ?? 0,
                );
              },
            ),
            //달력
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),

            StreamBuilder<List<AccountData>>(
              stream: GetIt.I<LocalDatabase>().watchMAccount(selectedDate),
              builder: (context, snapshot) {
                final monthlyExpenses = snapshot.data
                        ?.where((account) => account.type == '지출')
                        .map((account) => account.price)
                        .fold<int>(0, (previousValue, price) => previousValue + price) ?? 0;

                final monthlyIncomes = snapshot.data
                        ?.where((account) => account.type == '수입')
                        .map((account) => account.price)
                        .fold<int>(0,
                        (previousValue, price) => previousValue + price) ?? 0;

                return MonthlyAccount(
                  monthlyExpenses: monthlyExpenses,
                  monthlyIncome: monthlyIncomes,
                  incometype: '월 수입',
                  expensestype: '월 지출',
                  date: selectedDate,
                );

              },
            ),
            //수입, 지출 확인
            Expanded(
              child: StreamBuilder<List<AccountData>>(
                stream: GetIt.I<LocalDatabase>().watchAccount(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final account = snapshot.data![index];
                      return Dismissible(
                        key: ObjectKey(account.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeAccount(account.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: AccountCard(
                            type: account.type,
                            typecolor: account.type == '수입'
                                ? Colors.green
                                : Colors.red,
                            content: account.content,
                            account: account.price,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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
