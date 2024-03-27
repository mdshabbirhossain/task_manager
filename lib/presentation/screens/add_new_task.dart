import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/networkcaller.dart';
import 'package:task_manager/presentation/widgets/appbar_widget.dart';
import 'package:task_manager/presentation/widgets/background_widgets.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/utility/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEcontroller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  bool _shouldRefreshNewTaskList = false;
  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop){
        if(didpop){
          return;
        }
        Navigator.pop(context,_shouldRefreshNewTaskList);
      },
       
      child: Scaffold(
        appBar: ProfileAppBar,
        body: BackgroundWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _titleTEcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Title',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        )),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter Your Title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Description',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        )),
                    validator: (String? value){
                      if(value?.trim().isEmpty??true){
                        return 'Enter your Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _addNewTaskInProgress==false,
                        replacement:  const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formkey.currentState!.validate()){
                                _addNewTask();
      
                              }
                             // Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      )),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
  Future<void> _addNewTask() async{
    _addNewTaskInProgress=true;
    setState(() {});

     Map< String, dynamic> inputParams ={
       "title":_titleTEcontroller.text.trim(),
       "description":_descriptionController.text.trim(),
       "status":"New"

    };

    final response = await NetworkCaller.postRequest(Urls.createTask, inputParams);
    _addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      _shouldRefreshNewTaskList = true;
      _titleTEcontroller.clear();
      _descriptionController.clear();
      if(mounted)
        {
          showSnackBarMessage(context, 'New Task has been added');
        }

    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Add new task failed',true);
      }
    }
    
    
  }
  
  
  @override
  void dispose() {
    _titleTEcontroller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  
}
