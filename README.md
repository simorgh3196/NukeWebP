# NukeWebP

WebP image decoder for [Nuke](https://github.com/kean/Nuke) written in swift. It support progressive WebP


## Usage

For basic decoder:

```swift
import NukeWebP
import NukeWebPBasic

WebPImageDecoder.enable(auto: BasicWebPDecoder())

```

For advanced decoder:

```swift
import NukeWebP
import NukeWebPAdvanced

WebPImageDecoder.enable(closure: {
  var options = WebPDecoderOptions()
  options.useThreads = true
  return AdvancedWebPDecoder(options: options)
})

```

## Minimum Requirements

| Swift | Xcode | iOS | macOS | tvOS | watchOS |
|:-----:|:-----:|:---:|:-----:|:----:|:-------:|
| 5.6 | 13.3 | 13.0 | 10.15 | 13.0 | 6.0 |

## Dependencies
| [Nuke](https://github.com/kean/Nuke) | [libwebp](https://github.com/SDWebImage/libwebp-Xcode) |
|:---:|:---:|
| >= 11.2.1 | >=v1.2.1 |

## Author

makleso6, makleso6@gmail.com

## License

NukeWebP is available under the MIT license. See the LICENSE file for more info.
