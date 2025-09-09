import 'dart:convert';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _jsonController = TextEditingController();
  String _statusMessage = "";

  void _addStory() async {
    try {
      final parsed = jsonDecode(_jsonController.text);

      if (parsed is Map &&
          parsed.containsKey("title") &&
          parsed.containsKey("content") &&
          parsed.containsKey("founder") &&
          parsed.containsKey("product") &&
          parsed.containsKey("link")) {

        // Insert into SQLite
        await DBHelper().insertStory({
          'title': parsed['title'],
          'content': parsed['content'],
          'founder': parsed['founder'],
          'product': parsed['product'],
          'link': parsed['link'],
          'image': parsed['image'] ?? '',
          'tags': parsed['tags']?.join(',') ?? '', // optional tags as comma string
        });

        _statusMessage = "Story added successfully!";
        _jsonController.clear();
      } else {
        _statusMessage =
            "Invalid JSON! Required: title, content, founder, product, link";
      }
    } catch (e) {
      _statusMessage = "JSON error: ${e.toString()}";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Page")),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      '{ "title": "Example", "content": "Story content", "founder": "John", "product": "App", "link": "https://example.com", "tags":["SaaS","Build"] }',
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
