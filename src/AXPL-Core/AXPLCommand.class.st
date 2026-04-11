"
""Encapsule une commande exécutable (label + actionBlock).
Implémente le pattern Commande.
Peut être utilisé pour encapsuler les intercessions Ψ sous forme d'actions annulables.""
"
Class {
	#name : 'AXPLCommand',
	#superclass : 'Object',
	#instVars : [
		'label',
		'actionBlock'
	],
	#category : 'AXPL-Core',
	#package : 'AXPL-Core'
}

{ #category : 'visiting' }
AXPLCommand >> accept: aVisitor [
    ^ aVisitor visitCommand: self
]

{ #category : 'accessing' }
AXPLCommand >> actionBlock: aBlock [
    actionBlock := aBlock
]

{ #category : 'executing' }
AXPLCommand >> execute [
    actionBlock value
]

{ #category : 'accessing' }
AXPLCommand >> label [
	^ label
]

{ #category : 'accessing' }
AXPLCommand >> label: aString [
    label := aString
]
