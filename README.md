# FlexibleWrap

FlexibleWrap is a Flutter widget that provides an advanced wrap layout with flexible spacing and RTL support. It automatically distributes available space between items in a row, similar to Wrap widget but with additional features:

- Automatically expands items to fill available space in a single row
- Supports right-to-left (RTL) text direction
- Maintains consistent spacing between items
- Handles dynamic wrapping based on parent constraints

Perfect for implementing uniform grid layouts like product cards, image galleries, or any UI that requires evenly-spaced wrapped items.

## Showcase

![showcase](https://github.com/bixat/flexible_wrap/blob/main/showcase.gif?raw=true)

## Features

- **Dynamic Wrapping**: Automatically wraps widgets onto the next line based on the available space.
- **Flexible Spacing**: Adjusts spacing between items and runs to achieve the desired visual appearance.
- **Expanded Items**: Expands the items to fill the available space on the row.
- **RTL Support**: Provides support for right-to-left text direction, ensuring proper layout and alignment for RTL languages.

_Note: We currently support [only items that have the same width](https://github.com/bixat/flexible_wrap/issues/10); [height direction is not supported yet](https://github.com/bixat/flexible_wrap/issues/11)_

## Getting Started

To get started with FlexibleWrap, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  flexible_wrap: ^latest_version
```

Replace `^latest_version` with the current version of the package.

Then, import it in your Dart file:

```dart
import 'package:flexible_wrap/flexible_wrap.dart';
```

## Usage

Here's a basic example of how to use FlexibleWrap:

```dart
FlexibleWrap(
  isOneRowExpanded: true,
  spacing: 12.0,
  children: List.generate(3, (int index) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0)),
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
      ),
    );
  }).toList(),
),
```

## Customization

FlexibleWrap offers several customization options to tailor the layout to your needs:

- **one row behavior**: Specify one row behavior using `isOneRowExpanded`.

## Contributing

Contributions to FlexibleWrap are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

FlexibleWrap is licensed under the MIT License. See the LICENSE file for details.
