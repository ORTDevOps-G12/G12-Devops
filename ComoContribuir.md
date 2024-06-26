# Repositorio del Obligatorio-Documentacion
Este repositorio contiene el código y la documentación del Obligatorio.

## Estructura del Repositorio
El repositorio sigue un flujo de trabajo trunk based, donde la rama main es estable y contiene los archivos y documentos que se entregarán a la facultad una vez finalizado el proyecto.

- Rama estable

**main** : Esta rama contiene la versión estable del proyecto. Todos los cambios y adiciones deben integrarse en esta rama antes de la entrega final.

- Ramas auxiliares 

**feature/##** : Para agregar nuevos archivos, documentos o realizar cambios significativos, crea una rama feature descriptiva a partir de main. Una vez completado el trabajo en la rama feature, se fusionará de vuelta a main. Ejemplo de rama: "feature/documentacion-readme"

## Cómo Contribuir
Para contribuir al proyecto, seguir estos pasos:

1. **Clonar el repositorio:**

```
git clone https://github.com/ORTDevOps-G12/Obligatorio-Documentacion.git
cd nombre-del-repositorio
```

2. **Crea una rama feature:**

Antes de comenzar a trabajar en un cambio, crear una nueva rama feature basada en main:

```
git checkout main
git pull origin main
git checkout -b nombre-de-la-feature
```
Asegurarse de nombrar la rama feature de manera descriptiva, por ejemplo, feature/actualizar-documentacion.

3. **Realizar los cambios:**

Hacer los cambios necesarios en la rama feature. Añadir nuevos archivos, documentos, o realizar modificaciones según sea necesario.

4. **Hacer commit de los cambios:**

Una vez completados los cambios, hacer commit de ellos:

```
git add .
git commit -m "Breve descripción de los cambios realizados"
```

5. **Sincronizar con main y hacer merge:**

Antes de fusionar los cambios con main, asegurarse de estar actualizado y de que los cambios no causen conflictos:

```
git checkout main
git pull origin main
git merge --no-ff nombre-de-la-feature
```

6. **Elimina la rama feature (opcional):**

Si ya no se necesita la rama feature después de haberla fusionado, se puede eliminar del repositorio local y remoto:

```
git branch -d nombre-de-la-feature
git push origin --delete nombre-de-la-feature
```

7. **Envíar los cambios:**

Finalmente, envíar los cambios al repositorio remoto:

```
git push origin main
```