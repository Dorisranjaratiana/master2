"
""Description d'un champ date.
Génère un SpTextInput avec format JJ/MM/AAAA.
Utilisé pour : Date d'Admission, date de naissance.""
"
Class {
	#name : 'SRDateDescription',
	#superclass : 'SRDescription',
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRDateDescription >> accept: aVisitor [
	^ aVisitor visitDateDescription: self
]

{ #category : 'visiting' }
SRDateDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitDateDescription: self
]
