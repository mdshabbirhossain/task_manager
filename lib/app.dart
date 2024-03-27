import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/splash_screen.dart';

import 'package:task_manager/presentation/utils/app_colors.dart';
class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManager.navigatorKey,

      title: 'TaskManager',
      home: SplashScreen(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8),
         )

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            backgroundColor: AppColor.themeColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),

            ),
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColor.themeColor,
            textStyle: const TextStyle(
                fontSize: 14,
            ),
          ),

        ),
        textTheme:  TextTheme(
          titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          //titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        )
      ),

    );
  }
}
