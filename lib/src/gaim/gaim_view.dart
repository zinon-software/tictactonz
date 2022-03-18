import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:math';

import '../constant/app_color.dart';
import '../settings/settings_view.dart';

class GaimView extends StatefulWidget {
  const GaimView({ Key? key }) : super(key: key);

  @override
  _GaimViewState createState() => _GaimViewState();
}

class _GaimViewState extends State<GaimView> {

  int playTurn = 0;
  var map = HashMap<int,dynamic>.fromIterables([0,1,2,3,4,5,6,7,8],[null,null,null,null,null,null,null,null,null]);
  var crossTurn = false;
  var savedTurn = false;
  var userFirstNumber = 0;
  int playerCross = 0;
  int playerCircle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.appColor,
        title: const Text('TicTacToe - اتحداك',style: TextStyle(fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8,color: crossTurn ? AppColor.appColor : AppColor.disabledColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: crossTurn ? AppColor.appColor : AppColor.disabledColor,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
                          ),
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Player1 الااعب الاول',style: TextStyle(color: Colors.white)),
                              Transform.rotate(angle: pi/4,child: const Icon(Icons.add,size:24,color: Colors.white))
                            ]
                          )
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                          child: Text(
                            playerCross.toString().padLeft(4,'0'),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: crossTurn ? AppColor.pointEnableColor : AppColor.pointDisableColor,fontSize: 25,fontWeight: FontWeight.bold)
                          )
                        )
                      ]
                    )
                  )
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8,color: !crossTurn ? AppColor.appColor : AppColor.disabledColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: !crossTurn ? AppColor.appColor : AppColor.disabledColor,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))
                          ),
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Player2 الاعب الثاني',style: TextStyle(color: Colors.white)),
                              Icon(Icons.circle_outlined,size:22,color: Colors.white)
                            ]
                          )
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                          child: Text(
                            playerCircle.toString().padLeft(4,'0'),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: !crossTurn ? AppColor.pointEnableColor : AppColor.pointDisableColor,fontSize: 25,fontWeight: FontWeight.bold)
                          )
                        )
                      ]
                    )
                  )
                )
              ]
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 3),
              itemCount: 9,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 15),
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: () { if(map[index] == null) onClickContainer(context, index);},
                  child: Container(
                    margin: const EdgeInsets.all(0.8),
                    decoration: const BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: BorderRadius.all(Radius.circular(1.0))
                    ),
                    child: map[index] == null ? null : Transform.rotate(angle: pi / 4,child: Icon(map[index],color: Colors.white,size: map[index] == Icons.add ? 100 : 80))
                  )
                );
              }
            )
          ]
        )
      )
    );
  }

  Future<bool> showGameDialog(int result) async{
    return await showDialog(
      barrierLabel: 'GameDialog',
      barrierDismissible: true,
      context: context, 
      builder: (context){
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                result == -1
                ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Transform.rotate(angle: pi/4,child: const Icon(Icons.add,size: 100,color: Colors.white)),const Icon(Icons.circle_outlined,size: 70,color: Colors.white)])
                : Transform.rotate(
                  angle: pi/4,
                  child: Icon(result == 0 ? Icons.add : Icons.circle_outlined,size: result == 0 ? 100 : 70,color: Colors.white)
                ),
                Text(result == -1 ? 'DRAW!' : 'WINNER!',style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontFamily: ''))
              ]
            ),
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(10)
            )
          )
        ); 
      }
    ) ?? true;
  }

  clearData(int result) async{
    if(result == 0){
      playerCross++;
      savedTurn = crossTurn = true;
    }else if(result == 1){
      savedTurn = crossTurn = false;
      playerCircle++;
    }
    await showGameDialog(result);
    playTurn = 0;
    map.clear();
    setState((){});
  }

  onClickContainer(BuildContext context,int index) async{
    if(playTurn < 9){
      setState((){
        playTurn++;
        if(crossTurn){
          map[index] = Icons.add;
          crossTurn = false;
        }else{
          map[index] = Icons.circle_outlined;
          crossTurn = true;
        }
      });
      var result = gameAlgorithm();
      if(result != -1){
        await clearData(result);
      }else if(playTurn == 9 && result == -1){
        crossTurn = savedTurn;
        await clearData(result);
      }
    }
  }

  int gameAlgorithm(){
    if(map[0] == map[1] && map[0] == map[2] && map[1] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[3] == map[4] && map[3] == map[5] && map[4] != null){
      if(map[3] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[6] == map[7] && map[6] == map[8] && map[7] != null){
      if(map[6] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[0] == map[3] && map[0] == map[6] && map[3] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[1] == map[4] && map[1] == map[7] && map[4] != null){
      if(map[1] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[2] == map[5] && map[2] == map[8] && map[5] != null){
      if(map[2] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[0] == map[4] && map[0] == map[8] && map[4] != null){
      if(map[0] == Icons.add){
        return 0;
      }
      return 1;
    }
    if(map[2] == map[4] && map[2] == map[6] && map[4] != null){
      if(map[2] == Icons.add){
        return 0;
      }
      return 1;
    }
    return -1;
  }

}