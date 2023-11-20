import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, {required String data}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}
