import Foundation

protocol NodeProtocol {
    var id: Int { get }
    var pods: [PodProtocol] { get set }
    var cpu: Int { get set }
    var ram: Int { get set }

    init(id: Int, pods: [PodProtocol], cpu: Int, ram: Int,parentCluster:ClusterProtocol?)
    init(id: Int,parentCluster:ClusterProtocol?)
    
    func GetAvailableCPU() -> Int
    func GetAvailableRAM() -> Int
}