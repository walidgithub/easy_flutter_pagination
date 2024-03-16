<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This component is designed for implementing pagination in Flutter.

![OpenAI Logo](https://ibb.co/VvP9j83)


## Getting started

This package requires you to provide the current page number, total number of pages, and the function responsible for fetching data on a per-page basis,
you can add other properties like colors, padding, font size, width and others.
## Example

```dart
import 'package:flutter/material.dart';

import 'components/custome_pagination.dart';

class PaginationExample extends StatefulWidget {
  int currentPage;
  int totalPages;
  List<int> middlePages;
  PaginationExample({required this.currentPage, required this.totalPages, required this.middlePages, Key? key}) : super(key: key);

  @override
  State<PaginationExample> createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  int currentPage = 1;
  int totalPages = 10;
  List<int> middlePages = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: PaginationView(
          totalPages: totalPages,
          currentPage: currentPage,
          getData: (returnCurrentPage,
              returnedMiddlePages) async {
            currentPage = returnCurrentPage;
            middlePages = returnedMiddlePages;
            await getPageData(currentPage);
          },
        ));
  }

  Future<void> getPageData(int currentPage) async {
    // fetch data
  }
}

class TestPagination extends StatefulWidget {
  const TestPagination({Key? key}) : super(key: key);

  @override
  State<TestPagination> createState() => _TestPaginationState();
}

class _TestPaginationState extends State<TestPagination> {
  int currentPage = 1;
  int totalPages = 100;

  @override
  Widget build(BuildContext context) {
    return PaginationExample(currentPage: currentPage, totalPages: totalPages, middlePages: []);
  }
}
```

## Follow me in LinkedIn
https://www.linkedin.com/in/walidbarakat1985/
