import 'package:demo_flutter_application/reputation_history/bloc/reputation_bloc.dart';
import 'package:demo_flutter_application/reputation_history/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../users/users.dart';

class ReputationsList extends StatefulWidget {
  const ReputationsList({super.key});

  @override
  State<ReputationsList> createState() => _ReputationsListState();
}

class _ReputationsListState extends State<ReputationsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ReputationBloc>().add(ReputationFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          BlocBuilder<ReputationBloc, ReputationState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.failure:
                  return const Center(
                    child: Text('failed to fetch reputations'),
                  );
                case Status.success:
                  if (state.reputations.isEmpty) {
                    return const Center(child: Text('no reputations'));
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.reputations.length
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: BottomLoader(),
                            )
                          : ReputationItem(
                              reputation: state.reputations[index],
                            );
                    },
                    itemCount: state.hasReachMax
                        ? state.reputations.length
                        : state.reputations.length + 1,
                    controller: _scrollController,
                  );
                case Status.initial:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
