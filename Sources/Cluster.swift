import Foundation

class Cluster: ClusterProtocol {
    var nodes: [NodeProtocol]
    var id: Int

    required init(id: Int, nodes:[NodeProtocol]){
        self.id = id
        self.nodes = nodes
    }

    /// Retourne les conteneurs selon le statut demandé.
    /// - Parameter status: Statut souhaité
    /// - Returns: liste des conteneurs correspondants
    func GetContainersByStatus(status:ContainerStatus) -> [ContainerProtocol] {
        var containersMatched:[ContainerProtocol] = []
        for node in nodes{
            for pod in node.pods {
                for container in pod.containers{
                    if container.status == status
                    {
                        containersMatched.append(container)
                    }
                }
            }
        }
        return containersMatched
    }

    /// Retourne les conteneurs selon le nom du service demandé.
    /// - Parameter serviceName: nom du service souhaité
    /// - Returns: liste des conteneurs correspondants
    func GetContainersByServiceName(serviceName:String) -> [ContainerProtocol] {
        var containersMatched:[ContainerProtocol] = []
        for node in nodes{
            for pod in node.pods {
                for container in pod.containers{
                    if container.serviceName == serviceName
                    {
                        containersMatched.append(container)
                    }
                }
            }
        }
        return containersMatched
    }

}