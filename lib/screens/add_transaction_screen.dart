import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  final int? index;
  final TransactionModel? transaction;

  // ✅ CONSTRUCTOR (FIX ERROR HERE)
  AddTransactionScreen({this.index, this.transaction});

  @override
  _AddTransactionScreenState createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();

  bool isIncome = false;

  @override
  void initState() {
    super.initState();

    // ✅ PREFILL DATA FOR EDIT
    if (widget.transaction != null) {
      title.text = widget.transaction!.title;
      amount.text = widget.transaction!.amount.toString();
      isIncome = widget.transaction!.isIncome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<TransactionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transaction == null
              ? "Add Transaction"
              : "Edit Transaction",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
            ),

            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text("Expense"),
                  selected: !isIncome,
                  onSelected: (_) {
                    setState(() => isIncome = false);
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text("Income"),
                  selected: isIncome,
                  onSelected: (_) {
                    setState(() => isIncome = true);
                  },
                ),
              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                if (title.text.isEmpty || amount.text.isEmpty) return;

                if (widget.transaction == null) {
                  // ✅ ADD NEW
                  provider.addTransaction(
                    title.text,
                    double.parse(amount.text),
                    isIncome,
                  );
                } else {
                  // ✅ UPDATE EXISTING
                  provider.updateTransaction(
                    widget.index!,
                    title.text,
                    double.parse(amount.text),
                    isIncome,
                  );
                }

                Navigator.pop(context);
              },
              child: Text(
                widget.transaction == null ? "Save" : "Update",
              ),
            )
          ],
        ),
      ),
    );
  }
}
