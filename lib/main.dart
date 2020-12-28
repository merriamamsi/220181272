import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/model/database.dart';
import 'package:todoApp/pages/add_task_page.dart';
import 'package:todoApp/pages/task_page.dart';
import 'package:todoApp/pages/task_page2.dart';
import 'package:todoApp/pages/task_page3.dart';
import 'package:todoApp/widgets/custom_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Database>(create: (_) => Database())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: "Montserrat"),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();

  double currentPage = 0;
  TabController tabController;
  @override
  void initState() {

    tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'home',
            ),
            Tab(
              text: 'Checked',
            ),
            Tab(
              text: 'IsnotChecked',
            ),
          ],
          isScrollable: true,
        ),
      ),
        body:  Column(
        children: [
          Expanded(
              child: TabBarView(
                controller: tabController,
                children: [Stack(
            children: <Widget>[

            Positioned(
              right: 0,
              child: Text(
                "",
                style: TextStyle(fontSize: 200, color: Color(0x10000000)),
              ),
            ),
      _mainContent(context),
      ],
    ), Stack(
    children: <Widget>[

    Positioned(
    right: 0,
      child: Text(
        "",
        style: TextStyle(fontSize: 200, color: Color(0x10000000)),
      ),
    ),
    _mainContent2(context),
    ],
    ),Stack(
                  children: <Widget>[

                    Positioned(
                      right: 0,
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 200, color: Color(0x10000000)),
                      ),
                    ),
                    _mainContent3(context),
                  ],
                ),],
              )),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    child:  AddTaskPage() ,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))));
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          // child: _button(context),
        ),
        Expanded(
            child: PageView(
              controller: _pageController,
              children: <Widget>[TaskPage()],
            )
        )
      ],
    );
  }
  Widget _mainContent3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          // child: _button(context),
        ),
        Expanded(
            child: PageView(
              controller: _pageController,
              children: <Widget>[TaskPage3()],
            )
        )
      ],
    );
  }

  Widget _mainContent2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
         // child: _button(context),
        ),
        Expanded(
            child: PageView(
          controller: _pageController,
          children: <Widget>[TaskPage2()],
        )
        )
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: "Tasks",
          color:
              currentPage < 0.5 ? Theme.of(context).accentColor : Colors.white,
          textColor:
              currentPage < 0.5 ? Colors.white : Theme.of(context).accentColor,
          borderColor: currentPage < 0.5
              ? Colors.transparent
              : Theme.of(context).accentColor,
        )),
        SizedBox(
          width: 32,
        ),
        Expanded(
            child: CustomButton(
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
          buttonText: "Events",
          color:
              currentPage > 0.5 ? Theme.of(context).accentColor : Colors.white,
          textColor:
              currentPage > 0.5 ? Colors.white : Theme.of(context).accentColor,
          borderColor: currentPage > 0.5
              ? Colors.transparent
              : Theme.of(context).accentColor,
        ))
      ],
    );
  }
}
