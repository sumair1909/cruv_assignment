import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController seatNoController;
  late FocusNode focusNode;
  List<String> seatType = ["Lower", "Middle", "Upper", "Side"];
  List<String> seatData = [];

  @override
  void initState() {
    super.initState();
    seatNoController = TextEditingController();
    focusNode = FocusNode();
    addListElements();
  }

  addListElements() {
    for (int i = 0; i < 8;) {
      seatData.addAll(seatType);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Seat Finder",
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
              child: TextFormField(
                  controller: seatNoController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.numberWithOptions(),
                  onFieldSubmitted: (value) {
                    setState(() {});
                    if (int.parse(seatNoController.text) > 32 ||
                        int.parse(seatNoController.text) < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter a valid seat number")));
                    }
                    focusNode.unfocus();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {});
                            if (int.parse(seatNoController.text) > 32 ||
                                int.parse(seatNoController.text) < 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please enter a valid seat number")));
                            }
                            focusNode.unfocus();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                      hintText: "Enter seat number..")),
            ),
            Expanded(
                child: GridView.builder(
              itemCount: 32,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: seatNoController.text.isNotEmpty &&
                            index + 1 == int.parse(seatNoController.text)
                        ? Colors.black
                        : Colors.white,
                  ),
                  height: 10,
                  width: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                            color: seatNoController.text.isNotEmpty &&
                                    index + 1 ==
                                        int.parse(seatNoController.text)
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        seatData[index],
                        style: TextStyle(
                            color: seatNoController.text.isNotEmpty &&
                                    index + 1 ==
                                        int.parse(seatNoController.text)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    ));
  }
}
