# KubeCheck
Je sais pas.
## Compilation
Pour utiliser KubeCheck, il vous faudra éxécuter le script `compile_and_run.sh` :
```bash
./compile_and_run.sh
```
Assurez-vous que le fichier kube_status.txt soit bien dans le même répertoire que le build. Sinon, il vous sera demandé de le modifier dans le script, ou d'éxécuter vous-même le binaire.

## Commandes
### Utilisation du programme
```bash
kubecheck /lien/vers/le/fichier/kube_status.txt [COMMANDE_OPTIONNEL]
```
### Liste des commandes
- `(aucune commande précisé)` : Démo complète du programme.
- `--count-service-container <nom d'un service>` : Retourne l'utilisation de CPU et de RAM d'un type de service demandé.
- `--service-usage <nom d'un service>` : Retourne le nombre de conteneurs correspondant à un type de service demandé.
