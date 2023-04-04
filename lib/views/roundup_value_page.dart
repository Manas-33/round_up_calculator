import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_up_calculator/views/transaction_form.dart';

import '../constants.dart';
import '../controllers/transaction_provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int _selectedValue = 10;
  List<int> _values = List<int>.generate(10, (index) => (index + 1) * 10);
  var uid = fireAuth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total Money Invested : ", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              Consumer<TransactionProvider>(
                builder: (context, transactionProvider, _) {
                  return FutureBuilder<int>(
                    future: transactionProvider.getTotal(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          '₹${snapshot.data}',
                          style: TextStyle(color: Colors.green, fontSize: 50),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButtonFormField<int>(
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
                  value: _selectedValue,
                  items: _values.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        '$value',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedValue = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Selected Round Up value is : $_selectedValue',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 35),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TransactionForm(
                              roundUpValue: _selectedValue,
                            )));
                  },
                  child: const Text("Enter Transaction Details",
                      style: TextStyle(fontSize: 16))),
            ],
          ),
        ),
      ),
    );
  }
}
