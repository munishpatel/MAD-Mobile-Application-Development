// lib/pages/insights_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsightsPage extends StatefulWidget {
  @override
  _InsightsPageState createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  String quote = "Loading wellness insight...";

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    try {
      final response =
          await http.get(Uri.parse('https://zenquotes.io/api/random'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          quote = '${data[0]["q"]} — ${data[0]["a"]}';
        });
      } else {
        setState(() {
          quote = "Could not fetch insight. Try again later.";
        });
      }
    } catch (e) {
      setState(() {
        quote = "Network error: Unable to load insight.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wellness Insights'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.spa, color: Colors.teal, size: 48),
              SizedBox(height: 20),
              Text(
                quote,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: fetchQuote,
                child: Text("Refresh"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
