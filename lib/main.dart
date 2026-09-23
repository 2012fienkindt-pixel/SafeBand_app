import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const SafeBandApp());

class SafeBandApp extends StatelessWidget {
  const SafeBandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeBand',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D5BFF)),
      ),
      home: const SafeBandHomePage(),
    );
  }
}

class SafeBandHomePage extends StatefulWidget {
  const SafeBandHomePage({super.key});

  @override
  State<SafeBandHomePage> createState() => _SafeBandHomePageState();
}

class _SafeBandHomePageState extends State<SafeBandHomePage> {
  int _selectedIndex = 0;

  static const pages = <Widget>[
    HomePage(),
    RoutePage(),
    AiCallPage(),
    CheckInPage(),
    EmergencyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.navigation_outlined), selectedIcon: Icon(Icons.navigation), label: 'Route'),
          NavigationDestination(icon: Icon(Icons.call_outlined), selectedIcon: Icon(Icons.call), label: 'AI-bot'),
          NavigationDestination(icon: Icon(Icons.check_circle_outline), selectedIcon: Icon(Icons.check_circle), label: 'Check-in'),
          NavigationDestination(icon: Icon(Icons.warning_amber_outlined), selectedIcon: Icon(Icons.warning_amber), label: 'Alarm'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SafeBand Zwammerdam')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Veilig thuis komen, zonder alleen te zijn.', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Routekeuze, AI-gesprek, check-in en noodsignalen in één app.', style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 22),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 180,
                children: const [
                  FeatureCard(icon: Icons.route, title: 'Veiligste route', text: 'Verlichte straten en drukke zones.'),
                  FeatureCard(icon: Icons.smart_toy, title: 'AI-bot call', text: 'Praat onderweg met een digitale partner.'),
                  FeatureCard(icon: Icons.schedule, title: 'Check-in', text: 'Geef je verwachte aankomst aan.'),
                  FeatureCard(icon: Icons.watch, title: 'Noodalarm', text: 'Alarm via armband of telefoonhoesje.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key, required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 42, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      ('Veiligste route', 'Verlichte hoofdwegen en drukke plekken', 96, '18 min'),
      ('Makkelijkste route', 'Kortste afstand, iets minder verlicht', 82, '15 min'),
      ('Alternatieve route', 'Open ruimte en goede zichtbaarheid', 88, '20 min'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Veilige route')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Navigatie naar huis of een andere locatie', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Routes worden straks gekoppeld aan actuele drukte, verlichting en kaartdata.'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: routes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final route = routes[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.directions_walk),
                      title: Text(route.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(route.$2),
                      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('${route.$3}%'), Text(route.$4)]),
                    ),
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

class AiCallPage extends StatefulWidget {
  const AiCallPage({super.key});

  @override
  State<AiCallPage> createState() => _AiCallPageState();
}

class _AiCallPageState extends State<AiCallPage> {
  final messages = <String>['AI: Hoi, ik ben hier voor je. Wil je even praten?'];

  void startCall() {
    setState(() {
      messages.add('Jij: Ik loop naar huis en voel me wat onrustig.');
      messages.add('AI: Dat snap ik. Kies rustig een verlichte route. Ik blijf bij je.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI-bot bellen')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Icon(Icons.call, size: 44),
                  const SizedBox(height: 8),
                  const Text('Veiligheidsbot', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(onPressed: startCall, icon: const Icon(Icons.phone_in_talk), label: const Text('Bel AI-bot')),
                ]),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (_, index) => Align(
                  alignment: messages[index].startsWith('Jij:') ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: messages[index].startsWith('Jij:') ? Theme.of(context).colorScheme.primary : Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                    child: Text(messages[index], style: TextStyle(color: messages[index].startsWith('Jij:') ? Colors.white : Colors.black87)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  TimeOfDay expectedArrival = const TimeOfDay(hour: 22, minute: 30);
  Timer? timer;
  String status = 'Geen check-in actief';

  Future<void> selectTime() async {
    final time = await showTimePicker(context: context, initialTime: expectedArrival);
    if (time != null) setState(() => expectedArrival = time);
  }

  void activateCheckIn() {
    final now = DateTime.now();
    final arrival = DateTime(now.year, now.month, now.day, expectedArrival.hour, expectedArrival.minute);
    final delay = arrival.add(const Duration(minutes: 5)).difference(now);
    timer?.cancel();
    setState(() => status = 'Actief. Verwachte aankomst: ${expectedArrival.format(context)}.');
    timer = Timer(delay.isNegative ? const Duration(seconds: 1) : delay, () {
      if (!mounted) return;
      setState(() => status = 'Geen reactie binnen 5 minuten: noodmelding verzonden.');
      showDialog<void>(context: context, builder: (_) => AlertDialog(title: const Text('Ben je veilig thuis?'), content: const Text('Je locatie en check-in informatie zijn gedeeld met je vertrouwde contactpersonen.')));
    });
  }

  void confirmHome() {
    timer?.cancel();
    setState(() => status = 'Je hebt bevestigd: veilig thuis.');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Je status is bevestigd.')));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Wanneer verwacht je thuis te zijn?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Card(child: ListTile(title: const Text('Verwachte aankomsttijd'), trailing: TextButton.icon(onPressed: selectTime, icon: const Icon(Icons.access_time), label: Text(expectedArrival.format(context))))),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: activateCheckIn, icon: const Icon(Icons.checklist), label: const Text('Start check-in'))),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: confirmHome, icon: const Icon(Icons.home), label: const Text('Ik ben veilig thuis'))),
          const SizedBox(height: 28),
          const Text('Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(status))),
        ]),
      ),
    );
  }
}

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  void trigger(BuildContext context, String source) {
    showDialog<void>(context: context, builder: (_) => AlertDialog(title: const Text('Noodsignaal verzonden'), content: Text('Alarm via $source geactiveerd. Je locatie is gedeeld met je vertrouwde contactpersonen.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noodalarm')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Onveilig gevoel?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Met één druk op de knop wordt je locatie gedeeld met je vertrouwde mensen.'),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => trigger(context, 'de armband'), icon: const Icon(Icons.watch), label: const Text('Armband alarm'))),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => trigger(context, 'het telefoonhoesje'), icon: const Icon(Icons.vibration), label: const Text('Telefoonhoesje alarm'))),
          const SizedBox(height: 30),
          const Text('Vertrouwde contactpersonen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Moeder'), subtitle: Text('+31 6 12 34 56 78'))),
          const Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Vriend'), subtitle: Text('+31 6 90 12 34 56'))),
        ]),
      ),
    );
  }
}
