import 'package:flutter/material.dart';
import 'package:shorts_app/constants.dart';
import 'package:shorts_app/view/widgets/customAddicon.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageInx=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        mouseCursor: MouseCursor.defer,
        type:BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: (index){
          setState(() {
            pageInx=index;
          });
        },
        currentIndex: pageInx,
        items: [
          BottomNavigationBarItem(
              icon:Icon(Icons.home,size: 25,color:Colors.white,),
              label: " Home "
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.search,size: 25,color: Colors.white,),
              label: "Search"
          ),
          BottomNavigationBarItem(
            icon:customAddicon(),
            label: " Add ",
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.message,size: 25,color: Colors.white,),
              label: " Message "
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.person,size: 25,color:Colors.white,),
            label: " profile ",
          ),
        ],
      ),
      body: Center(child: pageindex[pageInx],),
    );
  }
}
