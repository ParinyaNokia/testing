import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tester/model/datamodel.dart';

import 'package:tester/repo/repodata.dart';
import 'package:tester/screen/productpage.dart';
import 'package:tester/statemangement/bloc/get_api_bloc.dart';
import 'package:tester/statemangement/changelanguage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DataRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => Changelanguage(),
          ),
          BlocProvider(
            create: (context) =>
                DataBloc(RepositoryProvider.of<DataRepo>(context))
                  ..add(GetDataEvent()),
          ),
        ],
        child: BlocBuilder<Changelanguage, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 169, 253),
          title: Text(AppLocalizations.of(context)!.catagory),
        ),
        drawer: Drawer(
          width: 200,
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 104, 148, 224),
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Expanded(
                  child: BlocBuilder<DataBloc, DataState>(
                      builder: (context, state) {
                    if (state is DataLoaddingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is DataLoadedState) {
                      List<ModelData> datalist = state.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: datalist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 114, 192, 244),
                              title: Center(
                                child: Text(
                                  datalist[index].name,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductPage(
                                              targetname: datalist[index].slug,
                                            )));
                              },
                            ),
                          );
                        },
                      );
                    }
                    if (state is DataErrorState) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                    return Container();
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
