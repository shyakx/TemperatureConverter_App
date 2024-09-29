// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _selectedConversion = 'C to F'; // Default conversion type
  final TextEditingController _controller = TextEditingController();
  String _convertedTemperature = '';
  final List<String> _history = [];

  void _convertTemperature() {
    setState(() {
      double inputTemperature = double.tryParse(_controller.text) ?? 0;
      double result;

      if (_selectedConversion == 'C to F') {
        result = (inputTemperature * 9 / 5) + 32;
        _convertedTemperature = '${result.toStringAsFixed(2)} °F';
        _history
            .add('C to F: $inputTemperature => ${result.toStringAsFixed(2)}');
      } else {
        result = (inputTemperature - 32) * 5 / 9;
        _convertedTemperature = '${result.toStringAsFixed(2)} °C';
        _history
            .add('F to C: $inputTemperature => ${result.toStringAsFixed(2)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field for temperature
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),

            // Conversion type radio buttons
            Column(
              children: [
                ListTile(
                  title: const Text('Celsius to Fahrenheit'),
                  leading: Radio<String>(
                    value: 'C to F',
                    groupValue: _selectedConversion,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Fahrenheit to Celsius'),
                  leading: Radio<String>(
                    value: 'F to C',
                    groupValue: _selectedConversion,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),

            // Converted temperature result
            if (_convertedTemperature.isNotEmpty)
              Text(
                'Converted Temperature: $_convertedTemperature',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

            // Conversion history
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
