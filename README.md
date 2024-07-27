# FlexibleWrap

FlexibleWrap is a Flutter package designed to provide a flexible and customizable way to arrange widgets in a wrap layout. It allows developers to create dynamic layouts where widgets can wrap onto the next line based on available space, similar to how items behave in a shopping cart or a list of cards.

## Showcase

![showcase](https://github.com/bixat/flexible_wrap/blob/main/showcase.gif?raw=true)

## Features

## Features

- **Dynamic Wrapping**: Automatically wraps widgets onto the next line based on the available space.
- **Flexible Spacing**: Adjusts spacing between items and runs to achieve the desired visual appearance.
- **Expanded Items**: Expands the items to fill the available space on the row.

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

- **one row behavior**: Specify on row behavior using `isOneRowExpanded`.

## Contributing

Contributions to FlexibleWrap are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

FlexibleWrap is licensed under the MIT License. See the LICENSE file for details.
