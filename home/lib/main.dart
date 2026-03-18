import 'package:flutter/material.dart';

void main() {
  runApp(const HejiTechApp());
}

class HejiTechApp extends StatelessWidget {
  const HejiTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heji Technology LLC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.0,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Color(0xFF757575),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class _Product {
  final String name;
  final String tagline;
  final String description;
  final IconData icon;

  const _Product({
    required this.name,
    required this.tagline,
    required this.description,
    required this.icon,
  });
}

const _products = [
  _Product(
    name: 'AppForge',
    tagline: 'VIBE CODING PLATFORM',
    description:
        'Turn natural language into functional, persistent micro-apps. Forge utilities, dashboards, and tools instantly — no build step required.',
    icon: Icons.rocket_launch_outlined,
  ),
  _Product(
    name: 'Snowglobe',
    tagline: 'ON-DEVICE LLM INFERENCE',
    description:
        'High-performance, cross-platform LLM inference engine built with Rust and Flutter. Run powerful AI models locally on mobile and desktop.',
    icon: Icons.memory_outlined,
  ),
  _Product(
    name: 'KeyValue',
    tagline: 'AI-POWERED ADVISOR CRM',
    description:
        'Proactively manage client relationships with generative AI. Identify needs, draft personalized outreach, and keep profiles up to date automatically.',
    icon: Icons.people_outline,
  ),
  _Product(
    name: 'AiSNS',
    tagline: 'AI-NATIVE SOCIAL NETWORK',
    description:
        'A communication platform where AI agents are first-class citizens. Seamless human-to-agent and agent-to-agent interactions in real time.',
    icon: Icons.hub_outlined,
  ),
  _Product(
    name: 'Mittens',
    tagline: 'PERSONAL APP INFRASTRUCTURE',
    description:
        'Self-hosted, AI-native infrastructure for building and managing personal micro-apps. Your own private app factory, running entirely on your hardware.',
    icon: Icons.dns_outlined,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroSection(),
            const _ProductsSection(),
            const _FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: isWide ? 100 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HEJI TECHNOLOGY',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'Building the\nAI-native future.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isWide ? 64 : 40,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: isWide ? 480 : double.infinity,
            child: Text(
              'We craft tools that put AI at the center — from on-device inference engines to vibe-coding platforms and AI-first social networks.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 17,
                  ),
            ),
          ),
          const SizedBox(height: 40),
          const _Divider(),
        ],
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PRODUCTS', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 32),
          ...List.generate(_products.length, (i) {
            return Column(
              children: [
                _ProductRow(product: _products[i], index: i),
                const _Divider(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final _Product product;
  final int index;

  const _ProductRow({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 280,
                  child: _ProductMeta(product: product),
                ),
                const SizedBox(width: 64),
                Expanded(child: _ProductDetail(product: product)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductMeta(product: product),
                const SizedBox(height: 16),
                _ProductDetail(product: product),
              ],
            ),
    );
  }
}

class _ProductMeta extends StatelessWidget {
  final _Product product;
  const _ProductMeta({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(product.icon, size: 22, color: Colors.black),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 2),
            Text(
              product.tagline,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF757575),
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProductDetail extends StatelessWidget {
  final _Product product;
  const _ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Text(
      product.description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026 Heji Technology LLC',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                ),
          ),
          Text(
            'hejitech.com',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: Color(0xFFEEEEEE), thickness: 1, height: 1);
  }
}
