import 'package:flutter/material.dart';
import 'package:account_book/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}