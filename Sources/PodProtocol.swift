import Foundation

protocol PodProtocol {
    var containers: [ContainerProtocol] { get }
    var id: Int { get }

    init(containers: [ContainerProtocol], id: Int)

    func GetUsedCPU() -> Int
    func GetUsedRAM() -> Int
}
