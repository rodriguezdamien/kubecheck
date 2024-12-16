import Foundation

protocol ContainerProtocol {
    var serviceName: String { get }
    var status: ContainerStatus { get }
    var cpu: Int { get }
    var ram: Int { get }
    var parentPod: PodProtocol? { get }

    init(serviceName: String, status: ContainerStatus, cpu: Int, ram: Int,parentPod: PodProtocol?)

    func Restart() throws
}