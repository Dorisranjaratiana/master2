"
""Description d'un champ à choix multiples.
Contient une collection d'options.
Génère un SpDropList dans le visiteur.
Utilisé pour : Sexe, statut, catégorie.""
"
Class {
	#name : 'SRSelectionDescription',
	#superclass : 'SRDescription',
	#instVars : [
		'options'
	],
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRSelectionDescription >> accept: aVisitor [
	^ aVisitor visitSelectionDescription: self
]

{ #category : 'visiting' }
SRSelectionDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitSelectionDescription: self
]

{ #category : 'accessing' }
SRSelectionDescription >> options [
	^ options ifNil: [ options := OrderedCollection new ]
]

{ #category : 'accessing' }
SRSelectionDescription >> options: aCollection [
	options := aCollection
]
