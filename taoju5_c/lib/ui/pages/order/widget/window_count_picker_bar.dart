/*
 * @Description: 意向上门量尺时间选择
 * @Author: iamsmiling
 * @Date: 2021-05-06 14:55:46
 * @LastEditTime: 2021-05-07 16:39:31
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taoju5_c/component/button/primary_button.dart';
import 'package:taoju5_c/component/textfield/readonly_text_form_field.dart';
import 'package:taoju5_c/res/R.dart';

class WindowCountPickerBar extends StatefulWidget {
  final Function(String?)? onValueChanged;
  WindowCountPickerBar({Key? key, this.onValueChanged}) : super(key: key);

  @override
  _WindowCountPickerBarState createState() => _WindowCountPickerBarState();
}

class _WindowCountPickerBarState extends State<WindowCountPickerBar> {
  String? _value;

  void _select() {
    _showWindowCountPicker(context).then((value) {
      setState(() {
        _value = value;
      });
      if (widget.onValueChanged != null) {
        widget.onValueChanged!(_value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: R.dimen.dp10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "测量窗数",
            style: TextStyle(fontSize: R.dimen.sp14, color: R.color.ff181818),
          ),
          Expanded(
            child: ReadOnlyTextFormField(
                hintText: "请选择测量窗数",
                key: ValueKey(_value),
                initialValue: _value,
                onTap: _select),
          ),
        ],
      ),
    );
  }
}

Future<String?> _showWindowCountPicker(BuildContext context) {
  return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: R.dimen.dp48),
          child: _WindowCountPickerView(),
        );
      });
}

class _WindowCountPickerView extends StatefulWidget {
  _WindowCountPickerView({Key? key}) : super(key: key);

  @override
  __WindowCountPickerViewState createState() => __WindowCountPickerViewState();
}

class __WindowCountPickerViewState extends State<_WindowCountPickerView> {
  List<String> options = List.generate(9, (index) => "${index + 1}") + ["10+"];
  String? currentOption = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 128,
            margin: EdgeInsets.only(bottom: R.dimen.dp20),
            child: CupertinoPicker.builder(
                itemExtent: 30,
                onSelectedItemChanged: (int i) {
                  currentOption = options[i];
                },
                childCount: options.length,
                itemBuilder: (BuildContext context, int i) {
                  return Center(
                    child: Text(
                      options[i] + "窗",
                      style: TextStyle(
                          fontSize: R.dimen.sp15,
                          color: R.color.ff1b1b1b,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: R.dimen.dp20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  text: "取消",
                  onPressed: Navigator.of(context).pop,
                  mode: PrimaryButtonMode.materialButton,
                  size: PrimaryButtonSize.middle,
                ),
                PrimaryButton(
                  text: "确定",
                  margin: EdgeInsets.only(left: R.dimen.dp10),
                  onPressed: () => Navigator.of(context).pop(currentOption),
                  mode: PrimaryButtonMode.elevatedButton,
                  size: PrimaryButtonSize.middle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}