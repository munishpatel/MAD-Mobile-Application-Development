import 'package:yaml/yaml.dart';
import 'processes.dart';

/// Queueing system simulator.
class Simulator {
  final bool verbose;

  List<Process> processes = [];
  List<Event> eventQueue = [];
  List<Event> processedEvents = [];

  Simulator(YamlMap yamlData, {this.verbose = false}) {
    for (final name in yamlData.keys) {
      final fields = yamlData[name];

      switch (fields['type']) {
        case 'singleton':
          processes.add(SingletonProcess(
            name,
            fields['duration'],
            fields['arrival'],
          ));
          break;
        case 'periodic':
          processes.add(PeriodicProcess(
            name,
            fields['duration'],
            fields['interarrival-time'],
            fields['first-arrival'],
            fields['num-repetitions'],
          ));
          break;
        case 'stochastic':
          processes.add(StochasticProcess(
            name,
            fields['mean-duration'],
            fields['mean-interarrival-time'],
            fields['first-arrival'],
            fields['end'],
          ));
          break;
      }
    }
  }

  void run() {
    for (Process process in processes) {
      eventQueue.addAll(process.generateEvents());
    }
    eventQueue.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
    
    int currentTime = 0;
    // Processing events untill the eventQueue is empty
    while (eventQueue.isNotEmpty)
    {
      // Retrieving the next event from the queue
      Event event = eventQueue.removeAt(0);
      if (currentTime < event.arrivalTime) {
        currentTime = event.arrivalTime;
      }
      event.setStartTime(currentTime);
      currentTime = currentTime + event.duration;
      // Adding the processed event to the list of completed events.
      processedEvents.add(event);

      // Printing details of the event processing verbose mode is on.
      if (verbose) {
        print('t=${event.startTime}: ${event.processName}, duration ${event.duration} started (arrived @ ${event.arrivalTime}, waited ${event.waitTime})');
      }
    }
  }

  void printReport() {
    Map<String, List<Event>> processEvents = {};

    // Looping through all processed events and grouping them by their process name.
    for (var event in processedEvents) {
      processEvents.putIfAbsent(event.processName, () => []).add(event);
    }

    print('--------------------------------------------------------------');
    print('Per-process statistics');

    for (var entry in processEvents.entries) {
      String processName = entry.key;
      List<Event> events = entry.value;
      int totalWaitTime = events.fold(0, (sum, e) => sum + e.waitTime);
      double averageWaitTime = totalWaitTime / events.length;

      // Printing the statistics on per-process basis
      print('$processName:');
      print('  Events generated:  ${events.length}');
      print('  Total wait time:   $totalWaitTime');
      print('  Average wait time: ${averageWaitTime.toStringAsFixed(2)}');
    }

    // Printing the summary statistics
    print('--------------------------------------------------------------');
    print('Summary statistics');
    print('Total num events:  ${processedEvents.length}');

    double totalWaitTime = processedEvents.fold(0, (sum, e) => sum + e.waitTime);
    double averageWaitTime = totalWaitTime / processedEvents.length;

    print('Total wait time:   $totalWaitTime');
    print('Average wait time: ${averageWaitTime.toStringAsFixed(2)}');
  }
}
