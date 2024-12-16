struct Node:NodeProtocol{
    var id: Int
    var pods: [PodProtocol]
    var cpu: Int
    var ram: Int

    init(id: Int, pods: [PodProtocol], cpu: Int, ram: Int){
        self.id = id
        self.pods = pods
        self.cpu = cpu
        self.ram = ram
    }
    
    func GetAvailableCPU() -> Int {
    return 0
    }

    func GetAvailableRAM() -> Int {
    return 0
    }
}