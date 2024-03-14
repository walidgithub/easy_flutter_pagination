import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../components/components.dart';

class PaginationView extends StatefulWidget {
  int totalPages;
  int currentPage;
  
  double radius;
  double buttonHeight;
  int bounceDuration;
  double iconSize;
  double textFontSize;
  double spaceBetween;
  double padding;
  double margin;

  Function getData;

  Color selectedTextColor;
  Color unSelectedTextColor;
  
  Color firstButtonColor;
  Color lastButtonColor;
  Color middleButtonColor;
  Color activeButtonColor;
  Color prevButtonColor;
  Color nextButtonColor;
  
  Color dotsColor;
  PaginationView(
      {
        required this.totalPages,
        required this.currentPage,
        
        required this.radius,
        required this.buttonHeight,
        required this.bounceDuration,
        required this.iconSize,
        required this.textFontSize,
        required this.spaceBetween,
        required this.padding,
        required this.margin,

        required this.getData,

        required this.selectedTextColor,
        required this.unSelectedTextColor,
        
        required this.firstButtonColor,
        required this.lastButtonColor,
        required this.middleButtonColor,
        required this.activeButtonColor,
        required this.prevButtonColor,
        required this.nextButtonColor,
        
        required this.dotsColor,
        Key? key})
      : super(key: key);

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  int currentPage = 1;
  List<int> middlePages = [];

  @override
  void didUpdateWidget(PaginationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPage != oldWidget.currentPage) {
      currentPage = widget.currentPage;
    }
  }

  @override
  void initState() {
    if (widget.totalPages != 0) {
      middlePages = [];

      if (widget.totalPages >= 5) {
        middlePages = [widget.currentPage + 1, widget.currentPage + 2, widget.currentPage + 3];
      } else {
        for (int i = 1; i < widget.totalPages - 1; i++) {
          middlePages.add(i + 1);
        }
      }
    } else {
      widget.currentPage = 0;
      middlePages = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // decrease current page
        Bounceable(
            duration: Duration(milliseconds: widget.bounceDuration),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration));
              if (currentPage >= 2) {
                currentPage--;

                if (widget.totalPages >= 5) {
                  if (currentPage == middlePages[0] &&
                      (currentPage - 1) != 1 &&
                      widget.totalPages >= 5) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }

                  if (currentPage == middlePages[1] &&
                      (currentPage + 2) != widget.totalPages) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }

                  if (currentPage == middlePages[2] &&
                      (currentPage + 1) != widget.totalPages) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }
                }
              }
              widget.getData(currentPage, middlePages);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: widget.iconSize,
              color: currentPage > 1
                  ? widget.prevButtonColor
                  : widget.prevButtonColor.withOpacity(0.5),
            )),

        // current page = 1
        Bounceable(
            duration: Duration(milliseconds: widget.bounceDuration),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration));

              currentPage = 1;

              if (widget.totalPages >= 5) {
                middlePages = [
                  currentPage + 1,
                  currentPage + 2,
                  currentPage + 3
                ];
              }

              widget.getData(currentPage, middlePages);
            },
            child: containerComponent(
                context,
                Center(
                  child: Text('1',
                      style: TextStyle(
                          color: currentPage == 1
                              ? widget.selectedTextColor
                              : widget.unSelectedTextColor,
                          fontSize: widget.textFontSize)),
                ),
                height: widget.buttonHeight,
                color: currentPage == 1
                    ? widget.activeButtonColor
                    : widget.firstButtonColor,
                borderColor: widget.firstButtonColor,
                borderWidth: 0.0,
                borderRadius: widget.radius)),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
            ? middlePages[0] - 1 > 1
            ? Text(
          ' ..',
          style: TextStyle(
              color: widget.dotsColor, fontSize: widget.textFontSize),
        )
            : Container()
            : Container()
            : Container(),

        currentPage > 1
            ? const SizedBox(
          width: 1,
        )
            : Container(),

        // middle current pages
        Row(
          children: [
            SizedBox(
              height: widget.buttonHeight,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: middlePages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Bounceable(
                          duration: Duration(
                              milliseconds: widget.bounceDuration),
                          onTap: () async {
                            await Future.delayed(Duration(
                                milliseconds:
                                widget.bounceDuration));

                            currentPage = middlePages[index];
                            if (widget.totalPages >= 5) {
                              if (currentPage == middlePages[0] &&
                                  (currentPage - 1) != 1) {
                                middlePages = [];
                                middlePages = [
                                  currentPage - 1,
                                  currentPage,
                                  currentPage + 1
                                ];
                              }

                              if (currentPage == middlePages[1] &&
                                  (currentPage + 2) != widget.totalPages) {
                                middlePages = [];
                                middlePages = [
                                  currentPage - 1,
                                  currentPage,
                                  currentPage + 1
                                ];
                              }

                              if (currentPage == middlePages[2] &&
                                  (currentPage + 1) != widget.totalPages) {
                                middlePages = [];
                                middlePages = [
                                  currentPage - 1,
                                  currentPage,
                                  currentPage + 1
                                ];
                              }
                            }
                            widget.getData(currentPage, middlePages);
                          },
                          child: containerComponent(
                              context,
                              margin: EdgeInsets.only(left: widget.margin),
                              Center(
                                  child: Text(middlePages[index].toString(),
                                      style: TextStyle(
                                          color:
                                          currentPage == middlePages[index]
                                              ? widget.selectedTextColor
                                              : widget.unSelectedTextColor,
                                          fontSize: widget.textFontSize))),
                              padding: EdgeInsets.fromLTRB(
                                  middlePages[index].toString().length > 1 ? widget.padding * 2 : widget.padding,
                                  0,
                                  middlePages[index].toString().length > 1 ? widget.padding * 2 : widget.padding,
                                  0),
                              color: currentPage == middlePages[index]
                                  ? widget.activeButtonColor
                                  : widget.middleButtonColor,
                              borderColor: currentPage == middlePages[index]
                                  ? widget.activeButtonColor
                                  : widget.middleButtonColor,
                              borderWidth: 0.0,
                              borderRadius: widget.radius))
                    ],
                  );
                },
              ),
            ),
          ],
        ),

        SizedBox(
          width: widget.spaceBetween,
        ),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
            ? middlePages[2] < widget.totalPages - 1
            ? Text(
          '..',
          style: TextStyle(
              color: widget.dotsColor, fontSize: widget.textFontSize),
        )
            : Container()
            : Container()
            : Container(),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
            ? middlePages[2] < widget.totalPages - 1
            ? SizedBox(
          width: widget.spaceBetween,
        )
            : Container()
            : Container()
            : Container(),

        // last current page
        widget.totalPages > 1
            ? Row(
          children: [
            Bounceable(
                duration: Duration(
                    milliseconds: widget.bounceDuration),
                onTap: () async {
                  await Future.delayed(Duration(
                      milliseconds: widget.bounceDuration));

                  currentPage = widget.totalPages;

                  if (widget.totalPages >= 5) {
                    middlePages = [
                      currentPage - 3,
                      currentPage - 2,
                      currentPage - 1
                    ];
                  }

                  widget.getData(currentPage, middlePages);
                },
                child: containerComponent(
                    context,
                    Center(
                      child: Text(widget.totalPages.toString(),
                          style: TextStyle(
                              color: currentPage == widget.totalPages
                                  ? widget.selectedTextColor
                                  : widget.unSelectedTextColor,
                              fontSize: widget.textFontSize)),
                    ),
                    height: widget.buttonHeight,
                    padding: EdgeInsets.fromLTRB(
                        widget.totalPages.toString().length > 1 ? widget.padding * 2 : widget.padding,
                        0,
                        widget.totalPages.toString().length > 1 ? widget.padding * 2 : widget.padding,
                        0),
                    color: widget.totalPages == currentPage
                        ? widget.activeButtonColor
                        : widget.lastButtonColor,
                    borderColor: widget.totalPages == currentPage
                        ? widget.activeButtonColor
                        : widget.lastButtonColor,
                    borderWidth: 0.0,
                    borderRadius: widget.radius))
          ],
        )
            : Container(),

        widget.totalPages > 1
            ? SizedBox(
          width: widget.spaceBetween,
        )
            : Container(),

        // increase current page
        Bounceable(
            duration: Duration(milliseconds: widget.bounceDuration),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration));

              if (currentPage < widget.totalPages) {
                currentPage++;
                if (widget.totalPages >= 5) {
                  if (currentPage == middlePages[0] && (currentPage - 1) != 1) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }

                  if (currentPage == middlePages[1] &&
                      (currentPage + 2) != widget.totalPages) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }

                  if (currentPage == middlePages[2] &&
                      (currentPage + 1) != widget.totalPages) {
                    middlePages = [];
                    middlePages = [
                      currentPage - 1,
                      currentPage,
                      currentPage + 1
                    ];
                  }
                }
              }
              widget.getData(currentPage, middlePages);
            },
            child: Icon(Icons.arrow_forward_ios,
                size: widget.iconSize,
                color: currentPage == widget.totalPages
                    ? widget.nextButtonColor.withOpacity(0.5)
                    : widget.nextButtonColor)),
      ],
    );
  }
}
