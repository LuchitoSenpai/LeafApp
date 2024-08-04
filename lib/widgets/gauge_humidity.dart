import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

class CustomGaugeHumidityWidget extends StatefulWidget {
  @override
  _CustomGaugeHumidityWidgetState createState() =>
      _CustomGaugeHumidityWidgetState();
}

class _CustomGaugeHumidityWidgetState extends State<CustomGaugeHumidityWidget>
    with SingleTickerProviderStateMixin {
  final String apiUrl =
      'http://10.0.2.2:3000/api/gaugedata'; // Cambia esta URL por la de tu API
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer; // Agrega una variable para el Timer
  double _currentValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Duración de la transición
    );
    _animation = Tween<double>(begin: _currentValue, end: _currentValue)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Inicializa el Timer
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (mounted) {
        double? newValue = await fetchGaugeData();
        if (newValue != null) {
          setState(() {
            _currentValue = newValue;
            _animation = Tween<double>(begin: _animation.value, end: newValue)
                .animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOut,
            ));
            _controller.forward(from: 0.0);
          });
        }
      }
    });
  }

  Future<double?> fetchGaugeData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['humidity'] != null && data['humidity'] is num) {
          return (data['humidity'] as num).toDouble();
        } else {
          throw Exception('Valor de "light" inválido recibido');
        }
      } else {
        throw Exception('Error al cargar datos');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(0, 0, 0, 0),
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 4095, // Ajusta el máximo según los datos esperados
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 1024,
                      color: const Color(0xFFa4ff7d)),
                  GaugeRange(
                      startValue: 1025,
                      endValue: 2050,
                      color: const Color(0xFF4dff00)),
                  GaugeRange(
                      startValue: 2050,
                      endValue: 3075,
                      color: const Color(0xFF32a800)),
                  GaugeRange(
                      startValue: 3075,
                      endValue: 4095,
                      color: const Color(0xFF237300)),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: _animation.value),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '${_animation.value.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel(); // Cancela el Timer
    super.dispose();
  }
}
