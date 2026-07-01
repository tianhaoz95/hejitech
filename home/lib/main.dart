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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/terms': (context) => const TermsOfServicePage(),
      },
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
    name: 'MicroForge',
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
    name: 'Igloo',
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                product.tagline,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF757575),
                      fontSize: 10,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
    final isWide = MediaQuery.of(context).size.width > 840;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: 48,
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _copyright(context),
                _links(context),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _links(context),
                const SizedBox(height: 24),
                _copyright(context),
              ],
            ),
    );
  }

  Widget _copyright(BuildContext context) {
    return Text(
      '© 2026 Heji Technology LLC',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 13,
          ),
    );
  }

  Widget _links(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, '/terms'),
          child: Text(
            'TERMS OF SERVICE',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
        const SizedBox(width: 24),
        Text(
          'hejitech.com',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 11,
              ),
        ),
      ],
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

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 80 : 32,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TERMS OF SERVICE',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'Legal Framework',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isWide ? 48 : 32,
                    ),
              ),
              const SizedBox(height: 48),
              const _TermsSection(
                title: '1. Acceptance of Terms',
                content:
                    'By accessing and using the services provided by Heji Technology LLC, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our services.',
              ),
              const _TermsSection(
                title: '2. Description of Service',
                content:
                    'Heji Technology LLC provides AI-native tools and infrastructure, including but not limited to MicroForge, Snowglobe, KeyValue, Igloo, and Mittens. These services are provided "as is" and are subject to change without notice.',
              ),
              const _TermsSection(
                title: '3. Privacy Policy',
                content:
                    'Your privacy is important to us. Our use of your personal information is governed by our Privacy Policy. By using our services, you consent to the collection and use of your information as described therein.',
              ),
              const _TermsSection(
                title: '4. User Conduct',
                content:
                    'Users agree not to use the services for any unlawful purpose or in any way that could damage, disable, overburden, or impair the services or interfere with any other party\'s use and enjoyment of the services.',
              ),
              const _TermsSection(
                title: '5. Intellectual Property',
                content:
                    'All content and materials available on our services, including but not limited to text, graphics, website name, code, images, and logos, are the intellectual property of Heji Technology LLC and are protected by applicable copyright and trademark law.',
              ),
              const _TermsSection(
                title: '6. Limitation of Liability',
                content:
                    'In no event shall Heji Technology LLC be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses.',
              ),
              const SizedBox(height: 80),
              const _FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
