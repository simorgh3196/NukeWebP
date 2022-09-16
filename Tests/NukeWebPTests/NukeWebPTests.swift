@testable import NukeWebP
import XCTest
import NukeWebPAdvanced
import NukeWebPBasic
import Nuke

final class NukeWebPTests: XCTestCase {

    override func setUp() {
        ImageDecoderRegistry.shared.clear()
    }

    func testToEnableBasicWebPDecoder() {
        WebPImageDecoder.enable(auto: BasicWebPDecoder())
    }

    func testToEnableAdvancedWebPDecoder() {
        WebPImageDecoder.enable(closure: {
            var options = WebPDecoderOptions()
            options.useThreads = true
            return AdvancedWebPDecoder(options: options)
        })
    }
}
