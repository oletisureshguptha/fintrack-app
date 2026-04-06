import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  double _goalAmount = 5000;

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(String title, double amount, bool isIncome) {
    _transactions.add(TransactionModel(title, amount, isIncome));
    notifyListeners();
  }

  void deleteTransaction(int index) {
    _transactions.removeAt(index);
    notifyListeners();
  }

  void updateTransaction(int index, String title, double amount, bool isIncome) {
    _transactions[index] = TransactionModel(title, amount, isIncome);
    notifyListeners();
  }

  double get totalIncome => _transactions
      .where((t) => t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => !t.isIncome)
      .fold(0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;

  double get goalAmount => _goalAmount;

  void setGoal(double amount) {
    _goalAmount = amount;
    notifyListeners();
  }

  double get savedAmount => balance;

  double get progress =>
      _goalAmount == 0 ? 0 : (savedAmount / _goalAmount).clamp(0, 1);
}
