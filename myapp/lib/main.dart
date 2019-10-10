import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  //debugPaintSizeEnabled = true; //2.第二步
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ScaffoldDemo(),
    );
  }
}

class ScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      drawer: _drawer(context),
    );
  }

  AppBar _appBar() {
    return new AppBar(
      // 如果有 侧边栏  右边是默认的事条目，点击默认打开 左侧边栏。 如果没有侧边栏，就显示返回箭头
      actions: <Widget>[],
    );
  }

  Drawer _drawer(BuildContext context) {
    //侧边栏
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              image: DecorationImage(
                  image: AssetImage("images/timg.png"), fit: BoxFit.fill),
            ),
          ),
          ListTile(
            title: Text('我的学习'),
            leading: new CircleAvatar(
              child: new Icon(Icons.school),
            ),
            onTap: () {
             null;
            },
          ),
          ListTile(
            title: Text('我的出游'),
            leading: new CircleAvatar(
              child: new Icon(Icons.directions_run),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('我的观阅'),
            leading: new CircleAvatar(
              child: new Icon(Icons.chrome_reader_mode),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('我的美食'),
            leading: new CircleAvatar(
              child: new Icon(Icons.fastfood),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Builder _body() {
    return Builder(builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(130.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/4.jpg"), fit: BoxFit.fill),
        ),
        child: FloatingActionButton(
          child: Text('汇报'),
          onPressed: () {
            Scaffold.of(context).showBottomSheet((BuildContext context) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text('今日学习'),
                    leading: new CircleAvatar(
                      child: new Icon(Icons.school),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Chat();
                      }));
                    },
                  ),
                  ListTile(
                    title: Text('今日出游'),
                    leading: new CircleAvatar(
                      child: new Icon(Icons.directions_run),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Chat();
                      }));
                    },
                  ),
                  ListTile(
                    title: Text('今日观阅'),
                    leading: new CircleAvatar(
                      child: new Icon(Icons.chrome_reader_mode),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Chat();
                      }));
                    },
                  ),
                  ListTile(
                    title: Text('今日美食'),
                    leading: new CircleAvatar(
                      child: new Icon(Icons.fastfood),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Chat();
                      }));
                    },
                  ),
                ],
              );
            });
          },
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    });
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  Map<int,String> map = new Map();

  @override
  Widget build(BuildContext ctx) {

    map[1] = "天上有多少星光世间有多少男孩，但天上只有一个月亮世间只有一个你。";
    map[2] = "我能想到最甜蜜的事，就是在喜欢你的每一天里，被你喜欢。";
    map[3] = "最难忘的是你的微笑，当它绽开在你的脸上时，我仿佛感到拂过一阵春风，暖融融的，把我的心都融化了。";
    map[4] = "或许我没有太阳般狂热的爱，也没有流水般绵长的情，只知道不断的爱你爱你。竭尽所能地为你。";
    map[5] = "我因为得到你的爱，于是我便想要去拥抱每一个人，因为你的爱让我感觉到这世间的美好。";

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("高木"),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
          child: Container(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: new EdgeInsets.all(6.0),
            ),
          ),
        ),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(color: Theme.of(ctx).cardColor),
        ),
      ]),
    );
  }

  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                  decoration: new InputDecoration.collapsed(hintText: "汇报进度"),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: new IconButton(
                    icon: new Icon(Icons.message),
                    onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
                  )),
            ],
          ),
          decoration: null),
    );
  }

  void _submitMsg(String txt) {
    int ran = Random().nextInt(5-1);
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 400)),
      judge: 0,
    );
    Msg msg2 = new Msg(
      txt: '?',
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 400)),
      judge: 1,
    );
    setState(() {
      _messages.insert(0, msg);
    });
    Future.delayed(Duration(seconds: 2), (){
      setState(() {
        _messages.insert(0, msg2);
      });
    });
    msg.animationController.forward();
    Future.delayed(Duration(seconds: 2), (){
      msg2.animationController.forward();
      });
  }

//  @override
//  void dispose() {
//    for (Msg msg in _messages) {
//      msg.animationController.dispose();
//    }
//    super.dispose();
//  }
}
class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController,this.judge});
  final String txt;
  final AnimationController animationController;
  final int judge;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: judge.isEven ? new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    alignment:judge.isEven ? Alignment.bottomRight:Alignment.bottomLeft,
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(
                      txt,
                      textAlign:judge.isEven ? TextAlign.left:TextAlign.right,
                      style: TextStyle(
                        fontSize:16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              child: new CircleAvatar(child: new Text('you')),
            ),
          ],
        ),
      ) :
      new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: Container(
                      width: 60.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/5.png"),
                        ),
                      ),
                    )
                  ),
                  new Container(
                    alignment:judge.isEven ? Alignment.bottomRight:Alignment.bottomLeft,
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(
                      txt,
                      textAlign:judge.isEven ? TextAlign.left:TextAlign.right,
                      style: TextStyle(
                        fontSize:16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

