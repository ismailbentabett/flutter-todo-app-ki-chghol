import 'package:flutter/material.dart';
import './todo_class.dart';

void main() => runApp(MaterialApp(
      home: App(),
      theme: ThemeData.dark(),
    ));

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

TextEditingController titlefield = new TextEditingController();
TextEditingController contentfield = new TextEditingController();

class _AppState extends State<App> {
  Future<void> _showMyEditDialog(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit a Todo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titlefield,
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: contentfield,
                  decoration: InputDecoration(
                    labelText: 'info',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Edit'),
              onPressed: () {
                editTodo(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('add a Todo'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titlefield,
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: contentfield,
                  decoration: InputDecoration(
                    labelText: 'info',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                addaTodo();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List fixedLengthList = [];

  var icondone = Icons.done;

  void addaTodo() {
    String titlestr = titlefield.text.toString();
    String contentstring = contentfield.text.toString();

    fixedLengthList.add(Todo(titlestr, contentstring));
    print(fixedLengthList[0].title);
  }

  void editTodo(index) {
    String titlestr = titlefield.text.toString();
    String contentstring = contentfield.text.toString();
    print(fixedLengthList[index].title);
    print(fixedLengthList[index].info);
    fixedLengthList[index].title = titlestr;
    fixedLengthList[index].info = contentstring;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo app ya lfruity'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _showMyDialog();
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              for (var i = 0; i < fixedLengthList.length; i++)
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.sentiment_satisfied),
                        title: Text(fixedLengthList[i].title),
                        subtitle: Text(fixedLengthList[i].info),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Icon(icondone),
                            onPressed: () {
                              setState(() {
                                icondone = Icons.done_all;
                              });
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.edit),
                            onPressed: () {
                              int iTa3ha = i;

                              setState(() {
                                _showMyEditDialog(iTa3ha);
                              });
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                int iTa3ha = i;

                                fixedLengthList.removeAt(iTa3ha);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showMyDialog();
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
