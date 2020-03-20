import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'models/transaction.dart';

main() => runApp(ExpensesApp()); // Starting my App

//class main my App
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
    );
  }
}

//Home page my App
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Transaction> _transactions = [
     Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions = [..._transactions, newTransaction];
    });

    Navigator.of(context).pop();
  }

  _openTransactionForm(BuildContext context) {

    showModalBottomSheet(context: context, builder: (_) {

      return  TransactionForm(addTransaction: _addTransaction);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionForm(context)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                child: Text('Grafico'),
                elevation: 5,
              ),
            ),
                TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
