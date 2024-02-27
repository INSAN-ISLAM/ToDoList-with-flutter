import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Style.dart';

class ToDoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ToDoPageView();
  }
}

class ToDoPageView extends State<ToDoPage> {
  List ToDoList = [];
  String item = "";
  String text = "";

  MyInputOnChange(content) {
    setState(() {
      item = content;
    });
  }

  AddItem() {
    setState(() {
      ToDoList.add({'item': item});
    });
  }

  MySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  MyAlertDialog(index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: Text("Alert !"),
            content: Text("Do you want to delete"),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      ToDoList.removeAt(index);
                    });
                    MySnackBar("Delete Success", context);
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          ));
        });
  }

  MyAletDialog(index) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Edit Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    }),
              ),
              Container(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ToDoList[index]['item'] = text;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("update")),
                ),
              ),
            ]));
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = ToDoList;
    } else {
      results = ToDoList.where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      ToDoList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                        flex: 60,
                        child: TextFormField(
                          onChanged: (content) {
                            MyInputOnChange(content);
                          },
                          decoration: AppInputDecoration("List Item"),
                        )),
                    Expanded(
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              AddItem();
                            },
                            child: Text('Add'),
                            style: AppButtonStyle(),
                          ),
                        )),
                    Expanded(
                        flex: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            // onChanged: (content) => MyInputOnChange(content),
                            onChanged: (value) => _runFilter(value),
                            decoration: ApInputDecoration("Search Item"),
                          ),
                        )),
                  ],
                )),
            Expanded(
                flex: 90,
                child: ListView.builder(
                    itemCount: ToDoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: SizeBox50(Row(
                        children: [
                          Expanded(
                              flex: 80,
                              child: Text(ToDoList[index]['item'].toString())),
                          Expanded(
                              flex: 10,
                              child: TextButton(
                                  onPressed: () {
                                    MyAletDialog(index);
                                  },
                                  child: Icon(Icons.edit))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                                flex: 10,
                                child: TextButton(
                                    onPressed: () {
                                      MyAlertDialog(index);
                                    },
                                    child: Icon(Icons.delete))),
                          ),
                        ],
                      )));
                    })),
          ],
        ),
      ),
    );
  }
}
