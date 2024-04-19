

import "package:flutter/material.dart";
import "package:flutter_todo_app/constants/colors.dart";
import "package:flutter_todo_app/model/todo.dart";
import "package:flutter_todo_app/widgets/todo_item.dart";

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => HomeState();
}
class HomeState extends State<Home> {

  List<ToDo> foundToDo = [];
  final todosList = ToDo.todoList();
  final todoController = TextEditingController();

  @override
  void initState() {
    foundToDo = todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      backgroundColor: tdBGColor,
      appBar:  buildAppBar(),
      body: Stack(
        children: [
          Container( 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child:  Column( 
              children: [
                searchBox(),
                Expanded(
                  child: ListView( 
                    children: [ 
                      Container ( 
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text("To-Do List", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500,))
                      ),
                      for (ToDo todoo in foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: deleteToDoItem,
                        ),
                  
                    ],
                  ),
                )
              ],
            ),
          ),
          Align( 
            alignment: Alignment.bottomCenter,
            child: Row( 
              children: [ 
                Expanded( 
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), 
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    decoration: BoxDecoration( 
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 0.0), blurRadius: 10.0, spreadRadius: 0.0)],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField( 
                      controller: todoController,
                      decoration: InputDecoration( 
                        hintText: "Add a New Item",
                        border: InputBorder.none
                      )
                    )
                  ),

                ),
                Container ( 
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton ( 
                    child: Text("+", style: TextStyle(fontSize: 40,),),
                    onPressed: () { 
                      addToDoItem(todoController.text);
                    },
                    style: ElevatedButton.styleFrom( 
                      
                     
                      elevation: 10,
                    ),
                  )
                )
              ]

            )
          )
        ],
      )
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    
  }

  void deleteToDoItem(String id) {
    setState((){
      todosList.removeWhere((item) => item.id == id);
    });
  
  }

  void addToDoItem(String toDo) {
    setState((){
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });

    todoController.clear();
    
  }


  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      foundToDo = results;
    });
  }



  Widget searchBox() {
    return ( 
      Container( 
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration( 
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField( 
                onChanged: (value) => runFilter(value),
                decoration: InputDecoration( 
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search, 
                    color: tdBlack, 
                    size: 20), 
                    prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: tdGrey),

                ),
                
              ), 
            )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(
          Icons.menu, 
          color:tdBlack, 
          size: 30,
          ),

        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
      ]), 
      
      
    );
  }
}