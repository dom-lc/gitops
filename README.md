# GitOps

Playing with ArgoCd</br></br>
This is for purpose of testing and showcasing usecases; be aware that some techniques employed will not consist of the best security practices, or be 100% relevant to your comply with your needs.  

## Infrastructure

### setup.sh

The ```./_infrastucture``` contains a ```setup.sh``` script necessary to play with the current repo. Open a terminal in the infrastructure root and run the script [setup.sh](./infrastructure/setup.sh) as root.
It will install Kind and start a single node cluster for your on your local.
</br>*Please Note: this script has been made to be ran on a Ubuntu 24.04 WSL. Will work fine on Ubuntu VM to.*</br></br>

When the script has finished running, you will see your argocd credentials, you can simply login to the ArgoCD UI on localhost:8080. The credentials will be shown for you in your terminal before port-forwarding the service.</br>
*Note: do not close this terminal as it is responsible for the prot-forwarding*

### env-init.sh

The ```./_infrastucture``` contains a ```env-init.sh```script that will make use of the application object to self manage itself. It references the chart used byour ```setup.sh``` script (argocd helm chart v6.10.2 as used by lc) and takes it's values from our values file located in our ```./apps/argocd```.