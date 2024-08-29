import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:kyla_test/models/expenditure_model.dart';
import 'package:kyla_test/utilities.dart';
import 'package:kyla_test/widgets/expenditure_widget.dart';
import 'package:kyla_test/widgets/header.dart';
import 'package:kyla_test/widgets/notification_widget.dart';
import 'package:kyla_test/widgets/timeline_widget.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/floating_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  late List<Expenditure> expenditureData;
  BehaviorSubject<bool> swipeSubject = BehaviorSubject<bool>();

  @override
  void initState() {
    expenditureData = fetchData();

    super.initState();
  }

  void sendWarning() {
    swipeSubject.sink.add(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF21264C),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TimelineWidget(
                      expenditureData: expenditureData,
                    ),
                  ),
                  NotificationWidget(swipeStream: swipeSubject),
                  const Header(),
                ],
              ),
            ),
            SizedBox(
              height: 20.w(context),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 100.w(context)),
                child: Column(
                  children: List.generate(
                    expenditureData.length,
                    (index) => SizedBox(
                      height: 110.w(context),
                      width: double.maxFinite,
                      child: ExpenditureWidget(
                        swipeStream: swipeSubject,
                        expenditure: expenditureData[index],
                        onItemSwiped: () => sendWarning(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const FloatingButton(),
        bottomNavigationBar: const BottomNavBar());
  }
}
