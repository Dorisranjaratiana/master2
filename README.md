# Framework AXΨL - Gouvernance Adaptative des Interfaces

Framework Low-Code pour la gouvernance native des interfaces adaptatives intelligentes.

## Chargement en une ligne (Pharo 13) 
```st
Metacello new
    baseline: 'AXPL';
    repository: 'github://Dorisranjaratiana/master2:master/src';
    load.
```

## Utilisation
```st
SRFormApp new
    targetObject: ClientHopital new;
    open.
```
```st
SRFormApp new
    targetObject: Etudiant new;
    open.
```
## Architecture

Le framework intègre quatre dimensions :
- **A** - Adaptation intelligente (AXPLFormBuilder)
- **X** - Explicabilité native (SRDescription)
- **Ψ** - Réflexivité actionnable (AXPLReflexivityEngine)
- **L** - Accessibilité Low-Code (SRFormApp)

## Packages

- `AXPL-Descriptions` - Méta-description
- `AXPL-Core` - Moteurs A et Ψ
- `AXPL-UI` - Interface L
- `AXPL-Tests` - 8 tests unitaires

## Licence

MIT License - voir fichier LICENSE.

## Inspirations

La couche de méta-description est inspirée de 
[SimpleRene](https://github.com/pharo-contributions/SimpleRene) 
- Ducasse et al., MIT License.

## Auteur

RANJARATIANA Doris Michel - ENI Fianarantsoa - 2026
