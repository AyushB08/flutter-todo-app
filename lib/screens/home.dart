import "package:flutter/material.dart";
import "package:flutter_todo_app/constants/colors.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      backgroundColor: tdBGColor,
      appBar:  buildAppBar(),
      body: Container( 
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:  Column( 
          children: [
            Container( 
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration( 
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField( 
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
          ],
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