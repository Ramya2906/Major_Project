import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:project3/login.dart';
import 'package:project3/models/user_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//screen1
class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logo.gif",
          height: 350.0,
          width: 350.0,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Welcome",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
              "Polycystic ovary syndrome (PCOS) is a hormonal disorder common among women of reproductive age. Women with PCOS may have infrequent or prolonged menstrual periods or excess male hormone (androgen) levels. The ovaries may develop numerous small collections of fluid (follicles) and fail to regularly release eggs."),
        ),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          color: Colors.red[200],
          child: TextButton(
            onPressed: () {
              Screen2();
            },
            child: Text(
              "Give a Try!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//screen2
class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Know the severity of PCOS!",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select option via which you want to check the status \(through uploading image or by the values from the blood report\).",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.red[200],
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Upload ultrasound image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.red[200],
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Upload clinical values",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//screen3
class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay= DateTime.now();
  DateTime focusedDay=DateTime.now();
  DateTimeRange dateRange= DateTimeRange(
    start: DateTime(2021), end: DateTime.now(),
  );


  DateTimeRange? _selectedDateRange;
  // This function will be triggered when the floating button is pressed
  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final start=dateRange.start;
    final end=dateRange.end;
    return Column(
      children: [
        TableCalendar(
          focusedDay: focusedDay,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format){
            setState(() {
              format = _format;
            });
          },
          onDaySelected: (DateTime selectDay, DateTime focusDay){
            setState(() {
              selectedDay=selectDay;
              focusedDay=focusDay;
            });
          },
          selectedDayPredicate: (DateTime date){
            return isSameDay(selectedDay, date);
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.red[200],
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            formatButtonTextStyle: TextStyle(color: Colors.white),
          ),
        ),

        // TextButton(
        //   onPressed: (){
        //     pickDateRange;
        //   },
        //   child: Text("Choose you last period range\t\t\t\t\t\t ${start.year}",
        //   style: TextStyle(fontSize: 20),),
        // ),
        SizedBox(height: 20,),
        Material(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(15),
          child: TextButton(
              onPressed: () {
                _show();
                // DatePicker.showDatePicker(context,
                // showTitleActions: true,
                // minTime: DateTime(2021),
                // maxTime: DateTime.now(), onChanged: (date) {
                // print('change $date');
                // }, onConfirm: (date) {
                // print('confirm $date');
                // }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'When was your last period?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
        SizedBox(height: 20,),
        Text("What's your period gap? (in days)",
          style: TextStyle(fontSize: 20),
        ),
        // SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
          // padding: const EdgeInsets.all(58.0),
          child: NumberInputPrefabbed.roundedButtons(
            controller: TextEditingController(),
            scaleWidth: 1,
            initialValue: 20,
            onIncrement: (num newlyIncrementedValue) {
              print('Newly incremented value is $newlyIncrementedValue');
            },
            onDecrement: (num newlyDecrementedValue) {
              print('Newly decremented value is $newlyDecrementedValue');
            },
            incDecBgColor: Colors.pink,
            buttonArrangement: ButtonArrangement.incRightDecLeft,
          ),
        ),

      ],
    );
  }
// Future pickDateRange() async{
//   DateTimeRange? newDateRange =await showDateRangePicker(
//     context:context,
//     initialDateRange:dateRange,
//     firstDate:DateTime(2021),
//     lastDate:DateTime(2100),
//   );
// }
}

//screen4
class Screen4 extends StatelessWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/small_logo1.png",
              fit: BoxFit.contain,
              height: 50,
            ),
            Text("   kNOw PCOS"),
          ],
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
        // child:

        // child: Column(
        // children: [Text("Welcome Back"),
        //   SizedBox(height: 10,),
        //   Text("${loggedInUser.name}"),
        //   SizedBox(height: 10,),
        //   Text("${loggedInUser.email}"),
        //   SizedBox(height: 20,),
        //   ActionChip(label: Text("Logout"), onPressed: (){
        //     logout(context);
        //   }),
        // ],
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red[200],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.pinkAccent[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'kNOw',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
