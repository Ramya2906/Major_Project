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
  late int _cycleLength;
  late DateTime _focusedDay;
  late DateTime _lastDay;
  late DateTime _firstDay;
  late DateTime _selectedDay;

  void _onCycleLengthSelect(String value) {
    this._cycleLength = int.parse(value);
  }

  void _onDaySelect(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  // void _navigateToResultPage(Result result) {
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => ResultPage(
  //         result: result,
  //       ),
  //     ),
  //   );
  // }

  void _predictCycle() {
    if (this._cycleLength >= 11 &&
        this._cycleLength <= 45 &&
        this._selectedDay != null) {
      DateTime lastPeriod,
          nextPeriod,
          follicularPhase,
          ovulationPhase,
          lutealPhase;
      int cycleLength = this._cycleLength;
      lastPeriod = this._selectedDay;
      nextPeriod = lastPeriod.add(Duration(days: cycleLength));
      follicularPhase = lastPeriod;
      ovulationPhase =
          lastPeriod.add(Duration(days: (cycleLength / 2).floor()));
      lutealPhase =
          lastPeriod.add(Duration(days: (cycleLength / 2).floor() + 2));
      // Result result = Result(null, cycleLength, lastPeriod, nextPeriod,
      //     follicularPhase, ovulationPhase, lutealPhase);
      // this._navigateToResultPage(result);
    }
    // else {
    //   showMessageBar(context, "Please select your last period date.",
    //       error: true);
    // }
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _lastDay = DateTime.now();
    _firstDay = DateTime.now().subtract(Duration(days: 45));
    _cycleLength = 28;
  }


  @override
  Widget build(BuildContext context) {

    TableCalendar tableCalendar = TableCalendar(
      firstDay: this._firstDay,
      lastDay: this._lastDay,
      focusedDay: this._focusedDay,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      rowHeight: 45.0,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
      ),
      // daysOfWeekStyle: DaysOfWeekStyle(
      //   weekdayStyle: Theme.of(context).textTheme.bodyText1,
      //   weekendStyle: Theme.of(context).textTheme.bodyText1,
      // ),
      availableGestures: AvailableGestures.horizontalSwipe,
      selectedDayPredicate: (day) => isSameDay(this._selectedDay, day),
      onDaySelected: this._onDaySelect,
      onPageChanged: (focusedDay) {
        this._focusedDay = focusedDay;
      },
    );

    Container cycleLengthPicker() => Container(
      margin: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
        left: 15.0,
        right: 15.0,
      ),
      height: 120.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Whats your usual cycle length?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            CyclePicker(onSelect: _onCycleLengthSelect)
          ],
        ),
      ),
    );

    Container datePicker() => Container(
      margin: EdgeInsets.only(
        top: 0.0,
        bottom: 20.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.2),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Select your last date of period?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              tableCalendar,
            ]),
      ),
    );

    Column main() => Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            "assets/calendar.png",
            width: 48.0,
            height: 48.0,
          ),
        ),
        Text(
          "Predict cycle accurately.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(padding: EdgeInsets.all(2.0)),
        Text(
          "Track period easily.",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 5.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              main(),
              cycleLengthPicker(),
              datePicker(),
              PButton(
                onPressed: this._predictCycle,
                text: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
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
