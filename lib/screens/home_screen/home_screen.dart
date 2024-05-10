import 'package:flutter/material.dart';
import 'package:lossy/database/database_service.dart';
import 'package:lossy/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  String dropdownValue = "weight";
  buildTab(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Chip(
        elevation: 10,
        backgroundColor: Colors.redAccent,
        label: Text(
          text,
          style: textStyle(18, Colors.white, FontWeight.w600),
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
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Add",
                      style: textStyle(28, Colors.black, FontWeight.w700),
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
                            style: textStyle(20, Colors.black, FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: dropdownValue == "weight"
                                  ? "In kg"
                                  : "convert",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          hint: Text(
                            "Choose",
                            style: textStyle(18, Colors.black, FontWeight.w700),
                          ),
                          dropdownColor: Colors.grey,
                          onChanged: (value) {
                            stateSetter(
                              () {
                                dropdownValue = value!;
                              },
                            );
                          },
                          elevation: 5,
                          value: dropdownValue,
                          items: [
                            DropdownMenuItem(
                              value: "weight", // Unique value
                              child: Text(
                                "Weight",
                                style: textStyle(
                                    18, Colors.black, FontWeight.w700),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "others", // Unique value
                              child: Text(
                                "Others",
                                style: textStyle(
                                    18, Colors.black, FontWeight.w700),
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
                              await DataBaseService.instance.addActivity({
                            DataBaseService.type: dropdownValue,
                            DataBaseService.date: DateTime.now().toString(),
                            DataBaseService.data: double.parse(controller.text)
                          });
                          print(success);
                          controller.clear();
                          Navigator.pop(context);
                        })
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
    // SizeConfig().init(context);
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
          style: textStyle(22, Colors.white, FontWeight.w600),
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
                style: textStyle(40, Colors.black, FontWeight.w600),
              ),
              SizedBox(height: 35),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  children: [
                    buildTab("All"),
                    buildTab("Weight"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: AssetImage('assets/images/logo.webp'),
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                "65KG",
                                style: textStyle(
                                    27, Colors.black, FontWeight.w600),
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
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
