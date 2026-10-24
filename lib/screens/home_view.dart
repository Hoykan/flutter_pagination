import 'package:flutter/material.dart';
import 'package:flutter_pagination/Models/data_model.dart';
import 'package:flutter_pagination/screens/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>()
        ..fetchData()
        ..listenScrollBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<HomeViewModel>(
            builder: (context, model, child) {
              if (model.dataModel == null) {
                return const CircularProgressIndicator();
              } else {
                return ListWigdet(model);
              }
            },
          ),
        ),
      ),
    );
  }

  ListView ListWigdet(HomeViewModel model) {
    final List<Posts> posts = model.dataModel!.posts!;
    return ListView.builder(
      controller: model.scrollController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final Posts item = posts[index];
        return Column(
          children: [
            Text(item.title!, style: Theme.of(context).textTheme.titleMedium),
            Text(item.body!, style: Theme.of(context).textTheme.titleLarge),
            Text("ID: ${item.id}"),
            //const Divider().
          ],
        );
      },
    );
  }
}
