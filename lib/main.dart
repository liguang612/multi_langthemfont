import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_langthemfont/app_localization.dart';
import 'package:multi_langthemfont/data/constant/themes.dart';
import 'package:multi_langthemfont/data/repository/remote/app_repository.dart';
import 'package:multi_langthemfont/di/di.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(ChangeNotifierProvider(
      create: (context) => AppTheme(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.of(context, listen: true).currentTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: const [Locale('vi'), Locale('en')],
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
  final appRepository = AppRepository();
  late AppTheme _theme;
  int _counter = 0;
  late int _fontSize;

  @override
  void didChangeDependencies() {
    _fontSize = appRepository.getFontSize();
    _theme = AppTheme.of(context);
    super.didChangeDependencies();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: _theme.switchTheme, icon: const Icon(Icons.flip)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: () {
                      _updateFontSize(FontSize.big);
                    },
                    child: Text(
                        '${AppLocalizations.of(context)?.translate('Big')}',
                        style: TextStyle(fontSize: FontSize.big.toDouble()))),
                PopupMenuItem(
                    onTap: () {
                      _updateFontSize(FontSize.medium);
                    },
                    child: Text(
                        '${AppLocalizations.of(context)?.translate('Medium')}',
                        style:
                            TextStyle(fontSize: FontSize.medium.toDouble()))),
                PopupMenuItem(
                    onTap: () {
                      _updateFontSize(FontSize.small);
                    },
                    child: Text(
                        '${AppLocalizations.of(context)?.translate('Small')}',
                        style: TextStyle(fontSize: FontSize.small.toDouble())))
              ],
            )
          ],
          title: Text(
              AppLocalizations.of(context)?.translate(widget.title) ??
                  'Flutter Demo Home Page',
              style: TextStyle(fontSize: _fontSize.toDouble()))),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              '${AppLocalizations.of(context)?.translate('You have pushed plus button')}',
              style: TextStyle(fontSize: _fontSize.toDouble())),
          Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          Text('${AppLocalizations.of(context)?.translate('times')}',
              style: TextStyle(fontSize: _fontSize.toDouble())),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: AppLocalizations.of(context)?.translate('Increment'),
          child: const Icon(Icons.add)),
    );
  }

  _updateFontSize(int fontSize) {
    appRepository.setFontSize(fontSize);

    setState(() {
      _fontSize = fontSize;
    });
  }
}
