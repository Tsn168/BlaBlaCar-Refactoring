import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/home/view_model/home_model.dart';
import 'package:blabla/ui/state/ride_preference_state.dart';
import 'package:blabla/ui/widgets/pickers/bla_ride_preference_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/screens/rides_selection/rides_selection_screen.dart';
import '../../theme/theme.dart';
import 'widgets/home_history_tile.dart';

// 1. The new HomeScreen: A simple wrapper that provides the ViewModel.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(context.read<RidePreferenceState>()),
      child: const HomeContent(),
    );
  }
}

// 2. The HomeContent: A StatelessWidget that builds the UI from the ViewModel.
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _onRidePreferenceSelected(
    BuildContext context,
    RidePreference preference,
  ) {
    // Call the ViewModel to update the state
    context.read<HomeViewModel>().onRidePreferenceSelected(preference);

    // Navigate to the next screen
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RidesSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Watch the ViewModel for changes
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The preference picker now calls our method
            BlaRidePreferencePicker(
              onRidePreferenceSelected: (preference) =>
                  _onRidePreferenceSelected(context, preference),
            ),
            const SizedBox(height: BlaSpacings.l),
            Text('Recent searches', style: BlaTextStyles.h2),
            const SizedBox(height: BlaSpacings.m),
            // The history list is now built from the ViewModel
            if (viewModel.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (viewModel.preferenceHistory.isEmpty)
              const Text('No recent searches yet.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.preferenceHistory.length,
                  itemBuilder: (context, index) {
                    final ridePref = viewModel.preferenceHistory[index];
                    return HomeHistoryTile(
                      ridePref: ridePref,
                      onPressed: () =>
                          _onRidePreferenceSelected(context, ridePref),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
