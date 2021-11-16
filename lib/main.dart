import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimationsPackageExample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationsPackageExample(title: 'AnimationsPackageExample'),
    );
  }
}

class AnimationsPackageExample extends StatefulWidget {
  const AnimationsPackageExample({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<AnimationsPackageExample> createState() =>
      _AnimationsPackageExampleState();
}

class _AnimationsPackageExampleState extends State<AnimationsPackageExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            title: const Text('1, Opencontainer'),
            subtitle: const Text(
                'A container that grows to fill the screen to reveal new content when tapped'),
            trailing: IconButton(
              onPressed: () => launch(
                  'https://pub.dev/documentation/animations/latest/animations/OpenContainer-class.html'),
              icon: const Icon(Icons.open_in_new),
              tooltip: 'Documentation',
            ),
          ),
          OpenContainer(
              closedBuilder: (context, action) => const ListTile(
                    title: Text('Click me'),
                    // trailing: Icon(Icons.keyboard_arrow_right),
                  ),
              openBuilder: (context, action) => const Scaffold(
                    body: Center(
                      child: Text('New page'),
                    ),
                  )),
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            title: const Text('2. PageTransitionSwitcher'),
            subtitle: const Text(
                'Transition from an old child to a new child, similar to AnimationSwitcher'),
            trailing: IconButton(
              onPressed: () => launch(
                  'https://pub.dev/documentation/animations/latest/animations/PageTransitionSwitcher-class.html'),
              icon: const Icon(Icons.open_in_new),
              tooltip: 'Documentation',
            ),
          ),
          const SizedBox(
            height: 200,
            child: _PageTransitionSwitcherEx(),
          ),
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            title: const Text('3.SharedAxisTransition'),
            subtitle: const Text(
                'Transition animation between UI elements that have a spatial or navigational relationship'),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new),
              tooltip: 'Documentation',
              onPressed: () => launch(
                  'https://pub.dev/documentation/animations/latest/animations/SharedAxisTransition-class.html'),
            ),
          ),
          const SizedBox(child: _SharedAxisEx(), height: 300),
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            title: const Text('4.ShowModal()'),
            subtitle: const Text('Dislays a dialog with animation'),
            trailing: IconButton(
                onPressed: () => launch(
                    'https://pub.dev/documentation/animations/latest/animations/showModal.html'),
                icon: Icon(Icons.open_in_new)),
          ),
          ElevatedButton(
              onPressed: () => showModal(
                  context: context,
                  builder: (context) => const AlertDialog(
                        title: Text('New Dialog'),
                        content: Text('Blabla'),
                      )),
              child: const Text('ShowModal'))
        ],
      ),
    );
  }
}

class _PageTransitionSwitcherEx extends StatefulWidget {
  const _PageTransitionSwitcherEx({Key? key}) : super(key: key);

  @override
  State<_PageTransitionSwitcherEx> createState() =>
      _PageTransitionSwitcherExState();
}

class _PageTransitionSwitcherExState extends State<_PageTransitionSwitcherEx> {
  static const _tabs = [
    Icon(
      Icons.looks_one,
      size: 48,
      key: ValueKey(1),
    ),
    Icon(
      Icons.looks_two,
      size: 48,
      key: ValueKey(2),
    )
  ];

  static const _btnNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab1'),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Tab2')
  ];

  int _curentTabdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, primaryAction, secondaryAnimation) =>
              FadeThroughTransition(
            animation: primaryAction,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: _tabs[_curentTabdx],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _btnNavBarItems,
        currentIndex: _curentTabdx,
        onTap: (idx) => setState(() {
          _curentTabdx = idx;
        }),
      ),
    );
  }
}

class _SharedAxisEx extends StatefulWidget {
  const _SharedAxisEx({Key? key}) : super(key: key);

  @override
  State<_SharedAxisEx> createState() => _SharedAxisExState();
}

class _SharedAxisExState extends State<_SharedAxisEx> {
  final _pages = [
    const Icon(Icons.looks_one, size: 64, key: ValueKey(1)),
    const Icon(
      Icons.looks_two,
      size: 64,
      key: ValueKey(2),
    ),
    const Icon(
      Icons.looks_3,
      size: 64,
      key: ValueKey(3),
    )
  ];

  int _currentPageidx = 0;

  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) =>
                      SharedAxisTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: _transitionType),
              child: _pages[_currentPageidx],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: _currentPageidx == 0
                        ? null
                        : () => setState(() {
                              _currentPageidx--;
                            }),
                    child: const Text('Back')),
                ElevatedButton(
                    onPressed: _currentPageidx == 2
                        ? null
                        : () => setState(() {
                              _currentPageidx++;
                            }),
                    child: const Text('Next'))
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: _buildControlBar(),
    );
  }

  Widget _buildControlBar() {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('SharedAxisTransitionType'),
            trailing: DropdownButton(
              value: _transitionType,
              items: [
                for (final val in SharedAxisTransitionType.values)
                  DropdownMenuItem(
                    child: Text(val
                        .toString()
                        .substring('SharedAxisTransitionType.'.length)),
                    value: val,
                  )
              ],
              onChanged: (SharedAxisTransitionType? val) {
                if (val != null) {
                  setState(() {
                    _transitionType = val;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
