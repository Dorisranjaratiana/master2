"
""Description d'un champ booléen.
Génère une SpCheckBox dans le visiteur.
Utilisé pour : Urgent, actif/inactif.""
"
Class {
	#name : 'SRBooleanDescription',
	#superclass : 'SRDescription',
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRBooleanDescription >> accept: aVisitor [
	^ aVisitor visitBooleanDescription: self
]

{ #category : 'visiting' }
SRBooleanDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitBooleanDescription: self
]
