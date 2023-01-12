import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/saldo_shared_state.dart';

import 'color_state.dart';
import 'keranjang_shared_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProviderExample(),
    );
  }
}

class MultiProviderExample extends StatefulWidget {
  const MultiProviderExample({super.key});

  @override
  State<MultiProviderExample> createState() => _MultiProviderExampleState();
}

class _MultiProviderExampleState extends State<MultiProviderExample> {
  TextStyle myTextStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorState(),
        ),
        ChangeNotifierProvider(create: (context) => SaldoState()),
        ChangeNotifierProvider(
          create: (context) => KeranjangState(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[700],
            title: Consumer<ColorState>(
              builder: (context, colorstate, child) => Text(
                "State Management",
                style: TextStyle(color: colorstate.getColors),
              ),
            )),
        // backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belanja"),
              const SizedBox(
                height: 10,
              ),
              Consumer<ColorState>(
                  builder: (context, colorstate, child) => Consumer<SaldoState>(
                        builder: (context, saldostate, child) => Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorstate.getColors),
                          child: Center(
                            child: Text(
                              "${saldostate.getSaldo}",
                              style: myTextStyle,
                            ),
                          ),
                        ),
                      )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Biru"),
                  Consumer<ColorState>(
                    builder: (context, colorstate, child) => Switch(
                        value: colorstate.getIsOrange,
                        onChanged: ((value) {
                          colorstate.setColors = value;
                        })),
                  ),
                  const Text("Orange")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<ColorState>(
                builder: (context, colorstate, child) =>
                    Consumer<KeranjangState>(
                  builder: (context, keranjangstate, child) => Card(
                    color: colorstate.getColors,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Telur (500) x ${keranjangstate.getQty}",
                            style: myTextStyle,
                          ),
                          Text(
                            "${keranjangstate.getQty * 500}",
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // ElevatedButton(onPressed: () {}, child: Text("ss"))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<SaldoState>(
                    builder: (context, saldostate, child) =>
                        ElevatedButton.icon(
                      onPressed: (() {
                        if (saldostate.getSaldo == 0) {
                          saldostate.resetsaldo();
                        }
                      }),
                      icon: const Icon(Icons.change_circle),
                      label: const Text("Reset Saldo"),
                    ),
                  ),
                  Container(
                    width: 30,
                  ),
                  Consumer<KeranjangState>(
                    builder: (context, saldostate, child) =>
                        ElevatedButton.icon(
                      onPressed: (() {
                        if (saldostate.getQty > 0) {
                          saldostate.kurangikeranjang();
                        }
                      }),
                      icon: const Icon(Icons.change_circle),
                      label: const Text("Kurangi Keranjang"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        floatingActionButton: Consumer3<ColorState, SaldoState, KeranjangState>(
          builder: (context, colorstate, saldostate, keranjangstate, child) =>
              FloatingActionButton(
            backgroundColor: colorstate.getColors,
            onPressed: () {
              if (saldostate.getSaldo > 0) {
                saldostate.kurangiSaldo(500);
                keranjangstate.tambahkeranjang();
              }
            },
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
    );
  }
}
