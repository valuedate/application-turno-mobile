import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turno/models/auth.dart';
import 'package:turno/utils/theme.dart';

class ScreenScales extends StatefulWidget {
  final Function changeHiddenAppBar;
  final Function changeActiveIndex;
  const ScreenScales({
    required this.changeHiddenAppBar,
    required this.changeActiveIndex,
    super.key,
  });

  @override
  State<ScreenScales> createState() => _ScreenScalesState();
}

class _ScreenScalesState extends State<ScreenScales> {
  double topSpace = kToolbarHeight + 82;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    _scrollController.addListener(() {
      if (_scrollController.offset >= 40) {
        widget.changeHiddenAppBar(true);
      } else {
        widget.changeHiddenAppBar(false);
      }
    });

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration:
          const BoxDecoration(gradient: ThemeStyle.heroBackgroundGradient),
      // gradient: LinearGradient(
      //   colors: [Colors.white, Colors.grey],
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      // ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Enable vertical scrolling
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Weight')),
              DataColumn(label: Text('Height')),
              DataColumn(label: Text('BMI')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Gender')),
              DataColumn(label: Text('Actions')),
            ],
            rows: List<DataRow>.generate(
              60, // Generate 60 rows
              (index) => DataRow(
                cells: [
                  DataCell(Text('John Doe $index')),
                  DataCell(Text('${70 + index} kg')),
                  DataCell(Text('${170 + index} cm')),
                  DataCell(Text('${24.2 + index}')),
                  DataCell(Text('${29 + index}')),
                  DataCell(Text(index % 2 == 0 ? 'Male' : 'Female')),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        // Add your button action here
                      },
                      child: const Text('Edit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
