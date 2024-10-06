import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fahrenheitController = TextEditingController();
  final TextEditingController _celsiusController = TextEditingController();

  // the conversion results
  List<String> _conversionResults = [];

  void _convertToCelsius() {
    if (_formKey.currentState!.validate()) {
      double fahrenheit = double.parse(_fahrenheitController.text);
      double celsius = (fahrenheit - 32) * 5 / 9;
      setState(() {
        _conversionResults.add('Fahrenheit to Celsius: ${fahrenheit.toStringAsFixed(2)}°F = ${celsius.toStringAsFixed(2)}°C');
        _fahrenheitController.clear();
      });
    }
  }

  void _convertToFahrenheit() {
    if (_formKey.currentState!.validate()) {
      double celsius = double.parse(_celsiusController.text);
      double fahrenheit = (celsius * 9 / 5) + 32;
      setState(() {
        _conversionResults.add('Celsius to Fahrenheit: ${celsius.toStringAsFixed(2)}°C = ${fahrenheit.toStringAsFixed(2)}°F');
        _celsiusController.clear();
      });
    }
  }

  void _resetHistory() {
    setState(() {
      _conversionResults.clear();
    });
  }

  @override
  void dispose() {
    _fahrenheitController.dispose();
    _celsiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _fahrenheitController,
                decoration: const InputDecoration(
                  labelText: 'Enter temperature in Fahrenheit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a temperature';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _convertToCelsius,
                child: const Text('Convert to Celsius'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _celsiusController,
                decoration: const InputDecoration(
                  labelText: 'Enter temperature in Celsius',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a temperature';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _convertToFahrenheit,
                child: const Text('Convert to Fahrenheit'),
              ),
              const SizedBox(height: 32),
              const Text(
                'Conversion History:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _conversionResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _conversionResults[_conversionResults.length - 1 - index],
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              // clears the conversion history
              ElevatedButton(
                onPressed: _resetHistory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Reset History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}