import 'dart:collection';
import 'dart:io';
import 'dart:math';

class Range {
  int end;
  int offset;

  Range(this.end, this.offset);

  @override
  String toString() {
    return "[end ${end} | offset ${offset}]";
  }
}

int solve(String filePath) {
  var file = File(filePath);
  var lines = file.readAsLinesSync();

  var seedsInput = lines[0].replaceFirst("seeds: ", "");
  var seeds = seedsInput.split(" ").map((seed) => int.parse(seed)).toList();

  SplayTreeMap<int, Range> seedToSoilMap = SplayTreeMap();
  SplayTreeMap<int, Range> soilToFertilizerMap = SplayTreeMap();
  SplayTreeMap<int, Range> fertilizerToWaterMap = SplayTreeMap();
  SplayTreeMap<int, Range> waterToLightMap = SplayTreeMap();
  SplayTreeMap<int, Range> lightToTemperatureMap = SplayTreeMap();
  SplayTreeMap<int, Range> temperatureToHumidityMap = SplayTreeMap();
  SplayTreeMap<int, Range> humidityToLocationMap = SplayTreeMap();

  var compass = {
    "seed-to-soil map:": seedToSoilMap,
    "soil-to-fertilizer map:": soilToFertilizerMap,
    "fertilizer-to-water map:": fertilizerToWaterMap,
    "water-to-light map:": waterToLightMap,
    "light-to-temperature map:": lightToTemperatureMap,
    "temperature-to-humidity map:": temperatureToHumidityMap,
    "humidity-to-location map:": humidityToLocationMap
  };

  var atlas = [
    seedToSoilMap,
    soilToFertilizerMap,
    fertilizerToWaterMap,
    waterToLightMap,
    lightToTemperatureMap,
    temperatureToHumidityMap,
    humidityToLocationMap
  ];

  var lineIter = lines.iterator;
  lineIter.moveNext();
  SplayTreeMap<int, Range>? currentMap;
  while (lineIter.moveNext()) {
    if (lineIter.current.isEmpty) {
      if (!lineIter.moveNext()) break;
      if (!compass.containsKey(lineIter.current)) {
        throw Exception("invalid range map ${currentMap}");
      }
      currentMap = compass[lineIter.current];
      if (!lineIter.moveNext()) break;
    }
    currentMap = currentMap!;
    var input = lineIter.current.split(" ");
    var dest = int.parse(input[0]);
    var src = int.parse(input[1]);
    var range = int.parse(input[2]);
    currentMap[src] = Range(src + range - 1, dest - src);
  }

  // traverse
  int minLocation = -1 >>> 1;
  for (var seed in seeds) {
    int currValue = seed;
    for (var (_, map) in atlas.indexed) {
      var start = 0;
      var end = map.length - 1;
      var entries = map.entries.toList();
      while (start <= end) {
        var mid = start + (end - start) ~/ 2;
        if (entries[mid].key <= currValue &&
            currValue <= entries[mid].value.end) {
          currValue += entries[mid].value.offset;
          break;
        } else if (currValue >= entries[mid].key) {
          start = mid + 1;
        } else {
          end = mid - 1;
        }
      }
    }
    minLocation = min(minLocation, currValue);
  }

  return minLocation;
}

void main() {
  print("Part1 example -> ${solve("example.txt")}");
  print("Part1 example -> ${solve("input.txt")}");
}
