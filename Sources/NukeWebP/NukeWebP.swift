import Nuke
import Foundation

#if !os(macOS)
import UIKit.UIImage
#else
import AppKit.NSImage
#endif

#if !os(macOS)
public typealias ImageType = UIImage
#else
public typealias ImageType = NSImage
#endif

public protocol WebPDecoding: AnyObject, Sendable {
    func decode(data: Data) throws -> ImageType
    func decodei(data: Data) throws -> ImageType
}

private let _queue = DispatchQueue(label: "com.webp.decoder", autoreleaseFrequency: .workItem)

public final class WebPImageDecoder: ImageDecoding, Sendable {

    private let decoder: any WebPDecoding
    
    public init(decoder: some WebPDecoding) {
        self.decoder = decoder
    }
    
    public func decode(_ data: Data) throws -> ImageContainer {
        try _queue.sync(execute: {
            let image = try decoder.decode(data: data)
            return ImageContainer(image: image, type: .webp, data: data)
        })
    }

    public func decodePartiallyDownloadedData(_ data: Data) -> ImageContainer? {
        do {
            return try _queue.sync(execute: {
                let image = try decoder.decodei(data: data)
                return ImageContainer(image: image, type: .webp, data: data)
            })
        } catch {
            return nil
        }
    }
}

// MARK: - check webp format data.
extension WebPImageDecoder {
    
    public static func enable(closure: @escaping () -> some WebPDecoding) {
        ImageDecoderRegistry.shared.register { (context) -> ImageDecoding? in
            WebPImageDecoder.enable(context: context, closure: closure)
        }
    }
    
    public static func enable(auto closure: @escaping @autoclosure () -> some WebPDecoding) {
        ImageDecoderRegistry.shared.register { (context) -> ImageDecoding? in
            WebPImageDecoder.enable(context: context, closure: closure)
        }
    }

    public static func enable(context: ImageDecodingContext,
                              closure: @escaping () -> some WebPDecoding) -> ImageDecoding? {
        /// Use native WebP decoder for decode image
        if #available(OSX 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            return nil
        } else {
            let type = AssetType(context.data)
            if type == .webp {
                return WebPImageDecoder(decoder: closure())
            }
        }
        return nil
    }
}

