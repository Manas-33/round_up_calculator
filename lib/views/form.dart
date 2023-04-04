// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'package:round_up_calculator/constants.dart';
import 'package:round_up_calculator/controllers/transaction_provider.dart';

class TransactionForm extends StatefulWidget {
  int roundUpValue;
  TransactionForm({
    Key? key,
    required this.roundUpValue,
  }) : super(key: key);
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController = TextEditingController();
  String _selectedTransactionType = 'Withdrawal';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int roundUp =
          _roundUp(widget.roundUpValue, int.parse(_amountController.text));
      final provider = Provider.of<TransactionProvider>(context, listen: false);
      provider.submitTransaction(
          _selectedTransactionType, int.parse(_amountController.text), roundUp);
    }
  }

  _roundUp(int roundUpValue, int amount) {
    try {
      int roundedNumber =
          ((amount + roundUpValue - 1) ~/ roundUpValue) * roundUpValue;
      return (roundedNumber - amount);
    } catch (e) {
      // return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: BackButton(
          color: secondaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondary),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Transaction Type",
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondary),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  value: _selectedTransactionType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTransactionType = newValue!;
                    });
                  },
                  items: <String>[
                    'Deposit',
                    'Withdrawal',
                    'Lump-sum',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Investment is : ', style: TextStyle(fontSize: 20)),
                    if (_amountController.text != "")
                      Text(
                          '₹${_roundUp(widget.roundUpValue, int.parse(_amountController.text))}',
                          style: TextStyle(fontSize: 20, color: Colors.green))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: _submitForm,
                    child:
                        const Text("Submit", style: TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
