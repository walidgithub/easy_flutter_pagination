import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../components/components.dart';

class PaginationView extends StatefulWidget {
  int totalPages;
  int currentPage;
  Function getData;

  final radius;
  final buttonHeight;
  final bounceDuration;
  final iconSize;
  final textFontSize;
  final spaceBetween;
  final normalWidth;
  final padding;
  final margin;

  final selectedTextColor;
  final unSelectedTextColor;

  final firstButtonColor;
  final lastButtonColor;
  final middleButtonColor;
  final activeButtonColor;
  final prevAndNextButtonColor;
  final dotsColor;
  PaginationView(
      {required this.totalPages,
      required this.currentPage,
      required this.getData,
      this.radius,
      this.buttonHeight,
      this.bounceDuration,
      this.iconSize,
      this.textFontSize,
      this.spaceBetween,
      this.padding,
      this.margin,
      this.normalWidth,
      this.selectedTextColor,
      this.unSelectedTextColor,
      this.firstButtonColor,
      this.lastButtonColor,
      this.middleButtonColor,
      this.activeButtonColor,
      this.prevAndNextButtonColor,
      this.dotsColor,
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
        middlePages = [
          widget.currentPage + 1,
          widget.currentPage + 2,
          widget.currentPage + 3
        ];
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
            duration: Duration(milliseconds: widget.bounceDuration ?? 300),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration ?? 300));
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
              size: widget.iconSize ?? 25,
              color: currentPage > 1
                  ? widget.prevAndNextButtonColor ?? const Color(0xFF84BD93)
                  : widget.prevAndNextButtonColor ??
                      const Color(0xFF84BD93).withOpacity(0.5),
            )),

        // current page = 1
        Bounceable(
            duration: Duration(milliseconds: widget.bounceDuration ?? 300),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration ?? 300));

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
                              ? widget.selectedTextColor ??
                                  const Color(0xFFE6DCCD)
                              : widget.unSelectedTextColor ??
                                  const Color(0xFFFFFFFF),
                          fontSize: widget.textFontSize ?? 20)),
                ),
                height: widget.buttonHeight ?? 30,
                width: widget.normalWidth ?? 30,
                color: currentPage == 1
                    ? widget.activeButtonColor ?? const Color(0xFF84BD93)
                    : widget.firstButtonColor ?? const Color(0xFFFD9A2B),
                borderColor: widget.firstButtonColor ?? const Color(0xFFFD9A2B),
                borderWidth: 0.0,
                borderRadius: widget.radius ?? 5)),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
                ? middlePages[0] - 1 > 1
                    ? Text(
                        ' ..',
                        style: TextStyle(
                            color: widget.dotsColor ?? const Color(0xFF84BD93),
                            fontSize: widget.textFontSize ?? 20),
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
              height: widget.buttonHeight ?? 30,
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
                              milliseconds: widget.bounceDuration ?? 300),
                          onTap: () async {
                            await Future.delayed(Duration(
                                milliseconds: widget.bounceDuration ?? 300));

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
                              margin: EdgeInsets.only(left: widget.margin ?? 2),
                              Center(
                                  child: Text(middlePages[index].toString(),
                                      style: TextStyle(
                                          color: currentPage ==
                                                  middlePages[index]
                                              ? widget.selectedTextColor ??
                                                  const Color(0xFFE6DCCD)
                                              : widget.unSelectedTextColor ??
                                                  const Color(0xFFFFFFFF),
                                          fontSize:
                                              widget.textFontSize ?? 20))),
                              padding: EdgeInsets.fromLTRB(widget.padding ?? 10,
                                  0, widget.padding ?? 10, 0),
                              color: currentPage == middlePages[index]
                                  ? widget.activeButtonColor ??
                                      const Color(0xFF84BD93)
                                  : widget.middleButtonColor ??
                                      const Color(0xFFE6DCCD),
                              borderColor: currentPage == middlePages[index]
                                  ? widget.activeButtonColor ??
                                      const Color(0xFF84BD93)
                                  : widget.middleButtonColor ??
                                      const Color(0xFFE6DCCD),
                              borderWidth: 0.0,
                              borderRadius: widget.radius ?? 5))
                    ],
                  );
                },
              ),
            ),
          ],
        ),

        SizedBox(
          width: widget.spaceBetween ?? 5,
        ),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
                ? middlePages[2] < widget.totalPages - 1
                    ? Text(
                        '..',
                        style: TextStyle(
                            color: widget.dotsColor ?? const Color(0xFF84BD93),
                            fontSize: widget.textFontSize ?? 20),
                      )
                    : Container()
                : Container()
            : Container(),

        widget.totalPages >= 5
            ? middlePages.isNotEmpty
                ? middlePages[2] < widget.totalPages - 1
                    ? SizedBox(
                        width: widget.spaceBetween ?? 5,
                      )
                    : Container()
                : Container()
            : Container(),

        // last current page
        widget.totalPages > 1
            ? Row(
                children: [
                  Bounceable(
                      duration:
                          Duration(milliseconds: widget.bounceDuration ?? 300),
                      onTap: () async {
                        await Future.delayed(Duration(
                            milliseconds: widget.bounceDuration ?? 300));

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
                                        ? widget.selectedTextColor ??
                                            const Color(0xFFE6DCCD)
                                        : widget.unSelectedTextColor ??
                                            const Color(0xFFFFFFFF),
                                    fontSize: widget.textFontSize ?? 20)),
                          ),
                          height: widget.buttonHeight ?? 30,
                          width: widget.totalPages.toString().length > 1
                              ? null
                              : widget.normalWidth ?? 30,
                          padding: EdgeInsets.fromLTRB(
                              widget.totalPages.toString().length > 1
                                  ? widget.padding ?? 5 * 2
                                  : widget.padding ?? 5,
                              0,
                              widget.totalPages.toString().length > 1
                                  ? widget.padding ?? 5 * 2
                                  : widget.padding ?? 5,
                              0),
                          color: widget.totalPages == currentPage
                              ? widget.activeButtonColor ??
                                  const Color(0xFF84BD93)
                              : widget.lastButtonColor ??
                                  const Color(0xFF73665C),
                          borderColor: widget.totalPages == currentPage
                              ? widget.activeButtonColor ??
                                  const Color(0xFF84BD93)
                              : widget.lastButtonColor ??
                                  const Color(0xFF73665C),
                          borderWidth: 0.0,
                          borderRadius: widget.radius ?? 5))
                ],
              )
            : Container(),

        widget.totalPages > 1
            ? SizedBox(
                width: widget.spaceBetween ?? 5,
              )
            : Container(),

        // increase current page
        Bounceable(
            duration: Duration(milliseconds: widget.bounceDuration ?? 300),
            onTap: () async {
              await Future.delayed(
                  Duration(milliseconds: widget.bounceDuration ?? 300));

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
                size: widget.iconSize ?? 25,
                color: currentPage == widget.totalPages
                    ? widget.prevAndNextButtonColor ??
                        const Color(0xFF84BD93).withOpacity(0.5)
                    : widget.prevAndNextButtonColor ??
                        const Color(0xFF84BD93))),
      ],
    );
  }
}
