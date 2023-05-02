import 'package:expence_man/modules/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key}) : super(key: key);
  // const MyHomePage({Key? key}) : super(key: key);
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController=TextEditingController();
  final ammountController=TextEditingController();

  List<Transaction> transaction=[
    Transaction(id:'t1', title: 'Goa trip', amount: 30000, date: DateTime.now()),
    Transaction(id:'t2', title: 'Kedarnath trip', amount: 50000, date: DateTime.now()),
  ];
  _addTransaction(String title,double amount){
    print(title);
    print(amount);

    var tra=Transaction(id: 't3', title: title, amount: amount, date: DateTime.now());
    setState(() {
      transaction.add(tra);
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length <= 3) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.drive_file_rename_outline),
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                  // focusColor: Colors.white
                ),
                autofillHints: Characters('Title'),
                keyboardType: TextInputType.name,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(30),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  else {
                    return null;
                  }
                },
                controller: ammountController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee),
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder(),
                    focusColor: Colors.white),
                autofillHints: Characters('Enter Amount'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){}
                  print(titleController.text);
                  print(ammountController.text);
                  _addTransaction(titleController.text, double.parse(ammountController.text));
                  titleController.clear();
                  ammountController.clear();
                  // ClearSelectionEvent(ClearSelectionEvent())
                },
                child: Text('Signup page'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAAAAAAB)
                )),
            Expanded(
              child: ListView.builder(
                itemCount: transaction.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      title: Text('${transaction[index].title}'),
                      leading: Text('${transaction[index].id}'),
                      subtitle: Text(DateFormat('dd-MM-yyyy').format(transaction[index].date)),
                      trailing: Text('${transaction[index].amount}'),
                    );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
