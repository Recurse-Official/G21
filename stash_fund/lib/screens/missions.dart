import 'package:flutter/material.dart';

class MissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missions'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Mission Name')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Reward')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Mission 1')),
              DataCell(Text('In Progress')),
              DataCell(Text('50 Points')),
            ]),
            DataRow(cells: [
              DataCell(Text('Mission 2')),
              DataCell(Text('Completed')),
              DataCell(Text('100 Points')),
            ]),
            DataRow(cells: [
              DataCell(Text('Mission 3')),
              DataCell(Text('Not Started')),
              DataCell(Text('30 Points')),
            ]),
          ],
        ),
      ),
    );
  }
}