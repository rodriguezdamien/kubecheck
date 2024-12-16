//init container test

var containerTest1: ContainerProtocol = Container(serviceName:"test1",status:ContainerStatus.running,cpu:10,ram:4)
var containerTest2: ContainerProtocol = Container(serviceName:"test2",status:ContainerStatus.crashed,cpu:10,ram:10)
var containerTest3: ContainerProtocol = Container(serviceName:"test3",status:ContainerStatus.stopped,cpu:4,ram:128)
var containers: [ContainerProtocol] = [containerTest1,containerTest2,containerTest3]
var PodTest:PodProtocol = Pod(containers:containers,id:1)


//Pour chaque conteneur, on veut afficher son statut :
//Le conteneur [nom_du_conteneur] dans [nom_du_pod] sur [nom_du_nœud] ...

for container in PodTest.containers{
    switch container.status {
        case ContainerStatus.running:
            print("Le conteneur \(container.serviceName)")
        case ContainerStatus.stopped:
            print("")
        case ContainerStatus.crashed:
            print("")
    }
}

//Pour chaque pod on veut pouvoir connaître le nombre de CPUs et de RAM utilisés par ses conteneurs


print("Used RAM : \(PodTest.GetUsedRAM())")
print("Used CPU : \(PodTest.GetUsedCPU())")

