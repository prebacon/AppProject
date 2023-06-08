import 'package:account_book/custom_text_field.dart';
import 'package:account_book/custom_drop_down.dart';
import 'package:account_book/colors.dart';
import 'package:flutter/material.dart';

class AccountBottomSheet extends StatefulWidget {
  const AccountBottomSheet({Key? key}) : super(key: key);

  @override
  State<AccountBottomSheet> createState() => _AccountBottomSheet();
}

class _AccountBottomSheet extends State<AccountBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
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
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: CustomDropDown(
                      label: '내용',
                      typeList: ['월급', '용돈', '식사', '교통', '취미', '유흥', '기타'],
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
    );
  }

  void onSavePressed() {}
}
