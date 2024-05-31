import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:deskapp/barchat/Headerwidget.dart';
import 'package:deskapp/barchat/headerwidget2.dart';
import 'package:deskapp/bargraph/linechart.dart';
import 'package:deskapp/bargraph/mybargraph.dart';
import 'package:deskapp/bargraph/piechart.dart';
import 'package:deskapp/screens/desk.dart';
import 'package:deskapp/screens/homelogin.dart';
import 'package:deskapp/screens/test2.dart';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class PatientData {
final String sensor;
final int value;
final DateTime timestamp;

PatientData({
required this.sensor,
required this.value,
required this.timestamp,
});

factory PatientData.fromJson(Map<String, dynamic> json) {
return PatientData(
sensor: json['patientId'] ?? '',
value: json['bpm'] ?? 0,
timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
);
}
}
class Allpatient extends StatefulWidget {
final String token;
final PatientData? patient;
const Allpatient({required this.token, Key? key,  this.patient,}) : super(key: key);

@override
State<Allpatient> createState() => _AllpatientState();
}

class _AllpatientState extends State<Allpatient> with SingleTickerProviderStateMixin {
late StreamController<List> _streamController;
late Stream<List<dynamic>> _combinedStream;
final formKey = GlobalKey<FormState>();

bool isconnected=false;
bool isdata=false;
TextEditingController _patientIDController = TextEditingController();
StreamController<PatientData> streamController = StreamController<PatientData>();
bool isLoading = false;
bool _showTextField = true;
bool _isUserAdded = false;

late String _lastPatientID='';
late List<FlSpot> ecgData; 
final List<double> ecgData1 = [];
late Timer timer;
double lastECGValue = 0.0;
//late Timer _lineChartTimer; 
  Timer? timer1;

// void _startChartDataTimer() {
//   const duration = Duration(seconds: 1); // Adjust the duration as needed
//   Timer.periodic(duration, (timer) {
//     // Call the method to update chart data here
//    // updateChartData();
//   });
// }
// // void updateChartData() {
//   setState(() {
//     lineChartData = frequency(_patientDataList);
//   });
// }
// Function to save pulseid in SharedPreferences

// Function to load pulseid from SharedPreferences
Future<List<String>> loadPatientIds() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getStringList('patientIds') ?? [];
}


late List userPatientIds;
  List<PatientData> patientDataList = [];

void getUserPatientIds() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> userPatientIds = prefs.getStringList(userId) ?? [];
  setState(() {
    userPatientIds = userPatientIds;
  });
}
   
PhoneNumber phoneNumber = PhoneNumber(isoCode: 'DZA '); 
TextEditingController email = TextEditingController();
TextEditingController Fullname = TextEditingController();
TextEditingController Willaya = TextEditingController();
TextEditingController Password = TextEditingController();
TextEditingController mldcontroller = TextEditingController();
TextEditingController IdOfpulse = TextEditingController();
TextEditingController pulseid = TextEditingController();

late SharedPreferences prefs;
late String userId;

late String patid;
late String docname;


initShared() async {
prefs = await SharedPreferences.getInstance();

}

Map<String, bool> addedItemIds = {};

Widget buttonclicked( String id , String idpulse){
return Column(
  children: [
                isopen==false ? IconButton(
                    onPressed: () {
                     
                       setState(() {
                         isopen=true;
                         isclick=true;
                       });
                     
                    },
                    icon:  Icon(Icons.remove_red_eye_sharp, color: const Color.fromARGB(255, 0, 0, 0)),
                  ):SizedBox(height: 1,),
                       isclick==true && isopen && idpulse==pulseid.text ?  IconButton(
                    onPressed: () {
                     
                       setState(() {
                         isopen=false;
                       });
                     
                    },
                    icon:  Icon(Icons.remove_red_eye_sharp, color: const Color.fromARGB(255, 0, 0, 0)),
                  ):SizedBox(height: 1,),
],);
}

Widget _buildPatientDataTable() {
  return StreamBuilder<List<dynamic>>(
    stream: _combinedStream,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final List items = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            int numpat=items.length;
            print(numpat);

            return Column(
              children: [
                _buildDataRow(item, index),
                if (isopen && '${item['idpulse']}'==pulseid.text)
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            width: 1000,
                            child: LineChart(
                              frequency(_patientDataList),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(height: 1),
              ],
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(color: Colors.red,),
        );
      }
    },
  );
}
 
   age(int year){
    return DateTime.now().year-year;
  }

// Update the condition for displaying the add button to check the added state for each item
Widget _buildDataRow(Map<String, dynamic> item, int index) {
  String patientId = item['idpulse'];
  
  // Retrieve savedIds from SharedPreferences
  List<String> savedIds = prefs.getStringList('saved_ids') ?? [];

  if (addedItemIds.containsKey(item['_id'])) {
    addedItemIds[item['idpulse']] = savedIds.contains(item['idpulse']); // Check if the current item's id is in savedIds
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DataTable(
        columns: [
          DataColumn(label: Text('Full Name')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Willaya')),
          DataColumn(label: Text('Phone Number')),
          DataColumn(label: Text('BPM')),
          DataColumn(label: Text('Moy')),
           DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('${item['fullname']}')),
            DataCell(Text('${age(item['year'])}')),
            DataCell(Text('${item['willaya']}')),
            DataCell(Text('${item['phonenumber']}')),

            DataCell(StreamBuilder<PatientData>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && '${item['idpulse']}' == "admin1234") {
                  return Text('${snapshot.data!.value ?? 'Na' }');
                } else {
                  return Text('NA');
                }
              },
            )),

            DataCell(Text('${'${item['idpulse']}' == "admin1234" && (addedItemIds[item['_id']] ?? false) ? _calculateAverageBPM().toStringAsFixed(2) : 'NA'}')),
                                                DataCell(CircleAvatar(radius: 5, backgroundColor: isconnected? Colors.green : Colors.red)),

            DataCell(
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      deleteuser('${item['_id']}');
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () {
                      showMyDialog('${item['fullname']}', '${age(item['year'])}', '${item['willaya']}', '${item['phonenumber']}', '${item['docname']}','${item['idpulse']}');
                    },
                    icon: Icon(Icons.more),
                  ),
                  addedItemIds[item['_id']] ?? false 
                      ? buttonclicked('${item['_id']}', '${item['idpulse']}')
                      : SizedBox(height: 1,),
                  !(addedItemIds[item['_id']] ?? false) // Check the added state for the current item
                      ? IconButton(
                          onPressed: () {
                              buttonadd(context,item['_id'], item['idpulse']);
                            
                          },
                          icon: Icon(Icons.add),
                        )
                      : SizedBox(height: 1,),
                ],
              ),
            ),
          ]),
        ],
      ),
      SizedBox(height: 16), // Add some space between the tables
    ],
  );
}



// void addUserPatientId(String usid, String patientId) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> userPatientIds = prefs.getStringList(usid) ?? [];
//   userPatientIds.add(patientId);
//   await prefs.setStringList(usid, userPatientIds);
// }

updatedata(String id) async {


var regbody = {
"email": email.text,
"fullname": Fullname.text,
"phonenumber": phoneNumber.phoneNumber,
"willaya": Willaya.text,
"password": Password.text,
"idpulse": IdOfpulse.text,
"id":id

};
var res = await http.post(Uri.parse("https://s4db.onrender.com/12/update"),
headers: {"Content-Type":"application/json"},
body: jsonEncode(regbody)
);
var resjson = jsonDecode(res.body);
print(res.body);
if (resjson['status']) {

getuser(userId)   ;    
AwesomeDialog(
context: context,
dialogType: DialogType.success,
animType: AnimType.bottomSlide,
title: 'Success',
desc: 'User updated successfully!',
btnOkOnPress: () {},
)..show();
} else {
AwesomeDialog(
context: context,
dialogType: DialogType.error,
animType: AnimType.bottomSlide,
title: 'Error',
desc: 'Failed to update user!',
btnOkOnPress: () {},
)..show();
}

}
 late Timer _heartRateTimer;
  List<FlSpot> _heartRateData = [];
   bool _isRegular = true;
 late LineChartData lineChartData;
  late Timer timer11;

bool? isselected = false;
bool? isemail = false;
bool? isalphapulse = false;
bool? isalpha = false;
bool? iskayen = false;
  List<PatientData> _patientDataList = [];
bool isopen =false;
bool isclick=false;
@override
void initState() {
super.initState();

   loadPatientIds().then((patientIds) {
 
  });
  _heartRateTimer = Timer.periodic(Duration(seconds: 10), (timer) {
  });
  lineChartData = _buildCardiacRhythmChartData(_patientDataList);
    timer11 = Timer.periodic(Duration(seconds :10), (timer11) {
      setState(() {
        lineChartData = _buildCardiacRhythmChartData(_patientDataList);
      });
    });
initShared(); // Call initShared() method to initialize prefs
 _storePatientID(pulseid.text);
_startTimer();
//_startChartDataTimer();
_streamController = StreamController<List>.broadcast();

// _timer = Timer.periodic(Duration(seconds: 2), (timer) {
// double t = timer.tick.toDouble();

// });
_combinedStream = _streamController.stream.transform(combineStreams);
  streamController = StreamController<PatientData>.broadcast();
final jwtDecodedToken = JwtDecoder.decode(widget.token);
userId = jwtDecodedToken['id'];

getuser(userId);
print(userId);
// _lineChartTimer = Timer.periodic(Duration(seconds: 2), (timer) {
// double t = timer.tick.toDouble();
// });
//_lineChartTimer.cancel();

}
 StreamTransformer<List<dynamic>, List<dynamic>> combineStreams =
      StreamTransformer<List<dynamic>, List<dynamic>>.fromHandlers(
    handleData: (data, sink) {
      List<dynamic> combinedData = [];
      combinedData.addAll(data); // Add data from the first stream
      sink.add(combinedData); // Emit the combined data
    },
  );





@override
void dispose() {
_streamController.close();
    _heartRateTimer.cancel();

//_timer.cancel();
timer.cancel();
    timer11.cancel();

streamController.close();
super.dispose();
}

void _startTimer() {
  timer = Timer.periodic(Duration(seconds: 10), (timer) {
    if (!isLoading && !_showTextField) {
      fetchDataForPatient();
    }
  });
}
void _startTimer1() {
  timer = Timer.periodic(Duration(seconds: 10), (timer) {
    if (!isLoading && !_showTextField) {
      frequency(patientDataList);
    }
  });
}


Future<void> _storePatientID(String patientID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> patientIDs = prefs.getStringList('patientIDs') ?? [];
  patientIDs.add(patientID);
  await prefs.setStringList('patientIDs', patientIDs);
}

  
Future<void> fetchDataForPatient() async {
  final String patientID = pulseid.text;
  
  try {
    final response = await http.get(Uri.parse('http://192.168.1.4:8080/data/$patientID'));

    if (response.statusCode == 200) {
      setState(() {
        isconnected=true;
      });
      final responseData = json.decode(response.body);
      final patientData = PatientData.fromJson(responseData[0]);
      _patientDataList.add(patientData);
      if (!streamController.isClosed) { // Check if the stream controller is closed
        streamController.add(patientData);

      }
      setState(() {
        _showTextField = false;
        _lastPatientID = patientID;
      });

      // Save the patient ID to SharedPreferences for the current user
    } else if (response.statusCode == 404) {
      // Handle 404 error
    } else {
      // Handle other errors
    }
  } catch (e) {
    // Handle the exception
    print('Error fetching data: $e');
  }
}









double _calculateAverageBPM() {
    if (_patientDataList.isEmpty) return 0;
    int sum = _patientDataList.map((data) => data.value).reduce((value, element) => value + element);
    return sum / _patientDataList.length;
    
  }
void getuser(String userId) async {
try {
final regbody = {
"userId": userId,
};
final response = await http.post(
Uri.parse("https://s4db.onrender.com/12/getuser"),
headers: {"Content-Type": "application/json"},
body: jsonEncode(regbody),
);
final newtoken = jsonDecode(response.body);
_streamController.sink.add(newtoken['success']);
} catch (err) {

}
}
LineChartData _heartRateLineChart(List<PatientData> patientDataList) {
  List<FlSpot> spots = [];

  // Calculate the rythm cardiaque
  for (int i = 1; i < patientDataList.length; i++) {
    final patientData1 = patientDataList[i - 1];
    final patientData2 = patientDataList[i];
    double timeDifference = i.toDouble(); // Assuming the data is evenly spaced
    double rythmCardiaque = 60.0 / timeDifference; // Calculate beats per minute

    spots.add(FlSpot(i.toDouble(), rythmCardiaque));
  }

  return LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: _determineColor(spots),
        barWidth: 2,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        dotData: FlDotData(show: false),
      ),
    ],
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(show: true),
    gridData: FlGridData(show: true),
  );
}

// Determine color based on rythm cardiaque range
Color _determineColor(List<FlSpot> spots) {
  double avgRythmCardiaque = 0;
  for (var spot in spots) {
    avgRythmCardiaque += spot.y;
  }
  avgRythmCardiaque /= spots.length;

  if (avgRythmCardiaque < 60 || avgRythmCardiaque > 100) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}

 LineChartData frequency(List<PatientData> patientDataList) {
  if (patientDataList.isEmpty) {
    return LineChartData();  }

  List<FlSpot> spots = [];
  for (int i = 0 ;  i < patientDataList.length; i++) {
    final patientData = patientDataList[i];
    spots.add(FlSpot(i.toDouble(), patientData.value.toDouble()));
  }

  return LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: false,
        color: patientDataList.first.value.toDouble() < 60 || patientDataList.first.value.toDouble() > 100 ? Colors.red : Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        dotData: FlDotData(show: false),
      ),
    ],
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(show: true),
    gridData: FlGridData(show: true),
  );
}



LineChartData _buildCardiacRhythmChartData(List<PatientData> patientDataList) {
  const double samplingRate = 50; // Sampling rate in Hz

  List<FlSpot> spots = [];
  
  // Calculate the time of the latest data point
  double latestTime = patientDataList.length.toDouble() / samplingRate;

  // Start index for updating the chart in real-time
  int startIndex = patientDataList.length - (samplingRate * 10).toInt(); // Last 10 seconds of data

  // Limit the start index to avoid negative values
  startIndex = startIndex < 0 ? 0 : startIndex;

  // Calculate the threshold for regularity
  double regularityThreshold = 0.1; // Adjust as needed

  // List to store the differences between successive R peaks
  List<double> rrIntervals = [];
double generateECGWaveform(double time, double heartPeriod) {
  double pWave = 0.2 * math.sin(2 * math.pi * (1 / (heartPeriod * 0.16)) * time);
  double qrsComplex = 0.8 * math.sin(2 * math.pi * (1 / (heartPeriod * 0.32)) * time);
  double tWave = 0.4 * math.sin(2 * math.pi * (1 / (heartPeriod * 0.48)) * time);
  
  // Combine the waves to form a simplified ECG signal
  return pWave + qrsComplex + tWave;
}

  // Iterate through the patient data list
  for (int i = startIndex; i < patientDataList.length; i++) {
    final patientData = patientDataList[i];
    double heartRate = patientData.value.toDouble(); // Heart rate in beats per minute
    double heartPeriod = 60 / heartRate; // Heart period in seconds
    double time = i / samplingRate; // Time in seconds

    // Generate a simplified ECG waveform
    double ecgSignal = generateECGWaveform(time, heartPeriod);

    // Add the ECG signal to the spots list
    spots.add(FlSpot(time, ecgSignal));

    // Calculate the time since the last R peak
double timeSinceLastRPeak = time - (rrIntervals.isNotEmpty ? rrIntervals.last : 0);

    // Check if an R peak is detected
    if (ecgSignal >= 0.8) { // Assuming R peak is detected when ECG signal is above a certain threshold
      // Store the time since the last R peak
      rrIntervals.add(timeSinceLastRPeak);
    }
  }

  // Check regularity based on variability of RR intervals
  bool isRegular = true;
  if (rrIntervals.length > 1) {
    double meanRRInterval = rrIntervals.reduce((a, b) => a + b) / rrIntervals.length;
    double variance = rrIntervals.map((interval) => (interval - meanRRInterval) * (interval - meanRRInterval)).reduce((a, b) => a + b) / rrIntervals.length;
    if (variance > regularityThreshold) {
      isRegular = false;
    }
  }

  // Determine the line color based on regularity
  Color lineColor = isRegular ? Colors.green : Colors.red;

  return LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: lineColor,
        barWidth: 2,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
        dotData: FlDotData(show: false),
      ),
    ],
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTitlesWidget: (value, meta) {
            return Text('${value.toInt()}s');
          },
        ),
      ),
    ),
    borderData: FlBorderData(show: true),
    gridData: FlGridData(show: true),
  );
}


int _getMinBPM() {
    if (_patientDataList.isEmpty) return 0;
    return _patientDataList.map((data) => data.value).reduce(math.min);
  }

  int _getMaxBPM() {
    if (_patientDataList.isEmpty) return 0;
    return _patientDataList.map((data) => data.value).reduce(math.max);
  }
void deleteuser(String id) async {
                                               Provider.of<UserCountModel>(context, listen: false).minuser();

final regbody = {
"id": id,
};
final res = await http.post(
Uri.parse("https://s4db.onrender.com/12/delete"),
headers: {"Content-Type": "application/json"},
body: jsonEncode(regbody),
);
final neww = jsonDecode(res.body);
if (neww['status']) {
getuser(userId);
}
}

@override
Widget build(BuildContext context) {
          Provider.of<status>(context, listen: false).redgreen(isconnected);

  

   double averageBPM = _calculateAverageBPM();
    Provider.of<AverageBPMModel>(context, listen: false).setAverageBPM(averageBPM);
        Provider.of<notifbpm>(context, listen: false).setAverageBPM(averageBPM);

return Scaffold(
body: Column(
children: [
Container(
height: 70,
width: double.maxFinite,
color: Colors.white,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Headerwidget(),
)),

Expanded(
child: Container(
height: double.maxFinite,
width: double.maxFinite,
color: Colors.white,
child: ListView(
  children: [Column(
  children: [
    
  Center(child: _buildPatientDataTable()),
  
  
  
  ],
  ),]
),
),
),
],
),
);
}
  List<String> savedIds = [];
  Future<void> _loadSavedIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedIds = prefs.getStringList('saved_ids') ?? [];
    });
  }
  Future<void> _saveIdsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_ids', savedIds);
  }
Future<void> saveIdToPrefs(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

bool isadded =false;
Future<void> buttonadd(BuildContext context, String id, String idpls) async {
  try {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: pulseid,
                  decoration: InputDecoration(
                    labelText: 'Enter id',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        String newId = pulseid.text;
                        if (newId.isNotEmpty) {
                          if (!savedIds.contains(newId)) {
                            savedIds.add(newId);
                            await _saveIdsToPrefs();
                          } else {
                            // Show error message or handle the case where the id already exists
                            print('Id already exists');
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: 'ERROR',
                              desc: 'ID already exists!',
                              btnOkOnPress: () {},
                            ).show();
                            return;
                          }
                        }

                        if (idpls == newId) {
                          await saveIdToPrefs(id, idpls); // Save to SharedPreferences
                          setState(() {
                            addedItemIds[id] = true; // Update the added state for the item
                          });
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title: 'Success',
                            desc: 'ID added successfully!',
                            btnOkOnPress: () {
                              Navigator.of(context).pop();
                            },
                          ).show();
                          fetchDataForPatient();
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: 'ERROR',
                            desc: 'ID error!',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    print('Error displaying dialog: $e');
  }
}







Future<void> showMyDialog(String name, String age, String willaya, String Number,String docname,String id) async {
  try {
    
  
await showDialog<void>(
context: context,
barrierDismissible: false,
builder: (BuildContext context) {
return Dialog.fullscreen(
child: ListView(
children: [
Column(
children: [
WindowTitleBarBox(
child: Column(
children: [
Expanded(child: MoveWindow()),
],
),
),
Container(
height: 40,
width: double.maxFinite,
child:
Headerwidget2(),



),
    IconButton(
                                onPressed: () {
                                  showupdate(name,age,willaya,Number,id,docname);
                                },
                                icon: Icon(Icons.update),
                              ),
IconButton(
onPressed: () {
_showTextField=true;

},
icon: Icon(Icons.link_off, color: Colors.black),
),
SizedBox(width: 40,),
Row(
crossAxisAlignment: CrossAxisAlignment.end,
mainAxisAlignment: MainAxisAlignment.end,
children: [

],
),

Container(
color: Colors.white10,
child: Column(
children: [
Row(
children: [
SizedBox(width: 20,),
Icon(Icons.person),
Text("  name :$name"),
SizedBox(width: 20,),
Icon(Icons.timeline),
Text("  age :$age"),
],
),
SizedBox(height: 20,),
Row(
children: [
SizedBox(width: 20,),
Icon(Icons.streetview),
Text("willaya :$willaya"),
SizedBox(width: 20,),
Icon(Icons.phone),
Text(" Phone Number  :+$Number"),

],
),
Text(" The Name of Doctor :$docname",style: TextStyle(color: Colors.black,fontSize: 15),),
SizedBox(height: 40,),
Column(
children: [

],
)
],
),
),
SizedBox(height: 40,),
Center(
      child:
                        Container(
                          height: 350,
                          width: 1000,
                          child: id==pulseid.text?LineChart(
                            _heartRateLineChart(_patientDataList),
                          ):Container(),
                        ),
                        
),
SizedBox(height: 60,),
Center(
child: Container(
child: Container(


child: Container(

decoration: BoxDecoration(color: const Color.fromARGB(112, 255, 255, 255), borderRadius: BorderRadius.circular(20)),
child:      Container(
                          height: 350,
                          width: 1000,
                          child: id==pulseid.text?LineChart(
                            frequency(_patientDataList)
                          ):Container(),
                        ),
),
),
),),


SizedBox(height: 200,),
 Container(
                          height: 350,
                          width: 1000,
                          child: id==pulseid.text?LineChart(
                           _heartRateLineChart (_patientDataList)
                          ):Container(),
                        ),
SizedBox(height: 200,)
],
),
],
),
);
},
);} catch (e) {
        print('Error displaying dialog: $e');

  }
}





Future<void> showupdate(String id,String Email, String fullname, String willaya, String phone,String idpulse) async {
return showDialog<void>(
context: context,
barrierDismissible: false,
builder: (BuildContext context) {
return Dialog.fullscreen(
child: ListView(
children: [
Column(
children: [

Container(
width: double.maxFinite,
height: 60,
child: Headerwidget2()),
Container(
width: 500,
child: Form(
key: formKey,
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
children: [

TextFormField(
validator: (value){
if(value == null || value.isEmpty){
return "Please insert valid email";
}
},
cursorColor: isemail! ? Colors.green : Colors.red,
controller: email,
autofocus: true,
onChanged: (val){
setState(() {
isemail = isEmail(val);
});
},
decoration: InputDecoration(
hintText: "Email of patient",
labelText: "Email:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
),
),
SizedBox(height: 20,),
TextFormField(
validator: (value){
if(value == null || value.isEmpty){
if(value!.length <= 6){
return "Please Must be Less than 16 Letters";
}
}
},
cursorColor: isemail! ? Colors.green : Colors.red,
obscureText: false,
controller: Fullname,
onChanged: (val){
setState(() {
isemail = isAlpha(val);
});
},
decoration: InputDecoration(
labelText: "FullName:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
),
),
SizedBox(height: 10,),
TextFormField(
validator: (value){
if(value == null || value.isEmpty){
return "Please Complete";
}
},
cursorColor: isemail! ? Colors.green : Colors.red,
obscureText: false,
controller: Willaya,
decoration: InputDecoration(
labelText: "Wilaya:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
),
),
SizedBox(height: 20,),
TextFormField(
validator: (value){
if(value == null || value.isEmpty){
return "Password field null";
}
},
cursorColor: isemail! ? Colors.green : Colors.red,
obscureText: true,
controller: Password,
decoration: InputDecoration(
labelText: "Password:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
),
),
SizedBox(height: 20,),
TextFormField(
onChanged: (val){
setState(() {
isalphapulse = isAlphanumeric(val);
});
},
validator: (value){
if(value == null || value.isEmpty){
return "complete the field";
}
},
obscureText: false,
controller: IdOfpulse,
decoration: InputDecoration(
labelText: "Id Of pulse:",
border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
),
),
SizedBox(height: 10,),
InternationalPhoneNumberInput( 
onInputChanged: (PhoneNumber number) { 
phoneNumber = number; 
}, 
selectorConfig: SelectorConfig( 
selectorType: PhoneInputSelectorType.DIALOG, 
), 
ignoreBlank: false, 
autoValidateMode: AutovalidateMode.onUserInteraction, 
selectorTextStyle: TextStyle(color: Colors.black), 
initialValue: phoneNumber, 
textFieldController: TextEditingController(), 
inputDecoration: InputDecoration( 
labelText: 'Phone Number', 
border: OutlineInputBorder(), 
), 
formatInput: false, 
),
SizedBox(height: 50,),
ElevatedButton(onPressed: (){
updatedata(id);
}, child: Text("Update"))
],
),
),
),





],
),
],
),
);
},
);
}
}
