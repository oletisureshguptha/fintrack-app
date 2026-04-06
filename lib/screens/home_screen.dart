import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_card.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.bgGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [

              // 🔝 TOP BAR
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      },
                    )
                  ],
                ),
              ),

              // 💰 BALANCE CARD
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GlassCard(
                  child: Column(
                    children: [
                      Text("Total Balance",
                          style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 8),
                      Text(
                        "₹${provider.balance}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              // 📊 INCOME / EXPENSE
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GlassCard(
                        child: Column(
                          children: [
                            Text("Income",
                                style: TextStyle(color: Colors.white70)),
                            Text(
                              "₹${provider.totalIncome}",
                              style: TextStyle(
                                  color: AppColors.income,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GlassCard(
                        child: Column(
                          children: [
                            Text("Expense",
                                style: TextStyle(color: Colors.white70)),
                            Text(
                              "₹${provider.totalExpense}",
                              style: TextStyle(
                                  color: AppColors.expense,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // 📋 TRANSACTIONS
              Expanded(
                child: ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: (context, index) {
                    final tx = provider.transactions[index];

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: GlassCard(
                        child: ListTile(
                          title: Text(tx.title,
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("₹${tx.amount}",
                              style: TextStyle(color: Colors.white70)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              // ✏️ EDIT
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AddTransactionScreen(
                                        index: index,
                                        transaction: tx,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // 🗑 DELETE
                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  provider.deleteTransaction(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ➕ FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTransactionScreen()),
          );
        },
      ),
    );
  }
}
