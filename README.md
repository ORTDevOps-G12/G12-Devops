# Universidad ORT Uruguay Facultad de Ingeniería

> [!IMPORTANT]
> Ir agregando información

## Flujo de Trabajo
Para gestionar el versionado del proyecto, hemos implementado flujos de trabajo diferenciando para la parte de desarrollo y DevOps., adaptados a las necesidades de cada etapa del proyecto: Gitflow para el desarrollo y Trunk-Based para DevOps.

### - Gitflow para Desarrollo
Se utiliza GitFlow como estrategia de versionado para los proyectos de desarrollo, ya que facilita la gestión eficiente del flujo de trabajo colaborativo. GitFlow es una metodología que permite estructurar el desarrollo en ramas distintas (develop, test, release y main) para representar los diferentes ambientes del ciclo de desarrollo. Esto hace más sencillo dividir las responsabilidades entre los equipos de desarrollo y operaciones.

Al mantener el desarrollo continuo en la rama develop y las versiones estables en main, esta metodología garantiza una gestión eficaz del versionado que minimiza los riesgos y conflictos en el código base. Adicionalmente, se pueden realizar correcciones específicas en diferentes entornos si se detectan errores, utilizando ramas auxiliares para cada corrección. Esto ayuda a mejorar la estabilidad y mantenibilidad del software.

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
Con el objetivo de mejorar la colaboración en tiempo real y aumentar la eficiencia en la creación y mantenimiento de nuestra documentación técnica y operativa, hemos decidido implementar Trunk Based Development como parte de nuestro proceso DevOps.

Con este enfoque, podemos colaborar de forma continua y actualizar documentos al instante para garantizar que todos los miembros del equipo estén trabajando con las versiones más actualizadas y aprobadas. Implementar esta práctica disminuye las complicaciones y diferencias ocasionadas por diversas versiones del documento, además de agilizar los procesos para recibir rápidamente feedback que permita detectar errores o determinar mejoras necesarias.

La mejoría de la visibilidad y auditabilidad de la documentación también se logra mediante Trunk Based Development, ya que este enfoque proporciona una única fuente confiable que refleja fielmente el estado actual y los cambios a lo largo del proyecto.

![Diagrama de TrunkBased para DevOps](./Imagenes/Trunkbased-Devops.png)

#### Ramas Principales
- **main**: Rama que contiene la ultima version de los documentos

#### Ramas de Soporte (ramas auxiliares)
- **Feature**: Rama para trabajar los diferentes documentos del proceso DevOps.



> [!IMPORTANT]
> Justificar brevemente al eleccion de cada herramienta (Elegir las herrameintas que faltan)
## Herramientas elegidas
- Planificación: 
    - Azure Boards
- Code: 
    - GitHub
- Build:
    - GitHub actions
    - Apache Maven

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

- CI/CD:
    - GitHub actions

- Deploy (consultar)
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

- Cloud
    - AWS (Amazon Web Services)






