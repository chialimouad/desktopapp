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
            height: 370,
            width: 320,
              decoration: BoxDecoration(color: Colors.white,
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
                        calendarFormat:CalendarFormat.month,
                        focusedDay: focusedday, firstDay: DateTime.utc(2015), lastDay: DateTime.utc(2040),
                      headerVisible: false,
                      onFormatChanged: (result){},
                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (date,locale){
                          return DateFormat("EE").format(date).toUpperCase();
                        },
                        weekdayStyle: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,color: const Color.fromARGB(255, 126, 125, 125),fontSize: 10),
                        weekendStyle: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,color: Colors.black,fontSize: 10,),
                        
                      ),
                      calendarStyle: CalendarStyle(
                        todayTextStyle:TextStyle(decoration: TextDecoration.none,color: const Color.fromARGB(255, 248, 248, 248),fontSize: 14),
                          defaultTextStyle:TextStyle(color: Color.fromARGB(222, 3, 3, 3),decoration: TextDecoration.none,fontSize: 15),
                          weekendTextStyle:TextStyle(color: const Color.fromARGB(255, 156, 155, 155),decoration: TextDecoration.none,fontSize: 15),
                           outsideTextStyle:TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 15),
                           selectedTextStyle:TextStyle(fontSize: 20,decoration: TextDecoration.none),
                        todayDecoration: BoxDecoration(
                          color: Color.fromRGBO(216, 97, 97, 1),
                          
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