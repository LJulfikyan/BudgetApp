import 'package:flutter/material.dart';
import 'package:kyla_test/utilities.dart';

class Expenditure {
  late final ExpenditureType? type;
  final double amount;
  final String? address;
  final String? name;
  final TimeOfDay time;

  Expenditure({
    this.type = ExpenditureType.undefined,
    required this.amount,
    required this.address,
    required this.name,
    required this.time,
  });
}
