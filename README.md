# FlexibleWrap

FlexibleWrap is a Flutter widget that provides an advanced wrap layout with flexible spacing and RTL support. It automatically distributes available space between items in a row, similar to Wrap widget but with additional features:

Perfect for implementing uniform grid layouts like product cards, image galleries, or any UI that requires evenly-spaced wrapped items.

## Showcase

![showcase](https://github.com/bixat/flexible_wrap/blob/main/showcase.gif?raw=true)

## Features

- **Dynamic Wrapping**: Automatically wraps widgets onto the next line based on the available space.
- **Flexible Spacing**: Adjusts spacing between items and runs to achieve the desired visual appearance.
- **Expanded Items**: Expands the items to fill the available space on the row.
- **RTL Support**: Provides support for right-to-left text direction, ensuring proper layout and alignment for RTL languages.

_Note: We currently support [only items that have the same width](https://github.com/bixat/flexible_wrap/issues/10); [height direction is not supported yet](https://github.com/bixat/flexible_wrap/issues/11)_

## Benchmarks: GridView vs. FlexibleWrap

| Feature              | GridView                                                                                     | FlexibleWrap                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **Description**      | A layout that arranges items in a grid format.                                               | It automatically distributes available space between items in a row.                             |
| **Usage**            | Efficient for uniform item sizes.                                                            | Ideal for dynamic item sizes and wrapping.                                                       |
| **Performance**      | Better performance with a builder pattern.                                                   | Currently does not support a builder; uses children instead.                                     |
| **Screen Recording** | ![GridView](https://github.com/user-attachments/assets/90b5d6bf-dff4-4e54-8268-a75968d00551) | ![FlexibleWrap](https://github.com/user-attachments/assets/76c9f26a-a955-427b-a634-290eed41c7b9) |

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

## Important Implementation Note

When using FlexibleWrap with dynamic dimensions (height, width, or item count), you should add a ValueKey to force widget rebuilds when these properties change:

```dart
FlexibleWrap(
  key: ValueKey('$itemHeight-$itemWidth-$itemCount'), // Force rebuild when dimensions change
  spacing: spacing,
  runSpacing: runSpacing,
  isOneRowExpanded: isOneRowExpanded,
  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
  children: [
    // Your widgets here
  ],
)
```

**Why is this needed?**

The ValueKey ensures that Flutter recognizes the widget as "changed" when dimensions are updated, forcing a complete rebuild of the render object. This is particularly important when:

- Child widget dimensions change dynamically
- The number of children changes
- Layout properties are modified at runtime

Without the ValueKey, Flutter's widget tree optimization might prevent the render object from properly updating, leading to visual inconsistencies where dimension changes don't immediately reflect in the UI.

## Customization

FlexibleWrap offers several customization options to tailor the layout to your needs:

- **One Row Behavior**: Specify one row behavior using `isOneRowExpanded`.

## Contributing

Contributions to FlexibleWrap are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

FlexibleWrap is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
