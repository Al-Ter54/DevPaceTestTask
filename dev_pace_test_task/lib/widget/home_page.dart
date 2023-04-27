import 'package:dev_pace_test_task/bloc/bloc_event.dart';
import 'package:dev_pace_test_task/bloc/bloc_state.dart';
import 'package:dev_pace_test_task/bloc/dev_pace_bloc.dart';
import 'package:dev_pace_test_task/widget/element_item.dart';
import 'package:dev_pace_test_task/widget/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/model_element.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double logoWrapHeight = 0;
  double logoHeight = 0;

  void _addItem() {
    DevPaceBloc bloc = context.read<DevPaceBloc>();
    bloc.add(BlocEventAdd());
  }

  void _removeItem() {
    DevPaceBloc bloc = context.read<DevPaceBloc>();
    bloc.add(BlocEventRemove());
  }

  @override
  Widget build(BuildContext context) {
    DevPaceBloc bloc = context.read<DevPaceBloc>();
    return Scaffold(
      body: BlocBuilder<DevPaceBloc, BlocState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SizedBox(
                        height: logoWrapHeight,
                        child: Center(
                          child: MeasureSize(
                            onChange: (logoImageSize) {
                              if (logoHeight == 0) {
                                logoHeight = logoImageSize.height;
                              }
                            },
                            child: Image.asset("assets/test_logo.png"),
                          ),
                        ),
                      ),
                      MeasureSize(
                        onChange: (size) {
                          setState(() {
                            if (viewportConstraints.maxHeight - size.height >
                                logoHeight) {
                              logoWrapHeight =
                                  viewportConstraints.maxHeight - size.height;
                            } else {
                              logoWrapHeight = logoHeight;
                            }
                          });
                        },
                        child: _blocContent(bloc: bloc, state: state),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addItem,
            tooltip: 'Add item',
            heroTag: 'fab1',
            child: const Icon(Icons.add),
          ),
          const Padding(
            padding: EdgeInsets.all(4),
          ),
          FloatingActionButton(
            onPressed: _removeItem,
            tooltip: 'Remove item',
            heroTag: 'fab2',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _blocContent({
    required DevPaceBloc bloc,
    required BlocState state,
  }) {
    if (state is BlocStateEmpty) {
      return const Center(child: Text("List is empty"));
    }
    if (state is BlocStateLoading) {
      return _imageList(
        bloc: bloc,
        list: state.list,
        showLoader: true,
      );
    }
    if (state is BlocStateError) {
      return Center(child: Text(state.error.toString()));
    }
    return _imageList(
      bloc: bloc,
      list: (state as BlocStateLoaded).list,
    );
  }

  Widget _imageList({
    required DevPaceBloc bloc,
    required List<ModelElement> list,
    bool showLoader = false,
  }) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 4,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        showLoader ? list.length + 1 : list.length,
        (index) => (index < list.length)
            ? ElementItem(element: list[index])
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
