import Foundation

// Récupération du statut du cluster
func parseClusterStatus(fileContent: String) -> ClusterProtocol {
    print("Parsing du fichier en cours... ")
    var cluster: ClusterProtocol = Cluster(id:1,nodes: [])
    var lastNodeIndex: Int = 0
    var lastPodIndex: Int = 0
    for line in fileContent.split(separator: "\n") {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)

        // Check for node information
        if trimmedLine.hasPrefix("Node:") {
            print("un noeud est détecté")
            lastNodeIndex += 1
            lastPodIndex = 0
            let node:Node = Node(id:Int(trimmedLine.split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!,parentCluster: cluster)
            cluster.nodes.append(node)
        } 
        // Check for node resources
        else if trimmedLine.hasPrefix("Ressources:") {
            let resources = trimmedLine.replacingOccurrences(of: "Ressources: ", with: "").split(separator: "|")
            let cpu = Int(resources[0].split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!
            let ram = Int(resources[1].split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!
            cluster.nodes[lastNodeIndex - 1].cpu = cpu
            cluster.nodes[lastNodeIndex - 1].ram = ram
        } 
        // Check for pod information
        else if trimmedLine.hasPrefix("Pod:") {
            lastPodIndex += 1
            let podId = Int(trimmedLine.split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!
            let pod:PodProtocol = Pod(id:podId,containers: [],parentNode: cluster.nodes[lastNodeIndex - 1])
            cluster.nodes[lastNodeIndex - 1].pods.append(pod)
        } 
        // Check for container information
        else if trimmedLine.hasPrefix("Container:") {
            let containerDetails = trimmedLine.replacingOccurrences(of: "Container: ", with: "").split(separator: "|")
            let containerName = containerDetails[0].split(separator: " ")[0]
            let containerStatus = containerDetails[1].split(separator: ":")[1].trimmingCharacters(in: .whitespaces)
            let containerCpu = Int(containerDetails[2].split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!
            let containerRam = Int(containerDetails[3].split(separator: ":")[1].trimmingCharacters(in: .whitespaces))!
            let container: ContainerProtocol = Container(serviceName: String(containerName), status: ContainerStatus(rawValue: containerStatus)!, cpu: containerCpu, ram: containerRam,parentPod:cluster.nodes[lastNodeIndex - 1].pods[lastPodIndex - 1])
            cluster.nodes[lastNodeIndex - 1].pods[lastPodIndex - 1].containers.append(container)
        }
    }
    print("fin du parsing.\n")
    return cluster
}
