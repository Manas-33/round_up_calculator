import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_up_calculator/constants.dart';
import 'package:round_up_calculator/controllers/transaction_provider.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  var uid = fireAuth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Consumer<TransactionProvider>(builder: (context, provider, _) {
                  return Expanded(
                    child: FutureBuilder<dynamic>(
                      future: provider.getTransactions(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data![index]['type'] ?? ""),
                                      Row(
                                        children: [
                                          Text("Saved :  "),
                                          Text(
                                              "₹${snapshot.data![index]['roundUp']}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Amount Spent : "),
                                          Text(
                                            "₹${snapshot.data![index]['amount']}",
                                            style: TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      ),
                                      Text(timeAgo.format(snapshot.data![index]
                                              ['timeOfTransaction']
                                          .toDate())),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
