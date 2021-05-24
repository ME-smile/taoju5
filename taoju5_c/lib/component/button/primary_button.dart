import 'package:flutter/material.dart';

enum PrimaryButtonSize { normal, large, big, middle, small, mini, custom }

enum PrimaryButtonMode {
  elevatedButton,
  outlinedButton,
  textButton,
  materialButton
}

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final PrimaryButtonSize size;
  final PrimaryButtonMode mode;
  final String text;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onPressed;
  final double radius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? fillColor;
  final BoxConstraints? constraints;
  PrimaryButton(
      {Key? key,
      this.size = PrimaryButtonSize.normal,
      this.mode = PrimaryButtonMode.elevatedButton,
      this.constraints,
      required this.text,
      this.margin,
      this.padding = EdgeInsets.zero,
      required this.onPressed,
      this.radius = 25,
      this.backgroundColor,
      this.foregroundColor,
      this.textStyle,
      this.fillColor = const Color(0xFFF5F5F5)})
      : assert((size != PrimaryButtonSize.custom) || (constraints == null),
            "please provide a concrete size for the button"),
        super(key: key) {
    _initSize();
    _initMargin();
    _initPadding();
    _initColor();
    _initStyle();
    _initButtonMode();
  }

  EdgeInsets? _margin;
  EdgeInsets? _padding;

  BoxConstraints? _constraints;

  Widget? _child;
  Color? _color;
  TextStyle? _textStyle;

  _initSize() {
    _constraints = constraints;
    if (size == PrimaryButtonSize.large || size == PrimaryButtonSize.big) {
      _constraints ??= BoxConstraints(minWidth: double.maxFinite);
    }

    if (size == PrimaryButtonSize.middle) {
      _constraints ??=
          BoxConstraints(minWidth: 110, minHeight: 38, maxHeight: 38);
    }
    if (size == PrimaryButtonSize.small) {
      _constraints ??= BoxConstraints(
          minWidth: 60, minHeight: 30, maxHeight: 30, maxWidth: 60);
      print("设置大小为最小");
    }
    _constraints ??= BoxConstraints(minWidth: 30, minHeight: 30);
  }

  _initMargin() {
    _margin = margin;

    if (size == PrimaryButtonSize.big) {
      _margin ??= EdgeInsets.symmetric(horizontal: 56);
    }
  }

  _initPadding() {
    if (size == PrimaryButtonSize.big || size == PrimaryButtonSize.large) {
      _padding = EdgeInsets.symmetric(vertical: 13);
    }
    if (size == PrimaryButtonSize.middle) {
      _padding = EdgeInsets.zero;
    }

    if (size == PrimaryButtonSize.small) {
      _padding = EdgeInsets.zero;
      print("设置内边距为0");
    }

    _padding ??= padding;
  }

  _initColor() {
    _color = backgroundColor ?? foregroundColor;
    if (mode == PrimaryButtonMode.materialButton) {
      _color ??= fillColor;
    }
  }

  _initStyle() {
    _textStyle = textStyle;
    if (mode == PrimaryButtonMode.materialButton) {
      _textStyle ??= TextStyle(color: const Color(0xFF666666));
    }
    if (size == PrimaryButtonSize.middle) {
      _textStyle = _textStyle?.copyWith(fontSize: 14);
    }
    if (size == PrimaryButtonSize.small) {
      _textStyle =
          _textStyle?.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
      print("设置字体大小");
    }
  }

  _initButtonMode() {
    _child = Text(text, style: _textStyle);

    switch (mode) {
      case PrimaryButtonMode.elevatedButton:
        {
          _child = ElevatedButton(
            onPressed: onPressed,
            child: _child,
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.all(padding),
              minimumSize: MaterialStateProperty.all(Size(48, 30)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
            ),
          );
          break;
        }
      case PrimaryButtonMode.outlinedButton:
        {
          _child = OutlinedButton(
            onPressed: onPressed,
            child: _child!,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(padding),
              minimumSize: MaterialStateProperty.all(Size(48, 30)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
            ),
          );
          break;
        }
      case PrimaryButtonMode.textButton:
        {
          _child = TextButton(
            onPressed: onPressed,
            child: _child!,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(padding),
              minimumSize: MaterialStateProperty.all(Size(48, 30)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
            ),
          );
          break;
        }
      case PrimaryButtonMode.materialButton:
        {
          _child = ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: RawMaterialButton(
              fillColor: _color,
              elevation: 0,
              focusElevation: 0,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightElevation: 0,
              hoverElevation: 0,
              disabledElevation: 0,
              onPressed: onPressed,
              child: Padding(
                padding: padding!,
                child: _child,
              ),
              constraints: _constraints!,
            ),
          );
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      constraints: _constraints,
      decoration: BoxDecoration(
          color: _color, borderRadius: BorderRadius.circular(radius)),
      child: _child,
    );
  }
}
