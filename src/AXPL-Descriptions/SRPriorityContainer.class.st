"
""Conteneur ordonné de descriptions. Source unique de vérité du framework.
Reçoit toutes les descriptions via add: et les expose via children.
Créé une seule fois par targetObject: et gardé en mémoire dans metaContainer.
Ψ intercède directement sur ce container pour modifier les descriptions à l'exécution.""
"
Class {
	#name : 'SRPriorityContainer',
	#superclass : 'SRDescription',
	#instVars : [
		'children'
	],
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRPriorityContainer >> accept: aVisitor [
	^ aVisitor visitPriorityContainer: self
]

{ #category : 'adding' }
SRPriorityContainer >> add: aDescription [
	self children add: aDescription
]

{ #category : 'adding' }
SRPriorityContainer >> addAll: aCollection [
	aCollection do: [ :each | self add: each ]
]

{ #category : 'accessing' }
SRPriorityContainer >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]
