class Pod: PodProtocol{
    var containers: [ContainerProtocol]
    var id: Int
    var parentNode: NodeProtocol?

    required init (id:Int,containers:[ContainerProtocol],parentNode: NodeProtocol?){
        self.containers = containers
        self.id = id
        self.parentNode = parentNode
    }

    /// Retourne le nombre de CPU utilisé(s) dans le pod.
    /// - Returns: le nombre de CPU utilisé(s) dans le pod.
    func GetUsedCPU() -> Int {
        var usedCPU:Int = 0
        for container in containers {
            if(container.status == ContainerStatus.running){
                usedCPU += container.cpu
            }
        }
        return usedCPU
    }

    /// Retourne la RAM utilisée dans le pod.
    /// - Returns: la RAM utilisée dans le pod.
    func GetUsedRAM() -> Int {
        var usedRAM:Int = 0
        for container in containers{
            usedRAM += container.ram
        }
        return usedRAM
        }
}