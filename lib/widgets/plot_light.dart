import 'dart:async'; // Importa dart:async para usar Timer
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Importa intl

class CustomChartLightWidget extends StatefulWidget {
  final String title;
  final String xAxisTitle;
  final String yAxisTitle;

  const CustomChartLightWidget({
    Key? key,
    required this.title,
    required this.xAxisTitle,
    required this.yAxisTitle,
  }) : super(key: key);

  @override
  _CustomChartLightWidgetState createState() => _CustomChartLightWidgetState();
}

class _CustomChartLightWidgetState extends State<CustomChartLightWidget> {
  // Define la URL aquí
  final String _apiUrl =
      'http://10.0.2.2:3000/api/plotdata'; // Cambia esto a tu URL real

  List<ChartData> _chartData = []; // Lista para mantener los datos
  late Timer _timer; // Asegúrate de inicializar esto en initState

  @override
  void initState() {
    super.initState();
    _fetchInitialData(); // Cargar datos iniciales
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _fetchNewData(); // Actualiza los datos cada 5 segundos
    });
  }

  Future<void> _fetchInitialData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _chartData = data
              .map((json) => ChartData(
                    DateTime.parse(json['createdAt']),
                    json['light'].toDouble(),
                  ))
              .toList();
        });
      } else {
        throw Exception('Failed to load initial chart data');
      }
    } catch (e) {
      throw Exception('Failed to fetch initial data: $e');
    }
  }

  Future<void> _fetchNewData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> newData = json.decode(response.body);
        setState(() {
          final newChartData = newData
              .map((json) => ChartData(
                    DateTime.parse(json['createdAt']),
                    json['light'].toDouble(),
                  ))
              .toList();

          // Filtrar datos duplicados
          _chartData = [
            ..._chartData,
            ...newChartData.where(
                (newData) => !_chartData.any((data) => data.x == newData.x)),
          ];

          // Ordenar los datos por fecha
          _chartData.sort((a, b) => a.x.compareTo(b.x));

          // Limitar la cantidad de datos a los más recientes (por ejemplo, 50)
          if (_chartData.length > 50) {
            _chartData = _chartData.sublist(_chartData.length - 50);
          }
        });
      } else {
        throw Exception('Failed to load new chart data');
      }
    } catch (e) {
      throw Exception('Failed to fetch new data: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela el Timer cuando el widget se destruye
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: screenWidth * 0.9, // Ajusta el ancho al 90% de la pantalla
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: widget.title),
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(text: widget.xAxisTitle),
          dateFormat: DateFormat('yyyy-MM-dd HH:mm:ss'),
          intervalType: DateTimeIntervalType.seconds,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: widget.yAxisTitle),
        ),
        series: <CartesianSeries<ChartData, DateTime>>[
          SplineSeries<ChartData, DateTime>(
            dataSource: _chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            name: 'Light Intensity',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartData &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
