import 'package:flutter/material.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:frontend/providers/targets_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class TargetsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // print(isDarkMode);
    Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: SafeArea(
            child: Stack(
              children: [SingleChildScrollView(
                child: Center(
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // const SizedBox(height: 100,),
                        AppBar(forceMaterialTransparency: true,),
                        // Heading for Goals
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                "Targets",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(1, 104, 170, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Consumer<TargetsProvider>(
                          builder: (context, provider, _) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.targets.length,
                              itemBuilder: (context, index) {
                                var target = provider.targets[index];
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                  decoration: BoxDecoration(
                                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                              target.targetName,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              // tileColor: Colors.amber,
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Balance", style: TextStyle(fontSize: 12),),
                                                  Text('${int.parse(target.totalAmount)/int.parse(target.balanceTarget) * 100}%', style: const TextStyle(fontSize: 12),),
                                                ],
                                              ),
                                              subtitle: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                    // width: 10,
                                                    child: LinearProgressBar(
                                                      maxSteps: 5,
                                                      progressType: LinearProgressBar
                                                          .progressTypeLinear,
                                                      currentStep: 1,
                                                      progressColor: Colors.black,
                                                      backgroundColor: const Color.fromRGBO(223, 222, 222, 1),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('${target.totalAmount} KWD '),
                                                          Text('of ${target.balanceTarget} KWD', style: const TextStyle(fontSize: 12),),
                                                        ],
                                                      ),
                                                      const Text('3 Months left', style: TextStyle(fontSize: 12),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(Icons.abc),
                                                Text('50 KWD/mo', style: TextStyle(fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // const Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Icon(Icons.abc),
                                      //     const Text('3 Months left'),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        ),
                        const SizedBox(height: 100,),
                      ],
                    ),
                    )
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/addTarget');
                            },
                            style: ElevatedButton.styleFrom(
                              // elevation: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                              backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ), 
                            child: const Text("Add Targets", style: TextStyle(color: Colors.white),)
                          ),
                        )
                      ],
                    ),
                  )
                  ]
            ),
              ),
            ),
          );
  }
}