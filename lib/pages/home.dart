import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required Key key}) : super(key: key);
    @override
    Widget build(BuildContext context){
      return Container();
    }
    @override
    State<Home> createState() => HomeState();
}

class HomeState extends State<Home>{
  late String guiString;
  List list = [];
  @override
  void initState() {
    super.initState();
    list.addAll(['Drink at morning','Drink at day','Drink at evening']);
  }

  void openMenu(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Menu'),),
        body: Row(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }, child: const Text('Home')),
            const Padding(padding: EdgeInsets.only(left: 15)),
          ],
        ),
      );
    }));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: const Text('Drink list'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            openMenu();
          }, icon: const Icon(Icons.menu)),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: Key(list[index]),
              child: Card(
                child: ListTile(
                  title: Text(list[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_sweep),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() {
                        list.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
              onDismissed: (direction) {
                if(direction == DismissDirection.startToEnd) {
                  setState(() {
                    list.removeAt(index);
                  });
                }
              },
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Add element'),
              content: TextField(
                onChanged: (String string) {
                    guiString = string;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    list.add(guiString);
                  });
                  Navigator.of(context).pop();
                }, child: const Text('Add'))
              ],
            );
          });
        },
        tooltip: ('Add task'),
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}