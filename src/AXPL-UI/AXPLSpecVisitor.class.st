"
""Visiteur Spec2 qui génère les widgets UI depuis les descriptions. 
Implémente les relations ⑦ (Méta → L) et ⑧ (L → Utilisateur).
Chaque visitXxx: génère le widget approprié avec label, tooltip (②) et binding.
visit: parcourt une collection de descriptions et retourne un SpBoxLayout vertical.
withLabel:for: assemble label + widget en ligne horizontale.
Travaille toujours sur le metaContainer partagé via les descriptions filtrées.""
"
Class {
	#name : 'AXPLSpecVisitor',
	#superclass : 'Object',
	#instVars : [
		'presenter',
		'targetObject'
	],
	#category : 'AXPL-UI',
	#package : 'AXPL-UI'
}

{ #category : 'building' }
AXPLSpecVisitor >> buildComponentFor: aSlot [
	| row |
	"1. Création d'une ligne horizontale"
	row := SpBoxLayout newHorizontal spacing: 10.
	
	"2. Ajout du Label (Nom de la variable)"
	row add: (presenter newLabel label: aSlot name capitalized) width: 120.
	
	"3. Ajout du Champ de saisie avec la valeur réelle de l'objet (Ψ Réflexivité)"
	row add: (presenter newTextInput 
		text: (targetObject readSlot: aSlot) asString) 
		expand: true.
		
	^ row
]

{ #category : 'accessing' }
AXPLSpecVisitor >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : 'accessing' }
AXPLSpecVisitor >> targetObject: anObject [
	"Cette méthode permet d'injecter n'importe quel objet de l'extérieur"
	targetObject := anObject.
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visit: aCollection [
    | mainLayout |
    mainLayout := SpBoxLayout newVertical spacing: 8.
    aCollection do: [ :desc |
        mainLayout add: (desc acceptSimpleReneVisitor: self) expand: false ].
    ^ mainLayout
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitBooleanDescription: aDesc [
    | checkbox currentLevel explicabilityText |
    
    currentLevel := presenter levelDropList selectedItem.
    explicabilityText := aDesc commentFor: currentLevel.

    checkbox := presenter newCheckBox.
    checkbox label: aDesc label.
    "CORRECTION : On passe la String extraite, pas le dictionnaire"
    checkbox help: (explicabilityText isString ifTrue: [ explicabilityText ] ifFalse: [ '' ]).
    
    checkbox state: (targetObject perform: aDesc accessor).
    checkbox whenActivatedDo: [ targetObject perform: aDesc accessor asMutator with: true ].
    checkbox whenDeactivatedDo: [ targetObject perform: aDesc accessor asMutator with: false ].

    ^ checkbox
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitCommand: aCommand [
    | button |
    button := presenter newButton.
    button label: aCommand label.
    button action: [ aCommand execute ].
    
    "Optionnel : on pourrait ajouter une icône ici"
    ^ button
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitDateDescription: aDescription [
    | input dateValue currentLevel explicabilityText label |
    
    currentLevel := presenter levelDropList selectedItem.
    explicabilityText := aDescription commentFor: currentLevel.

    input := presenter newTextInput.
    input placeholder: 'JJ/MM/AAAA'.
    dateValue := targetObject perform: aDescription accessor.
    input text: (dateValue ifNil: [ '' ] ifNotNil: [ dateValue asString ]).
    
    input whenTextChangedDo: [ :txt | 
        [ targetObject perform: aDescription accessor asMutator with: txt asDate ] 
            on: Error do: [ :ex | "Ignore" ] ].

    label := presenter newLabel label: aDescription label.
    label help: (explicabilityText isString ifTrue: [ explicabilityText ] ifFalse: [ '' ]).

    ^ self withLabel: label for: input
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitDescription: aDescription [
	"Si on ne connaît pas le type spécifique, on affiche un champ texte par défaut"
	^ self visitStringDescription: aDescription
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitNumberDescription: aDescription [
    | input numValue currentLevel explicabilityText label |
    
    currentLevel := presenter levelDropList selectedItem.
    explicabilityText := aDescription commentFor: currentLevel.

    input := presenter newTextInput.
    numValue := targetObject perform: aDescription accessor.
    input text: (numValue ifNil: [ '0' ] ifNotNil: [ numValue asString ]).
    
    "Utilisation de la syntaxe standard Pharo"
    input whenTextChangedDo: [ :txt | 
        | converted |
        converted := [ txt asNumber ] on: Error do: [ 0 ].
        targetObject perform: aDescription accessor asMutator with: converted ].

    label := presenter newLabel label: aDescription label.
    label help: (explicabilityText isString ifTrue: [ explicabilityText ] ifFalse: [ '' ]).

    ^ self withLabel: label for: input
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitPriorityContainer: aContainer [
	| vLayout |
	vLayout := SpBoxLayout newVertical.
	vLayout spacing: 10.
	aContainer children do: [ :each | 
		vLayout add: (each acceptSimpleReneVisitor: self) expand: false ].
	^ vLayout
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitSelectionDescription: aDesc [
    | drop row label currentLevel explicabilityText |
    
    currentLevel := presenter levelDropList selectedItem.
    explicabilityText := aDesc commentFor: currentLevel.

    label := presenter newLabel label: aDesc label.
    label help: (explicabilityText isString ifTrue: [ explicabilityText ] ifFalse: [ '' ]).

    drop := presenter newDropList.
    drop items: aDesc options.
    drop selectItem: (targetObject perform: aDesc accessor).
    drop whenSelectedItemChangedDo: [ :item | 
        targetObject perform: aDesc accessor asMutator with: item ].

    row := SpBoxLayout newHorizontal spacing: 15.
    row add: label width: 140.
    row add: drop expand: true.
    ^ row
]

{ #category : 'visiting' }
AXPLSpecVisitor >> visitStringDescription: aDesc [
    | input row label currentLevel explicabilityText value |
    
    currentLevel := presenter levelDropList selectedItem.
    explicabilityText := aDesc commentFor: currentLevel.

    label := presenter newLabel label: aDesc label.
    label help: (explicabilityText isString ifTrue: [ explicabilityText ] ifFalse: [ '' ]).

    input := presenter newTextInput.
    value := targetObject perform: aDesc accessor.
    input text: (value ifNil: [ '' ] ifNotNil: [ value asString ]).
    input whenTextChangedDo: [ :txt | 
        targetObject perform: aDesc accessor asMutator with: txt ].

    row := SpBoxLayout newHorizontal spacing: 15.
    row add: label width: 140.
    row add: input expand: true.
    ^ row
]

{ #category : 'label' }
AXPLSpecVisitor >> withLabel: aLabel for: aWidget [
    "Si aLabel est déjà un Presenter (objet), on l'ajoute directement.
     Si c'est une String, on crée un nouveau label."
    | row labelPresenter |
    
    labelPresenter := (aLabel isString) 
        ifTrue: [ presenter newLabel label: aLabel ] 
        ifFalse: [ aLabel ]. "On garde l'objet label avec son .help"

    row := SpBoxLayout newHorizontal spacing: 15.
    row add: labelPresenter width: 140.
    row add: aWidget expand: true.
    ^ row
]
