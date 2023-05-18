import 'package:faniweb/app_responsive.dart';
import 'package:faniweb/main.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TableOfServData extends StatefulWidget {
  @override
  _TableOfServDataState createState() => _TableOfServDataState();
}

class _TableOfServDataState extends State<TableOfServData> {
  @override
  void initState() {
    super.initState();
    // print(workers);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12,
          dataRowHeight: 60,
          dividerThickness: 1,
          columns: [
            DataColumn(
              label: Text('الإسم'),
            ),
            DataColumn(label: _verticalDivider),
            DataColumn(
              label: Text('الإيميل'),
              numeric: true,
            ),
            DataColumn(label: _verticalDivider),
            DataColumn(
              label: Text('الهاتف'),
              numeric: true,
            ),
            DataColumn(label: _verticalDivider),
            if (AppResponsive.isDesktop(context))
              DataColumn(
                label: Text('الجنس'),
              ),
            if (AppResponsive.isDesktop(context))
              DataColumn(label: _verticalDivider),
            DataColumn(
              label: Text('الأعمال'),
            ),
            DataColumn(label: _verticalDivider),
            //if (!AppResponsive.isMobile(context))
            DataColumn(
              label: SizedBox(),
              numeric: true,
            ),
          ],
          rows: workers.map((worker) {
            return DataRow(
              cells: [
                if (AppResponsive.isDesktop(context))
                  DataCell(
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(worker['image']),
                        ),
                        SizedBox(width: 10),
                        Text(worker['name']),
                      ],
                    ),
                  ),
                if (!AppResponsive.isDesktop(context))
                  DataCell(Text(worker['name'])),
                DataCell(_verticalDivider),

                DataCell(Text(worker['email'])),
                DataCell(_verticalDivider),

                DataCell(Text(worker['phone'])),
                DataCell(_verticalDivider),

                if (AppResponsive.isDesktop(context))
                  DataCell(Text(worker['gender'])),
                if (AppResponsive.isDesktop(context))
                  DataCell(_verticalDivider),

                DataCell(IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {},
                )),
                DataCell(_verticalDivider),
                // if (!AppResponsive.isMobile(context))
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: Colors.grey,
    thickness: .5,
  );
}
