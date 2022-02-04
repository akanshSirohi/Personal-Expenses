import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) callback;

  NewTransaction(this.callback);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountController.text.isNotEmpty) {
      final title = _titleController.text;
      final amt = double.parse(_amountController.text);
      if (title.isNotEmpty && amt > 0 && _selectedDate != null) {
        widget.callback(title, amt, (_selectedDate as DateTime));
        Navigator.of(context).pop();
      }
    }
  }

  void _showDPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    }).catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: _amountController,
            keyboardType: Theme.of(context).platform == TargetPlatform.android
                ? TextInputType.number
                : TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : "Picked Date: ${DateFormat.yMMMd().format((_selectedDate as DateTime))}",
                  ),
                ),
                OutlinedButton(
                  onPressed: () => _showDPicker(),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text("Add Transaction"),
          )
        ],
      ),
    );
  }
}
