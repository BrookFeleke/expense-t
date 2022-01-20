import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/user_transactions.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses ',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green.shade600,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                  .bodyText2,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                  .headline6)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;

  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Unlimited Package',
      amount: 700,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Charger',
      amount: 400,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)  )) ;
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green.shade800,
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                _startAddNewTransaction(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Chart(),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.green.shade500,
        child: Icon(Icons.add, color: Colors.green.shade100,),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
