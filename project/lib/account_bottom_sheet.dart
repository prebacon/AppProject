import 'package:account_book/custom_text_field.dart';
import 'package:account_book/custom_drop_down.dart';
import 'package:account_book/colors.dart';
import 'package:flutter/material.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:account_book/drift_database.dart';

class AccountBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const AccountBottomSheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<AccountBottomSheet> createState() => _AccountBottomSheet();
}

class _AccountBottomSheet extends State<AccountBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? type;
  String? content;
  int? account;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          height: 250 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: bottomInset,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDown(
                        label: '분류',
                        typeList: ['수입', '지출'],
                        onSaved: (String? val) {
                          type = val;
                        },
                        validator: contentValidator,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomDropDown(
                        label: '내용',
                        typeList: ['소득', '세금', '생활비', '외식', '교통', '취미', '자기개발', '정보통신', '기타'],
                        onSaved: (String? val) {
                          content = val;
                        },
                        validator: contentValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: CustomTextField(
                    label: '금액',
                    onSaved: (String? val) {
                      account = int.parse(val!);
                    },
                    validator: accountValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSavePressed,
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text('저장'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState!.validate() == true) {
      formKey.currentState!.save();
    }
    await GetIt.I<LocalDatabase>().createAccount(
      AccountCompanion(
          type: Value(type!),
          content: Value(content!),
          price: Value(account!),
          date: Value(widget.selectedDate),
      ),
    );
    Navigator.of(context).pop();
    print(type);
    print(content);
    print(account);
  }

  String? accountValidator(String? val) {
    if (val == null) {
      return '값을 입력해주세요';
    }

    int? num;

    try {
      num = int.parse(val);
    } catch (e) {
      return '가격을 입력하세요';
    }

    return null;
  }

  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return '내용을 선택해주세요';
    }
    return null;
  }
}
