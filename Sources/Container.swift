// Source : https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/
// Défini les erreurs (Exception) que pourrait lancer cette classe. (Pas d'erreur générique ?)
enum ContainerError: Error {
    case insufficientResources(message: String)
}

//J'ai eu l'idée de mettre les valeurs de CPU et RAM directement dans le fichier "kube_status.txt" dans les conteneurs arrêtés ou crash,
//et de n'inclure dans les calculs uniquement les conteneurs ayant le statut "running",
//mais il semblerait que l'énoncé demande ceci :
//(généré avec ChatGPT à partir du fichier kube_status.txt)
let defaultContainerResources: [String: [String: Int]] = [
    "nginx_webserver": ["ram": 8, "cpu": 2],
    "redis_cache": ["ram": 4, "cpu": 1],
    "postgres_db": ["ram": 8, "cpu": 2],
    "fluentd_logger": ["ram": 4, "cpu": 2],
    "api_service": ["ram": 2, "cpu": 1],
    "kafka_broker": ["ram": 10, "cpu": 10],
    "spark_worker": ["ram": 16, "cpu": 4],
    "mongodb": ["ram": 10, "cpu": 2],
    "frontend": ["ram": 2, "cpu": 1],
    "mysql_db": ["ram": 10, "cpu": 3],
    "auth_service": ["ram": 6, "cpu": 2],
    "worker_node": ["ram": 5, "cpu": 10],
    "logger": ["ram": 1, "cpu": 1],
    "backend_service": ["ram": 6, "cpu": 2],
    "job_scheduler": ["ram": 6, "cpu": 3],
    "alerting_service": ["ram": 1, "cpu": 1],
    "elasticsearch": ["ram": 20, "cpu": 1],
    "logstash": ["ram": 10, "cpu": 3],
    "monitoring_agent": ["ram": 4, "cpu": 2],
    "data_processor": ["ram": 10, "cpu": 10],
    "grafana_monitoring": ["ram": 4, "cpu": 2],
    "alert_manager": ["ram": 1, "cpu": 1],
    "prometheus": ["ram": 6, "cpu": 3]
]

///Définition de la classe conteneur.
class Container: ContainerProtocol {
    var serviceName: String
    var status: ContainerStatus
    var cpu: Int
    var ram: Int
    var parentPod: PodProtocol?

    /// Constructeur d'un objet conteneur.
    /// - Parameters:
    ///   - serviceName: Nom du service (du conteneur)
    ///   - status: Statut du conteneur.
    ///   - cpu: Nombre de CPU requis pour ce conteneur.
    ///   - ram: Nombre de Go de RAM requis pour ce conteneur.
    ///   - parentPod: Pod parent, contenant ce conteneur.
    required init(serviceName: String, status: ContainerStatus, cpu: Int, ram: Int, parentPod: PodProtocol?) {
        self.serviceName = serviceName
        self.status = status
        self.cpu = cpu
        self.ram = ram
        self.parentPod = parentPod
    }

    /// Redémarre le conteneur (change le status du conteneur en "running").
    /// - Throws: 
    ///   - insufficientResources: si il n'y a pas assez de ressource disponible dans le noeud parent. 
    func Restart() throws {
        let availableRAM: Int = (self.parentPod?.parentNode?.GetAvailableRAM())!
        let availableCPU: Int = (self.parentPod?.parentNode?.GetAvailableCPU())!
        //if availableCPU >= self.cpu && availableRAM >= self.ram{
        if availableCPU >= defaultContainerResources[self.serviceName]!["cpu"]! && availableRAM >= defaultContainerResources[self.serviceName]!["ram"]!{
            self.status = ContainerStatus.running
            self.cpu = defaultContainerResources[self.serviceName]!["cpu"]!
            self.ram = defaultContainerResources[self.serviceName]!["ram"]!
        }
        else {
            throw ContainerError.insufficientResources(message:"Il n'y a pas assez de ressource disponible pour redémarrer ce conteneur." +
            "\n RAM disponible(s) : \((self.parentPod?.parentNode?.GetAvailableRAM())!), RAM nécesssaire(s) : \(defaultContainerResources[self.serviceName]!["ram"]!) " +
            "\n CPU disponible(s) : \((self.parentPod?.parentNode?.GetAvailableCPU())!), CPU nécesssaire(s) : \(defaultContainerResources[self.serviceName]!["cpu"]!)")
        }
    }
}
