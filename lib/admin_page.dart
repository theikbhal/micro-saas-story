import 'dart:convert';

import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _jsonController = TextEditingController();
  String _statusMessage = "";

  void _addStory() {
    try {
      final parsed = jsonDecode(_jsonController.text);

      // Check if parsed is a Map with required keys
      if (parsed is Map &&
          parsed.containsKey("title") &&
          parsed.containsKey("content") &&
          parsed.containsKey("founder") &&
          parsed.containsKey("product") &&
          parsed.containsKey("link")) {
        // Here you can save to local SQLite or in-memory list
        _statusMessage = "Story added successfully!";
        _jsonController.clear();
      } else {
        _statusMessage =
            "Invalid JSON structure! Required keys: title, content, founder, product, link";
      }
    } catch (e) {
      _statusMessage = "JSON parsing error: ${e.toString()}";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Add a new story in JSON format",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _jsonController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      '{ "title": "Micro-SaaS Example", "content": "Short story here", "founder": "John Doe", "product": "Example App", "link": "https://example.com" }',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addStory,
              child: const Text("Add Story"),
            ),
            const SizedBox(height: 10),
            Text(
              _statusMessage,
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
