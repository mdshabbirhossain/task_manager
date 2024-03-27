import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';
import 'package:task_manager/presentation/screens/progress_task_screen.dart';

import '../utils/app_colors.dart';
import 'Complete_task_screen.dart';
import 'cancel_task_screen.dart';
class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final List<Widget> _screen =[
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const ProgressTaskScreen(),
    const CancelTaskScreen(),
  ];
  int _currentSelectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColor.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index){
          _currentSelectedIndex = index;
          if (mounted) {
            setState(() {
              
            });
          }
        },
        items: [
        BottomNavigationBarItem(icon:Icon(Icons.file_copy_outlined),label: 'New Task'),
        BottomNavigationBarItem(icon:Icon(Icons.done_all),label: 'Completed'),
        BottomNavigationBarItem(icon:Icon(Icons.blur_circular),label: 'Progress'),
        BottomNavigationBarItem(icon:Icon(Icons.close_rounded),label: 'Cancelled'),

        
      ],),
    );
  }
}
