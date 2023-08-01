import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numberpicker/numberpicker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Card.getSharedPrefs();
  runApp(const MyApp());
}

class Card {
  static Map<String, List<String>> activities = {};

  static delSharedPrefs(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    List<String>? activitie = prefs.getStringList('activitie');
    activitie?.remove(key);
    await prefs.setStringList("activitie", activitie!);
  }

  static setSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("activitie", activities.keys.toList());
    for (int i = 0; i < activities.keys.toList().length; i++) {
      await prefs.setStringList(
          activities.keys.toList()[i], activities.values.elementAt(i));
    }
  }

  static getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('activitie');
    // prefs.remove('Example');

    if (prefs.getStringList('activitie') == null) {
      prefs.setStringList("activitie", ["Example"]);
      prefs.setStringList("Example", ["0.0 кг:", "0", "0", "0"]);
    }
    List<String>? activitie = prefs.getStringList('activitie');
    for (String activity in activitie!) {
      activities[activity] = prefs.getStringList(activity)!;
      if (activities[activity]!=null&&(activities[activity]?.length)!<4){
      activities[activity] =["0.0 кг:","0","0","0"];
      }
          }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitnesss',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Мой фитнес-хуитнес'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget stroka(int position, String activityName, List<String> values,
      ButtonStyle style) {
    List<String> newList=["0.0 кг:","0","0","0"];
     newList = Card.activities[activityName]!;
    List<String> list = List<String>.generate(
        50, (int index) => index.toString(),
        growable: false);
    List<String> list1 = List<String>.generate(
        100, (int index) => (index * 0.125).toString() + " кг:",
        growable: false);


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: DropdownButton<String>(
            iconSize: 0,
            elevation: 10,
            onTap: () {
              if (newList.length >= (position + 1) * 4) {
                newList[position * 4] = newList[(position + 1) * 4];
              }
              setState(() {});
            },
            value: newList[position * 4],
            icon: null,
            onChanged: (String? value) {
              setState(() {
                newList[position * 4] = value!;
              });
            },
            items: list1.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: DropdownButton<String>(
            iconSize: 0,
            elevation: 10,
            value: newList[position * 4 + 1],
            icon: null,
            onTap: () {
              if (newList.length >= (position + 1) * 4+1) {
                newList[position * 4+1] = newList[(position + 1) * 4+1];
              }
              setState(() {});
            },
            onChanged: (String? value) {
              setState(() {
                newList[position * 4 + 1] = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: DropdownButton<String>(
            iconSize: 0,
            elevation: 10,
            value: newList[position * 4 + 2],
            icon: null,
            onTap: () {
              if (newList.length >= (position + 1) * 4+2) {
                newList[position * 4+2] = newList[(position + 1) * 4+2];
              }
              setState(() {});
            },
            onChanged: (String? value) {
              setState(() {
                newList[position * 4 + 2] = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: DropdownButton<String>(
            iconSize: 0,
            elevation: 10,
            value: newList[position * 4 + 3],
            icon: null,
            onTap: () {
              if (newList.length >= (position + 1) * 4+3) {
                newList[position * 4+3] = newList[(position + 1) * 4+3];
              }
              setState(() {});
            },
            onChanged: (String? value) {
              setState(() {
                newList[position * 4 + 3] = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        TextButton(
            onPressed: () async {
              newList.insertAll(0, values);
              Card.activities[activityName] = newList;
              await Card.setSharedPrefs();
              setState(() {});
            },
            onLongPress: () async {
              newList.removeRange(position * 4, (position + 1) * 4);
              Card.activities[activityName] = newList;
              await Card.setSharedPrefs();
              setState(() {});
            },
            child: const Icon(Icons.save)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: ListView.builder(
          itemCount: Card.activities.keys.length,
          itemBuilder: (BuildContext context, int ind) {
            String currentKey = Card.activities.keys.toList()[ind];
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white70),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Colors.white70),
                child: ListTile(
                  title: Column(
                    children: [
                      Center(
                        child: TextFormField(
                          initialValue: currentKey,
                          onFieldSubmitted: (String? value) async {
                            if (value == "") {
                              await Card.delSharedPrefs(currentKey);
                              Card.activities.remove(currentKey);
                            } else {
                              Card.activities[value!] =
                              Card.activities[currentKey]!;
                              await Card.setSharedPrefs();
                            }
                            if (currentKey!=value!){
                            await Card.delSharedPrefs(currentKey);
                            Card.activities.remove(currentKey);}
                            Card.activities.remove("");
                            await Card.getSharedPrefs();
                            setState(() {});
                          },
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black45),
                        ),
                      ),
                      stroka(
                          0,
                          Card.activities.keys.toList()[ind],
                          ["0.0 кг:", "0", "0", "0"],
                          ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey))),
                    ],
                  ),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 4,
                    child: ListView.builder(
                        itemCount: (Card
                                .activities[Card.activities.keys.toList()[ind]]
                                ?.length)! ~/
                            4,
                        itemBuilder: (context, index) {
                          return stroka(
                              index,
                              Card.activities.keys.toList()[ind],
                              Card.activities.values
                                  .elementAt(ind)
                                  .sublist(index * 4, (index + 1) * 4),
                              (index!=0)? ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white12)):ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey)));
                        }),
                  ),
                  textColor: Colors.white,
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Card.delSharedPrefs("Example");
          Card.activities["Example"] = ["0.0 кг:", "0", "0", "0"];
          await Card.setSharedPrefs();
          setState(() {
                      });
        },
        tooltip: 'Добавить новое упражнение',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
