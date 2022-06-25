import 'dart:math';

import 'package:snakegame/view/snakehome.dart';

void movingSnake(){

  switch (currentDirection){
    case snakeDirection.UP:{
      
      if(snakePos.last<totalRowSize){
        snakePos.add(snakePos.last-totalRowSize+totalBoxCount);
      }else{
        snakePos.add(snakePos.last-totalRowSize);
      }
    }
    break;
    case snakeDirection.DOWN:{
      if(snakePos.last+totalRowSize>totalBoxCount){
        snakePos.add(snakePos.last+totalRowSize-totalBoxCount);
      }else{
        snakePos.add(snakePos.last+totalRowSize);
      }
    }
    break;
    case snakeDirection.LEFT:{

      if(snakePos.last%totalRowSize==0){
        snakePos.add(snakePos.last-1+totalRowSize);
      }else{
        snakePos.add(snakePos.last-1);
      }
    }
    break;
    case snakeDirection.RIGHT:{
        if(snakePos.last%totalRowSize==29){
          snakePos.add(snakePos.last+1-totalRowSize);
        }else{
          snakePos.add(snakePos.last+1);
        }
    }
    break;
  }
  if(snakePos.last== foodPos){
      eatFood();
  }
  else{
    snakePos.removeAt(0);
  }

}
void eatFood(){
  scoreCount++;
  while (snakePos.contains(foodPos)){
    foodPos=Random().nextInt(totalBoxCount);
  }
}
bool gameOver(){
List bodySnake= snakePos.sublist(0,snakePos.length-1) ;
if(bodySnake.contains(snakePos.last)){

  return true;
}
return false;

}
