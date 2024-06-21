import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tester/repo/repocatagory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tester/statemangement/bloccatagory/bloc/datacatagory_bloc.dart';

class ProductPage extends StatefulWidget {
  final String targetname;

  ProductPage({required this.targetname});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.product),
      ),
      body: RepositoryProvider(
        create: (context) => RepoCatagory(widget.targetname),
        child: BlocProvider(
          create: (context) =>
              DatacatagoryBloc(RepositoryProvider.of<RepoCatagory>(context))
                ..add(GetCatagoryEvent()),
          child: const ProductPageContent(),
        ),
      ),
    );
  }
}

class ProductPageContent extends StatelessWidget {
  const ProductPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatacatagoryBloc, DatacatagoryState>(
      builder: (context, state) {
        if (state is DatacatagoryLoaddingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DatacatagoryLoadedState) {
          return ListView.builder(
            itemCount: state.product.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(state.product[index].thumbnail ?? ''),
                title: Text(state.product[index].title ?? ''),
                subtitle: Text(state.product[index].description ?? ''),
              );
            },
          );
        } else if (state is DatacatagoryErrorState) {
          return Center(child: Text('Failed to load data: ${state.error}'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
