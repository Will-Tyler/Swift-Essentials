## Swift Essentials

This project is a Swift framework that includes very useful tools to increase development speed, ease of use, and other helping additions on top of the Swift language. This framework strives to include tests for most of the features it offers.

## Organization
* Features that are not exclusive to macOS or iOS through the use of Cocoa / Appkit, or other functionality, are organized in the Essentials folder.
* Features that are exclusive to a platform are stored in their respective EssentialsMacOS / EssentialsiOS folders.
* Extensions are stored in files of the same name as the class / struct that the extension is extending.

## Features
* Pre- and post-, increment and decrement operators for BinaryInteger, which Swift standard integer types, such as Int and UInt, conform to.
* A generic stack class that manages data and exposes several stack methods to modify the data.
* A random class that uses static methods to aid in generating random numbers, or selecting a member at random from a collection.

## In the Works / Room for Improvement
* A number struct that stores integers as a decimal-formatted string. This struct aims to include nearly all of the functionality that standard ints use, with essentially unlimited potential in regards to how much value the struct can store.
* Several classes / structs from the Swift Cocoa API could likely be improved through extensions or subclasses.

## License
This project uses an MIT license.
