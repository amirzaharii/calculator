import 'package:day8/counter_cubit.dart';
import 'package:day8/division.dart';
import 'package:day8/multiplication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const MyHomePage(
          title: 'My Flutter App',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;

  final numController = TextEditingController();

  void navigateToMultiplyPage(BuildContext context, int input, int state) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Multiply(input: input, state: state);
    }));
  }

  void navigateToDivisionPage(BuildContext context, int input, int state) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Division(input: input, state: state);
    }));
  }

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'My Flutter App',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CounterCubit, int>(
        bloc: cubit,
        listener: (context, state) {
          const snackBar = SnackBar(
            content: Text(
              'State is reached',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            width: 300,
          );
          if (state == 5) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (BuildContext context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: numController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a number',
                  ),
                ),
                const Text(
                  'Your Counter Value:',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '$state',
                  style: const TextStyle(
                      fontSize: 100, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.increment();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.add),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.decrement();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.reset();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const AlertDialog(
                            title: Text('Alert'),
                            content: Text('State is reset'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          int input = int.parse(numController.text);
                          navigateToMultiplyPage(context, input, state);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          onPrimary: Colors.black,
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        child: const Icon(Icons.close)),
                    ElevatedButton(
                        onPressed: () {
                          int input = int.parse(numController.text);
                          navigateToDivisionPage(context, input, state);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          onPrimary: Colors.black,
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        child: const Text(
                          '/',
                          style: TextStyle(fontSize: 25),
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
