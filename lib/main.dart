import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = new ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(secondary: Colors.amber),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Gaming Console',
      amount: 500.96,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Weekly Groceries',
      amount: 20.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't6',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't7',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't8',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't9',
      title: 'Weekly Groceries',
      amount: 200.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime dateTime) {
    final newTx = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: dateTime,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (bCtx) {
        return GestureDetector(
          child: NewTransaction(_addTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(
              transactions: _userTransactions,
              deleteTransaction: _deleteTransaction,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
