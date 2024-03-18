import 'package:flutter/material.dart';
import 'package:easy_flutter_pagination/easy_flutter_pagination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'easy flutter pagination example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  int totalPages = 0;
  List<int> middlePages = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: PaginationView(
                  totalPages: totalPages,
                  currentPage: currentPage,
                  getData: (returnCurrentPage, returnedMiddlePages) async {
                    currentPage = returnCurrentPage;
                    middlePages = returnedMiddlePages;
                    // get page data
                  },
                ))
          ],
        ),
      ),
    );
  }
}
