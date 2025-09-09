import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening links
import 'package:share_plus/share_plus.dart'; // For sharing

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
        fontFamily: 'Arial',
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const MicroSaaSLandingPage(),
    );
  }
}

class MicroSaaSLandingPage extends StatelessWidget {
  const MicroSaaSLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        "title": "📖 IndieAnalytics",
        "content":
            "An indie founder built a simple analytics dashboard for small blogs. "
            "Started as a weekend project, validated by talking to 10 bloggers. "
            "Used Twitter + Reddit to market. "
            "Reached \$500 MRR in 6 months with almost zero costs. "
            "Focus was on customer care, writing tutorials, and SEO.",
        "tags": ["Validation", "SEO", "Build in Public"],
        "founder": "Alex Johnson",
        "product": "IndieAnalytics",
        "link": "https://example.com/indieanalytics",
      },
      {
        "title": "📖 TaskTiny",
        "content":
            "A lightweight task manager for freelancers. Founder validated idea by "
            "sharing early mockups in design communities. "
            "Kept pricing at \$5/month to attract first 50 users. "
            "Hit \$800 MRR in the first year. Marketing was mainly through "
            "content writing and Twitter threads.",
        "tags": ["Content Writing", "Community", "Low Pricing"],
        "founder": "Maria Lopez",
        "product": "TaskTiny",
        "link": "https://example.com/tasktiny",
      },
      {
        "title": "📖 SocialCaption",
        "content":
            "Solo founder created an AI tool to generate Instagram captions. "
            "Started free on Product Hunt and converted 2% to paid users. "
            "Early growth from TikTok videos + SEO blogs. "
            "Currently doing around \$700 MRR with minimal costs.",
        "tags": ["Product Hunt", "SEO", "Social Media"],
        "founder": "Sam Patel",
        "product": "SocialCaption",
        "link": "https://example.com/socialcaption",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Header
            Text(
              "MicroSaaS Stories",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Discover inspiring stories of solo founders who built small, profitable SaaS products under \$1000 MRR 🚀",
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink.shade800,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Story Cards
            for (var story in stories) ...[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        story["title"] as String,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Content
                      Text(
                        story["content"] as String,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade900,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Founder + Product
                      Text(
                        "👤 Founder: ${story["founder"]}\n💡 Product: ${story["product"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink.shade700,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Link
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(story["link"] as String);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: Text(
                          story["link"] as String,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Tags
                      Wrap(
                        spacing: 8,
                        children: (story["tags"] as List<String>).map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: Colors.pink.shade100,
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),

                      // Share Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text("Share"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            final text =
                                "${story["title"]}\n\n${story["content"]}\n\nBy ${story["founder"]} → ${story["link"]}";
                            Share.share(text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // CTA
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Read More Stories",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
