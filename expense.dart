import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ExpenseTrackerApp());

class Expense {
  final String title;
  final double amount;
  final DateTime date;

  Expense({required this.title, required this.amount, required this.date});
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatefulWidget {
  @override
  _ExpenseHomePageState createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final List<Expense> _expenses = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _addExpense() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    setState(() {
      _expenses.add(Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: DateTime.now(),
      ));
    });

    _titleController.clear();
    _amountController.clear();
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: _addExpense,
                  child: Text('Add Expense'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _expenses.isEmpty
                ? Center(child: Text('No expenses added yet!'))
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (ctx, index) {
                      final exp = _expenses[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(exp.title),
                          subtitle: Text(DateFormat.yMMMd().format(exp.date)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('\₹${exp.amount.toStringAsFixed(2)}'),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteExpense(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
