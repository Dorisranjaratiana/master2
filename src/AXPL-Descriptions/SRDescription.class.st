"
""Classe abstraite de base pour toutes les descriptions de champs.
Contient : label (nom affiché), accessor (symbole d'accès à l'objet),
properties (dictionnaire de propriétés dont le niveau d'accès),
comment (dictionnaire graduel #simple/#base/#expert).
Implémente le pattern Visiteur via accept: et acceptSimpleReneVisitor:.
Relation ② : chaque description porte son explication native (XAI).""
"
Class {
	#name : 'SRDescription',
	#superclass : 'Object',
	#instVars : [
		'label',
		'accessor',
		'properties',
		'comment'
	],
	#category : 'AXPL-Descriptions',
	#package : 'AXPL-Descriptions'
}

{ #category : 'visiting' }
SRDescription >> accept: aVisitor [
	^ aVisitor visitDescription: self
]

{ #category : 'visiting' }
SRDescription >> acceptSimpleReneVisitor: aVisitor [
    ^ aVisitor visitDescription: self
]

{ #category : 'accessing' }
SRDescription >> accessor [
	^ accessor
]

{ #category : 'accessing' }
SRDescription >> accessor: aSymbol [
	accessor := aSymbol
]

{ #category : 'accessing' }
SRDescription >> comment [
	"On surcharge le getter par défaut pour éviter que l'UI ne reçoive le Dict"
	^ self commentFor: #base "Par défaut, on donne la version de base"
]

{ #category : 'accessing' }
SRDescription >> comment: anObject [
    comment := anObject
]

{ #category : 'class' }
SRDescription >> commentFor: aLevel [
    comment ifNil: [ ^ '' ].
    comment isString ifTrue: [ ^ comment ].
    ^ comment
        at: aLevel
        ifAbsent: [
            comment at: #base ifAbsent: [ '' ] ]
]

{ #category : 'initialization' }
SRDescription >> initialize [
	super initialize.
	comment := Dictionary new.
]

{ #category : 'accessing' }
SRDescription >> label [
	^ label
]

{ #category : 'accessing' }
SRDescription >> label: aString [
	label := aString
]

{ #category : 'accessing' }
SRDescription >> level [
	^ self properties at: #level ifAbsent: [ #simple ]
]

{ #category : 'accessing' }
SRDescription >> level: aSymbol [
	self properties at: #level put: aSymbol
]

{ #category : 'accessing' }
SRDescription >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'accessing' }
SRDescription >> rawComment [
    ^ comment
]

{ #category : 'accessing' }
SRDescription >> rawComment: aDictionary [
    comment := aDictionary
]
