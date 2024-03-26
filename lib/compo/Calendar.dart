import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarwidget extends StatefulWidget {
  const Calendarwidget({super.key});

  @override
  State<Calendarwidget> createState() => _CalendarwidgetState();
}

class _CalendarwidgetState extends State<Calendarwidget> {
  DateTime focusedday =DateTime.now();
  final f = new DateFormat('MMM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
            height: 250,
            width: 250,
              decoration: BoxDecoration(color: const Color.fromRGBO(216, 97, 97, 1),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0,0),
                  spreadRadius: 0.2,
                  blurRadius: 0.2,
                  color: Colors.black
                )
              ]
              
              ),
              child:  Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                              focusedday =DateTime(focusedday.year,focusedday.month-1);
      
                          });
                        }, icon: Icon(Icons.chevron_left)),
                         Text(f.format(focusedday),style: TextStyle(decoration: TextDecoration.none,color: Colors.black,fontSize: 15),),
                          IconButton(onPressed: (){
                            setState(() {
                              focusedday =DateTime(focusedday.year,focusedday.month+1);
      
                            });
                        }, icon: Icon(Icons.chevron_right)),
                         
                    
                  
                ],
                ),
                    TableCalendar(
                      rowHeight: 30,
                        calendarFormat:CalendarFormat.month,
                        focusedDay: focusedday, firstDay: DateTime.utc(2015), lastDay: DateTime.utc(2040),
                      headerVisible: false,
                      onFormatChanged: (result){},
                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (date,locale){
                          return DateFormat("EE").format(date).toUpperCase();
                        },
                        weekdayStyle: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,color: Color.fromARGB(255, 0, 0, 0),fontSize: 10),
                        weekendStyle: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,color: Colors.black,fontSize: 10,),
                        
                      ),
                      calendarStyle: const CalendarStyle(
                        todayTextStyle:TextStyle(decoration: TextDecoration.none,color: Color.fromARGB(255, 0, 0, 0),fontSize: 12),
                          defaultTextStyle:TextStyle(color: Color.fromARGB(222, 3, 3, 3),decoration: TextDecoration.none,fontSize: 12),
                          weekendTextStyle:TextStyle(color: Color.fromARGB(255, 0, 0, 0),decoration: TextDecoration.none,fontSize: 12),
                           outsideTextStyle:TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 12),
                           selectedTextStyle:TextStyle(fontSize: 20,decoration: TextDecoration.none),
                        todayDecoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          
                          shape: BoxShape.circle
                          
                        )
                      ),
                      ),
                ],
                ),
              ),
            ),
    );
    
  }
}