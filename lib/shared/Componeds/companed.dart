import 'package:flutter/material.dart';

 Widget defultTextFormField ({
   TextEditingController controller,
 // required Function  validator,
   TextInputType type,
  String label,
  VoidCallback  ontap,
  Color BorderSideColor:Colors.indigo,
  Color TextStyleColor:Colors.indigo,
   IconData prefixIcon
})=>TextFormField(
  validator:(value){
    if(value.isEmpty)
      {
        return 'please Enter Text';
      }
    return null;

  },
  controller:controller,
  onTap: ontap,
  keyboardType: type,
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: BorderSideColor ),
      borderRadius: BorderRadius.circular(25.0),
    ),
    labelText: label,
    labelStyle: TextStyle(color: TextStyleColor),
    prefixIcon: Icon(prefixIcon,color: Colors.indigo,),

    border: OutlineInputBorder(),


  ),

);


 Widget BuildTaskItem(Map model)=>Padding(
   padding: const EdgeInsets.only(right: 8,left: 8,top: 8),
   child: Container(
     height: 120,
     width: double.infinity,
     decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
       color: Colors.indigo,
     ),
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         children:[
           CircleAvatar(
             backgroundColor:Colors.deepPurpleAccent ,
             radius: 45,
             child: Text('${model['time']}'),
           ),
           SizedBox(width: 22,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('${model['title']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
               Text('${model['date']}',style: TextStyle(fontSize: 15,color: Colors.grey[400]),),

             ],
           ),

         ],
       ),
     ),

   ),
 );