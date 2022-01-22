import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  // const NewTransaction({ Key? key }) : super(key: key);
  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
        titleController.text, double.parse(amountController.text),_selectedDate) ;
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) {
              //   amountInput = value;
              // },
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              color: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
      ),
    );
  }
}
