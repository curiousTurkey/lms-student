import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_student/App_Screens/ClassAnnouncement.dart';
import 'package:lm_student/App_Screens/LeaveApplication.dart';
import 'package:lm_student/App_Screens/ProfileScreen.dart';
import 'package:lm_student/App_Screens/Signup_page.dart';
import 'package:lm_student/App_Screens/TimeTable.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart' as resize;
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;
import 'package:lm_student/Reusable_Utils/SideBar/SideBar.dart';
import 'package:provider/provider.dart';
import '../Providers/UserProvider.dart';
import 'Home_screen.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late PageController pageController ;
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  addUserData() async {
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  void initState(){
      super.initState();
    pageController = PageController(initialPage: selectedIndex);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    addUserData();

  }
  void onTap(index){
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 50), curve: Curves.linearToEaseOut);
    });
}
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(value: SystemUiOverlayStyle(
      systemNavigationBarColor: color_mode.secondaryColor,
      systemNavigationBarIconBrightness: Brightness.light),
      child:Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (selectedIndex){
          setState(() {
            this.selectedIndex = selectedIndex;
          });
        },
        children: const [
          HomeScreen(),
          LeaveApplication(),
          ClassAnnouncement(),
          TimeTable(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        onTap: onTap,
        backgroundColor: color_mode.primaryColor,
        elevation: 5,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: color_mode.secondaryColor),
        selectedIconTheme: IconThemeData(
          color: color_mode.primaryColor,
          opacity: 1,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
        items: [
        BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.house,size: 16,),
            label: "Home",
            activeIcon: FaIcon(FontAwesomeIcons.house,size: 25,color: color_mode.secondaryColor,),
          backgroundColor: color_mode.primaryColor,
        ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.paperPlane,size: 16,),
            label: "Leave Application",
            activeIcon:Icon(FontAwesomeIcons.solidPaperPlane,size: 25,color: color_mode.secondaryColor,),
            backgroundColor: color_mode.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.bell,size: 16,),
            label: "Class announcement",
            activeIcon:Icon(Icons.notifications_active,size: 26,color: color_mode.secondaryColor,),
            backgroundColor: color_mode.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.table_chart,size: 16,),
            label: "Time Table",
            activeIcon:Icon(Icons.table_chart,size: 26,color: color_mode.secondaryColor,),
            backgroundColor: color_mode.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_outlined,size: 20,),
            label: "Profile",
            activeIcon:Icon(Icons.person,color: color_mode.secondaryColor,size: 26,),
            backgroundColor: color_mode.primaryColor,
          ),
      ],
      ),
      ),
    );
  }
}
