"
""Description d'un champ texte libre.
Génère un SpTextInput dans le visiteur.
Utilisé pour : Nom, Prénom, N° Chambre, Téléphone, etc.""
"
Class {
	#name : 'SRStringDescription',
	#superclass : 'SRDescription',
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRStringDescription >> accept: aVisitor [
	^ aVisitor visitStringDescription: self
]

{ #category : 'visiting' }
SRStringDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitStringDescription: self
]
