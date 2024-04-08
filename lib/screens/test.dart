import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchValue = '';
  final List<String> _suggestions = ['Afeganistan', 'Albania', 'Algeria', 'Australia', 'Brazil', 'German', 'Madagascar', 'Mozambique', 'Portugal', 'Zambia'];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: EasySearchBar(
            title: const Text('Example'),
            onSearch: (value) => setState(() => searchValue = value),
            suggestions: _suggestions
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () => Navigator.pop(context)
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () => Navigator.pop(context)
                )
              ]
            )
          ),
          body: Center(
            child: Text('Value: $searchValue')
          )
        ),
      )
    );
  }
}