import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tester/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tester/statemangement/changelanguage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Changelanguage(),
      child: BlocBuilder<Changelanguage, LocaleState>(
        builder: (context, localeState) {
          return MaterialApp(
            locale: localeState.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('th', ''),
            ],
            home: const MyHomePage(
              title: "home",
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.homepage),
      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 95, 139, 214),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.languague,
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<Changelanguage>(context).add(Changelocale(
                  const Locale('th', ''),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocalizations.of(context)!.thai),
                  Image.asset(
                    'icons/flags/png100px/th.png',
                    package: 'country_icons',
                    width: 40,
                    height: 25,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<Changelanguage>(context).add(Changelocale(
                  const Locale('en', ''),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocalizations.of(context)!.english),
                  Image.asset(
                    'icons/flags/png100px/us.png',
                    package: 'country_icons',
                    width: 40,
                    height: 25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'sdsdf',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
