import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class GoalsScreen extends StatelessWidget {
  final TextEditingController goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Goals")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Set Monthly Goal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            TextField(
              controller: goalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter goal amount",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if (goalController.text.isEmpty) return;

                provider.setGoal(
                    double.parse(goalController.text));

                goalController.clear();
              },
              child: Text("Set Goal"),
            ),

            SizedBox(height: 30),

            // 🔥 PROGRESS CARD
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Goal: ₹${provider.goalAmount}",
                      style: TextStyle(fontSize: 16)),

                  SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: provider.progress,
                    minHeight: 10,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Saved: ₹${provider.savedAmount}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "${(provider.progress * 100).toStringAsFixed(0)}% completed",
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Text(
              provider.progress >= 1
                  ? "🎉 Goal Achieved!"
                  : "Keep saving! You're on track 💪",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
