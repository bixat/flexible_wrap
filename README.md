# FlexibleWrap

FlexibleWrap is a Flutter widget that provides an advanced wrap layout with flexible spacing and RTL support. It automatically distributes available space between items in a row, similar to Wrap widget but with additional features

Perfect for implementing uniform grid layouts like product cards, image galleries, or any UI that requires evenly-spaced wrapped items.

## Showcase

![showcase](https://github.com/bixat/flexible_wrap/blob/main/showcase.gif?raw=true)

## Features

- **Dynamic Wrapping**: Automatically wraps widgets onto the next line based on the available space.
- **Expanded Items**: Expands the items to fill the available space on the row.
- **RTL Support**: Provides support for right-to-left text direction, ensuring proper layout and alignment for RTL languages.
- **Customizable Spacing**: Control both horizontal and vertical spacing between items
- **One Row Expansion**: Option to expand items when they fit in a single row

_Note: We currently support [only items that have the same width](https://github.com/bixat/flexible_wrap/issues/10); [height direction is not supported yet](https://github.com/bixat/flexible_wrap/issues/11)_

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flexible_wrap: ^latest_version
```

Then run:

```bash
$ flutter pub get
```

## Example Demo

Check out the live demo of FlexibleWrap at [https://bixat.github.io/flexible_wrap/](https://bixat.github.io/flexible_wrap/)

## Usage

First, import the package:

```dart
import 'package:flexible_wrap/flexible_wrap.dart';
```

Here's a basic example of how to use FlexibleWrap:

```dart

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final spacing = 12.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FlexibleWrap(
          spacing: spacing,
          runSpacing: spacing,
          textDirection: TextDirection.rtl,
          children: List.generate(20, (int index) {
            return Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
              child: const Center(
                child: ListTile(
                  title: Text(
                    "Lorem Ipsum is simply dummy text",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Lorem Ipsum has been the industry's standard",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: Icon(
                    Icons.insert_emoticon,
                    color: Colors.white,
                    size: 60.0,
                  ),
                  trailing: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
```

## Customization

FlexibleWrap offers several customization options to tailor the layout to your needs:

### Parameters

| Parameter          | Type            | Default  | Description                                      |
| ------------------ | --------------- | -------- | ------------------------------------------------ |
| `children`         | `List<Widget>`  | Required | The widgets to display in the wrap layout        |
| `spacing`          | `double`        | `0.0`    | Horizontal space between children                |
| `runSpacing`       | `double`        | `0.0`    | Vertical space between runs                      |
| `textDirection`    | `TextDirection` | `null`   | The text direction for RTL support               |
| `isOneRowExpanded` | `bool`          | `false`  | Whether to expand items when they fit in one row |

### Common Use Cases

1. **Grid Layout**:

```dart
FlexibleWrap(
  spacing: 8.0,
  runSpacing: 8.0,
  children: items,
)
```

2. **RTL Support**:

```dart
FlexibleWrap(
  spacing: 8.0,
  textDirection: TextDirection.rtl,
  children: items,
)
```

## Contributing

We welcome contributions to FlexibleWrap! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please make sure to update tests and documentation as appropriate.

## License

FlexibleWrap is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
