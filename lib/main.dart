import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'admin_page.dart';
import 'db_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: const MicroSaaSLandingPage(),
    );
  }
}

class MicroSaaSLandingPage extends StatefulWidget {
  const MicroSaaSLandingPage({super.key});

  @override
  State<MicroSaaSLandingPage> createState() => _MicroSaaSLandingPageState();
}

class _MicroSaaSLandingPageState extends State<MicroSaaSLandingPage> {
  List<Map<String, dynamic>> stories = [];

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  void _loadStories() async {
    final data = await DBHelper().getStories();
    setState(() {
      stories = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MicroSaaS Stories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStories,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminPage()),
                ).then((_) => _loadStories());
              },
              child: const Text("Admin: Add Story"),
            ),
            const SizedBox(height: 16),
            for (var story in stories)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(story['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(story['content']),
                      const SizedBox(height: 8),
                      Text("👤 ${story['founder']} | 💡 ${story['product']}"),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(story['link']);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: Text(
                          story['link'],
                          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        children: story['tags']
                            .toString()
                            .split(',')
                            .map((tag) => Chip(label: Text(tag), backgroundColor: Colors.pink[100]))
                            .toList(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text("Share"),
                          onPressed: () {
                            Share.share("${story['title']}\n${story['content']}\nBy ${story['founder']} → ${story['link']}");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
