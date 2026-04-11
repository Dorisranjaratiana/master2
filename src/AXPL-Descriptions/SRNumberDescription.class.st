"
""Description d'un champ numérique.
Génère un SpTextInput avec conversion asNumber.
Utilisé pour : Âge, scores, quantités.""
"
Class {
	#name : 'SRNumberDescription',
	#superclass : 'SRDescription',
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRNumberDescription >> accept: aVisitor [
	^ aVisitor visitNumberDescription: self
]

{ #category : 'visiting' }
SRNumberDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitNumberDescription: self
]
