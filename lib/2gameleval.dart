import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mathpuzzle/levallist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathpuzzle/main.dart';
import 'package:mathpuzzle/winpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leval extends StatefulWidget {
  int cur_level;

  leval(this.cur_level);

  @override
  State<leval> createState() => _levalState();
}

class _levalState extends State<leval> {
  String ans = "";
  int cur_level = 0;
  SharedPreferences? prefs;

  Widget my_btn(int a) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ans = ans + a.toString();
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          height: 20,
          width: 35,
          child: Text(
            "$a",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (cur_level > data.game_leval.length) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return win(cur_level);
        },
      ));
    }else {
      prefs?.clear();
    }
    cur_level = widget.cur_level;

    get();
  }

  get() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("image/gameplaybackground.jpg"),
                  fit: BoxFit.fill)),
          // height: 1000,
          // width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      prefs!.setString("level$cur_level", "skip");
                      ans = "";
                      if(cur_level<data.ans.length-1){
                        cur_level++;
                        prefs!.setInt("cur_level", cur_level);
                        setState(() {
                        });
                      }
                      },
                    child: Container(
                      // margin: EdgeInsets.only(top: 50, left: 20),
                      height: 80,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("image/skip.png"))),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Puzzle ${cur_level + 1}",
                      style: TextStyle(
                          fontSize: 20, color: Colors.black, fontFamily: "f1"),
                    ),
                    //margin: EdgeInsets.only(top: 50, left: 10, right: 10),
                    height: 70,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("image/level_board.png"))),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    height: 80,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("image/hint.png"))),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "image/${data.game_leval[cur_level]}"))),
                    ),
                  ],
                ),
              ),
              SizedBox(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 80,
                        color: Colors.black,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text("$ans"),
                                  height: 30,
                                  width: 150,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (ans.length > 0) {
                                      ans = ans.substring(0, ans.length - 1);
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                            AssetImage("image/delete.png")),
                                        border:
                                        Border.all(color: Colors.white38)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (ans == data.ans[cur_level]) {
                                      prefs!.setString("level${cur_level}", "win");
                                      cur_level++;
                                      int t=prefs!.getInt("queleval") ?? 0;
                                      if(cur_level>t) {
                                        prefs!.setInt("cur_level", cur_level);
                                      }
                                      ans = "";
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return win(cur_level);
                                        },
                                      ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "wrong Ans",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 100,
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                my_btn(1),
                                my_btn(2),
                                my_btn(3),
                                my_btn(4),
                                my_btn(5),
                                my_btn(6),
                                my_btn(7),
                                my_btn(8),
                                my_btn(9),
                                my_btn(0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),),
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure for exit..."),
              actions: [
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return math();
                  },));
                }, child: Text("Yes")),
                TextButton(onPressed: () {
                  Navigator.pop(context);

                }, child: Text("NO"))
              ],
            );
          },
        );

        return true;
      },
    );
  }
}
