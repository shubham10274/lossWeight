import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lossy/database/database_service.dart';
import 'package:lossy/model/acitivity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  String dropdownValue = "weight";
  String selectedTab = "All";

  buildTab(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Chip(
        elevation: 10,
        backgroundColor: Colors.redAccent,
        label: Text(
          text,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  openAddDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child:
              StatefulBuilder(builder: (BuildContext, StateSetter stateSetter) {
            return Container(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 125,
                          height: 40,
                          child: TextFormField(
                            controller: controller,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: dropdownValue == "weight"
                                  ? "In kg"
                                  : "convert",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          hint: Text(
                            "Choose",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          dropdownColor: Colors.grey,
                          onChanged: (value) {
                            stateSetter(() {
                              dropdownValue = value!;
                            });
                          },
                          elevation: 5,
                          value: dropdownValue,
                          items: [
                            DropdownMenuItem(
                              value: "weight",
                              child: Text(
                                "Weight",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "others",
                              child: Text(
                                "Others",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    IconButton(
                      iconSize: 50,
                      color: Colors.redAccent,
                      icon: Icon(Icons.double_arrow_rounded),
                      onPressed: () async {
                        int success =
                            await DataBaseService.instance.addActivity(
                          {
                            DataBaseService.type: dropdownValue,
                            DataBaseService.date: DateTime.now().toString(),
                            DataBaseService.data: double.parse(controller.text),
                          },
                        );
                        print(success);
                        controller.clear();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Chip(
        backgroundColor: Colors.redAccent,
        onDeleted: () => openAddDialog(context),
        deleteIcon: Icon(
          Icons.add,
          color: Colors.white,
          size: 26,
        ),
        label: Text(
          "Add",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Color(0xfffFBF5F5),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Text(
                "WeightTracker",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  children: [
                    buildTab("All"),
                    buildTab("Weight"),
                  ],
                ),
              ),
              FutureBuilder(
                future: DataBaseService.instance.getActivities(selectedTab),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        // child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else {
                    print("Data: ${snapshot.data}");

                    List<Activity> activityList = [];
                    if (snapshot.data != null) {
                      activityList = List.generate(
                        snapshot.data!.length,
                        (index) => Activity(
                          snapshot.data![index]['columnid'] as int,
                          snapshot.data![index]['date'] as String,
                          snapshot.data![index]['data'] as double,
                          snapshot.data![index]['type'] as String,
                        ),
                      );
                    }

                    return GroupedListView<Activity, String>(
                      elements: activityList,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      groupBy: (activity) => DateFormat.MMMd()
                          .format(DateTime.parse(activity.date)),
                      itemBuilder: (context, activity) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: ListTile(
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: AssetImage('assets/images/logo.webp'),
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  activity.type == "weight"
                                      ? "${activity.data} kg"
                                      : "${activity.data} convert",
                                  style: TextStyle(
                                      fontSize: 27,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      groupSeparatorBuilder: (value) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
