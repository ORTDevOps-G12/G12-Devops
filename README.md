# Universidad ORT Uruguay Facultad de Ingeniería

> [!IMPORTANT]
> Ir agregando información

## Flujo de Trabajo
Para gestionar el versionado del trabajo, hemos implementado dos flujos de trabajo distintos, adaptados a las necesidades de cada etapa del proyecto: Gitflow para el desarrollo y Trunk-Based para las prácticas de DevOps.

### - Gitflow para Desarrollo
Se han creado dos repositorios, uno para el Backend y otro para el Frontend, con el objetivo de facilitar la gestión del versionado. Ambos repositorios siguen la estructura de Gitflow, como se muestra en el siguiente diagrama:

![Diagrama de GitFlow para Desarrollo](./Imagenes/GitFlow-Desarrollo.png)

#### Ramas Principales (ramas estables)
- **Main**: Contiene el código de producción.
- **Release**: Contiene el código preparado para pasar a producción.
- **Test**: Contiene el código para pruebas integrales antes de ser liberado.
- **Develop**: Contiene el código para la próxima versión que está en desarrollo.

#### Ramas de Soporte (ramas auxiliares)
- **HotFix**: Ramas para corregir errores críticos en producción.
- **ReleaseFix**: Ramas para corregir errores en las versiones preparadas en la rama Release.
- **BugFix**: Ramas para corregir errores encontrados durante la relaización de pruebas.
- **Feature**: Ramas para desarrollar nuevas características.

### - Trunk-Based para DevOps
Para la parte de DevOps, se ha creado un repositorio que utiliza el flujo de trabajo Trunk-Based. Este enfoque permite una gestión sencilla y eficiente del código, facilitando la integración constante de los cambios. A continuación, se presenta un diagrama que ilustra esta estructura:

> [!CAUTION]
> Agregar Imagen

#### Ramas Principales
- **main**: Rama que contiene la ultima version ..

## Herramientas elegidas
- Planificación: Azure Boards
- Code: GitHub
- Build:
    - GitHub actions
    - Apache Maven
    - Gradle
    -Docker

- Test: (Pendiente definir, segun las pruebas extras a realizar)
    - Selenium
    - JUnit 
    - Postman
    - TestNG
    - SonarQube
    - SonarCloud
    - Blackduck
    - Fortify
    - Cypress
    - Mocha
    - Chai

CI/CD:
- GitHub actions

- Deploy (Pendiente definir)
    - Kubernetes
    - Docker
    - Ansible
    - Terraform
    - AWS CodeDeploy
    - OpenShift
    - Rancher
    - Nomad
    - Chef
    - Puppet


Cloud
•	AWS (Amazon Web Services)
•	Azure
•	Google Cloud Platform (GCP)
•	DigitalOcean
•	IBM Cloud
•	Oracle Cloud
•	Alibaba Cloud





