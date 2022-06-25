
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snakegame/model/food_pixel.dart';
import 'package:snakegame/model/moving_snake.dart';
import 'package:snakegame/model/snake_pixel.dart';
import 'package:snakegame/view/blank_pixle.dart';





class SnakeHome extends StatefulWidget {
  const SnakeHome({Key? key}) : super(key: key);

  @override
  State<SnakeHome> createState() => _SnakeHomeState();
}

enum SnakeDirection{UP,DOWN,LEFT,RIGHT}
var currentDirection=SnakeDirection.RIGHT;
List snakePos=[0,1,2];
int foodPos=554;
int totalRowSize=30;
int totalBoxCount=900;
int totalColoumSize=30;
int gameSpeed=200;
int scoreCount=0;
String playerName="Rafiq";


class _SnakeHomeState extends State<SnakeHome> {

  void startGame(){
    Timer.periodic(Duration(milliseconds: gameSpeed), (timer) {
      setState((){
            movingSnake();
            if(gameOver()==true){
              timer.cancel();
            }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 1,child: Container(
                color: Colors.black,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                        child: Text(scoreCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                        child: Text(playerName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                      ),

                    ],
                  ),
                ),
              )),
              Expanded(flex: 3,child: GestureDetector(
                onVerticalDragUpdate: (details){
                    if(details.delta.dy<0 && currentDirection!=SnakeDirection.DOWN){
                      currentDirection=SnakeDirection.UP;
                    }
                    else if(details.delta.dy>0 && currentDirection!=SnakeDirection.UP){
                      currentDirection=SnakeDirection.DOWN;
                    }
                },
                onHorizontalDragUpdate: (details){
                  if(details.delta.dx<0 && currentDirection!=SnakeDirection.RIGHT){
                    currentDirection=SnakeDirection.LEFT;
                  }
                  else if(details.delta.dx>0 && currentDirection!=SnakeDirection.LEFT){
                    currentDirection=SnakeDirection.RIGHT;
                  }
                },
                child: GridView.builder(
                    itemCount: totalBoxCount,
                    physics:const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: totalRowSize),
                    itemBuilder: (context,index){

                      if(snakePos.contains(index)){
                        return SnakePixel();
                      }
                      else if(foodPos==index){
                        return FoodPixel();
                      }
                      else{
                        return BlankPixel();
                      }


                }),
              ),
              ),
              Expanded(flex: 1,child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(color: Colors.pink.shade800,onPressed: startGame, child: Text("Start Game",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,
                  ),),),
                ],

              )),
            ],
          ),
        ),
      ),
    );
  }
}



