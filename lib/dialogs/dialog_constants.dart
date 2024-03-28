import 'package:flutter/material.dart';

const dialogCornerRadius = 12.0;
const dialogPadding = 32.0;
const dialogBoxCornerRadius = 2.0;
const dialogBoxTopPadding = 16.0;
const dialogSpacing = 32.0;
const dialogWidth = 500.0;
const buttonSpacing = 8.0;
const errorDialogWidth = 200.0;
const iconSpacing = 8.0;

const g2 = Color(0xFFBBBBBB);

final dialogBoxBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(dialogBoxCornerRadius),
  borderSide: const BorderSide(color: g2),
);

final dialogShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(dialogCornerRadius),
);

const titleTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const subtitleTextStyle = TextStyle(
  fontSize: 18.0,
);
