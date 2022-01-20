import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  // const TransactionList({ Key? key }) : super(key: key);
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text('No Transactions Yet'),
                  SizedBox(height: 10),
                  Container(
                      height: 150,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColorLight,
                                  width: 2),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(transactions[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transactions[index].date),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
