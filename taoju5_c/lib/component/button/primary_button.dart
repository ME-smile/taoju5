import 'package:flutter/material.dart';

enum PrimaryButtonSize { normal, large, big, middle, small, mini, custom }

enum PrimaryButtonMode {
  elevatedButton,
  outlinedButton,
  textButton,
  materialButton,
  inkwellButton
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
  final Color borderColor;
  PrimaryButton(
      {Key? key,
      this.size = PrimaryButtonSize.normal,
      this.mode = PrimaryButtonMode.elevatedButton,
      this.constraints,
      required this.text,
      this.margin,
      this.padding = EdgeInsets.zero,
      this.onPressed,
      this.radius = 25,
      this.backgroundColor,
      this.foregroundColor,
      this.textStyle,
      this.fillColor = const Color(0xFFF5F5F5),
      this.borderColor = const Color(0xFFB4B4B4)}) {
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
      _constraints ??=
          BoxConstraints(minWidth: double.maxFinite, minHeight: 45);
    }

    if (size == PrimaryButtonSize.middle) {
      _constraints ??=
          BoxConstraints(minWidth: 110, minHeight: 38, maxHeight: 38);
    }
    if (size == PrimaryButtonSize.small) {
      _constraints ??= BoxConstraints(
          minWidth: 60, minHeight: 30, maxHeight: 30, maxWidth: 60);
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
    if (mode == PrimaryButtonMode.inkwellButton) {
      _textStyle ??= TextStyle(fontSize: 13, color: const Color(0xFF333333));
    }
    if (size == PrimaryButtonSize.middle) {
      _textStyle = _textStyle?.copyWith(fontSize: 12);
    }
    if (size == PrimaryButtonSize.small) {
      _textStyle =
          _textStyle?.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
    }
  }

  _initButtonMode() {
    _child = Text(text, style: _textStyle);

    switch (mode) {
      case PrimaryButtonMode.elevatedButton:
        {
          _child = Container(
            constraints: constraints,
            child: ElevatedButton(
              onPressed: onPressed,
              child: _child,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(padding),
                minimumSize: MaterialStateProperty.all(Size(48, 30)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius))),
              ),
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
          _child = GestureDetector(
              onTap: onPressed,
              child: Container(
                  alignment: Alignment.center,
                  constraints: constraints,
                  padding: padding,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: _child));
          break;
        }

      case PrimaryButtonMode.inkwellButton:
        {
          _child = GestureDetector(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: borderColor)),
              padding: padding!,
              child: _child,
            ),
          );
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
