import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Insights")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            _card("Total Income", p.totalIncome, Colors.green),
            _card("Total Expense", p.totalExpense, Colors.red),
            _card("Balance", p.balance, Colors.blue),

            SizedBox(height: 20),

            // 🔥 PROGRESS VISUAL
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurpleAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text("Spending Ratio",
                      style: TextStyle(color: Colors.white)),

                  SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: p.totalExpense == 0
                        ? 0
                        : (p.totalExpense /
                                (p.totalIncome + p.totalExpense))
                            .clamp(0, 1),
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Expense vs Income",
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _card(String title, double value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Text("₹$value",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
