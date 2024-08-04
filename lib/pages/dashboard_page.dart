import 'package:flutter/material.dart';
import 'package:leafapp/widgets/leaf_app_bar.dart';
import '../widgets/gauge_light.dart';
import '../widgets/gauge_humidity.dart';
import '../widgets/gauge_temperature.dart';
import '../widgets/plot_light.dart';
import '../widgets/plot_humidity.dart';
import '../widgets/plot_temperature.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatelessWidget {
  final String apiBaseUrl = 'http://10.0.2.2:3000';

  const DashboardPage({super.key});

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/api/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      // Maneja el error según sea necesario
      print('Logout failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        logoPath: 'assets/loguito.png',
        buttonText: 'Logout', // Puedes cambiar esto según lo necesites
        onButtonPressed: () => logout(context),
      ),
      backgroundColor: const Color(0xFF5e9a42),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFabe15d),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Light',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: Color(0xFFEBF8E4),
                      ),
                    ),
                    CustomGaugeLightWidget(),
                    CustomChartLightWidget(
                        title: '', xAxisTitle: '', yAxisTitle: '')
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre containers
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFabe15d),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Humidity',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: Color(0xFFEBF8E4),
                      ),
                    ),
                    CustomGaugeHumidityWidget(),
                    CustomChartHumidityWidget(
                        title: '', xAxisTitle: '', yAxisTitle: '')
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre containers
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFabe15d),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Temperature',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: Color(0xFFEBF8E4),
                      ),
                    ),
                    CustomGaugeTemperatureWidget(),
                    CustomChartTemperatureWidget(
                        title: '', xAxisTitle: '', yAxisTitle: '')
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
