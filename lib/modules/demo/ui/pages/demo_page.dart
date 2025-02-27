import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/router/router.dart';
import '../bloc/demo_bloc.dart';
import '../bloc/demo_event.dart';
import '../bloc/demo_state.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key,});

  @override
  Widget build(BuildContext context) {
    AppLocalizations traductions = AppLocalizations.of(context)!;
    //Bloc
    final demoBloc = DemoBloc();
    //
    return BlocProvider<DemoBloc>(
      create: (BuildContext context) => demoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(traductions.demoPageTitle),
          actions: [
            // Btn setting
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => AppRouter.push(context, AppRouter.settings),
            ),
          ],
        ),
        body: BlocBuilder<DemoBloc, DemoState>(
          buildWhen: (previous, current) => current is DemoUpdateState,
          builder:(context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${traductions.demoPageMessage}:',
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => demoBloc.add(IncrementCounterEvent()),
          tooltip: traductions.demoPageBtnText,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}