"
""Presenter principal du framework AXPL. Orchestre toutes les relations architecturales.
Slots principaux :
  - metaContainer : source unique de vérité, initialisé une seule fois dans targetObject:
  - psiEngine : moteur Ψ, initialisé une seule fois, garde les modifications en mémoire
  - levelDropList : sélection du niveau utilisateur (⑨)
  - scrollablePresenter : zone scrollable pour les champs générés
  - psiButton : bouton Ψ visible seulement en mode Expert
  - traceButton : affiche le log horodaté [t] en mode Expert
updateInterface : méthode centrale qui orchestre ①②⑦⑧⑨⑩.
targetObject: : point d'entrée — initialise metaContainer et psiEngine puis déclenche le rendu.""
"
Class {
	#name : 'SRFormApp',
	#superclass : 'SpPresenter',
	#instVars : [
		'levelDropList',
		'generateButton',
		'formContainer',
		'statusLabel',
		'targetObject',
		'actionBar',
		'psiButton',
		'metaContainer',
		'psiEngine',
		'traceButton',
		'scrollablePresenter'
	],
	#category : 'AXPL-UI',
	#package : 'AXPL-UI'
}

{ #category : 'accessing' }
SRFormApp >> actionBar [

	^ actionBar
]

{ #category : 'accessing' }
SRFormApp >> actionBar: anObject [

	actionBar := anObject
]

{ #category : 'layout' }
SRFormApp >> defaultLayout [
    ^ SpBoxLayout newTopToBottom
        spacing: 10;
        borderWidth: 15;
        add: statusLabel expand: false;
        add: (SpBoxLayout newHorizontal
            spacing: 8;
            add: (self newLabel label: 'Niveau:') expand: false;
            add: levelDropList expand: true;
            yourself) expand: false;
        add: generateButton expand: false;
        add: (SpScrollableLayout with: scrollablePresenter) expand: true;
        add: actionBar expand: false;
        yourself
]

{ #category : 'accessing' }
SRFormApp >> formContainer [

	^ formContainer
]

{ #category : 'accessing' }
SRFormApp >> formContainer: anObject [

	formContainer := anObject
]

{ #category : 'accessing' }
SRFormApp >> generateButton [

	^ generateButton
]

{ #category : 'accessing' }
SRFormApp >> generateButton: anObject [

	generateButton := anObject
]

{ #category : 'initialization' }
SRFormApp >> generateForm [
    "À compléter avec la logique de génération du formulaire"
    statusLabel label: 'Formulaire généré'.

]

{ #category : 'initialization' }
SRFormApp >> initialize [
    super initialize.
    targetObject := nil.
]

{ #category : 'initialization' }
SRFormApp >> initializePresenters [
    statusLabel := self newLabel label: 'Prêt'.

    levelDropList := self newDropList
        items: #( #simple #base #expert );
        display: [ :item | item asString capitalized ].

    generateButton := self newButton
        label: 'Générer';
        icon: (self iconNamed: #refresh);
        action: [ self updateInterface ].

    formContainer := self newPresenter.
    formContainer layout: SpBoxLayout newVertical.

	scrollablePresenter := SpPresenter new.
scrollablePresenter layout: SpBoxLayout newVertical.

    psiButton := self newButton label: ''; yourself.
    
    traceButton := self newButton
        label: 'Trace Ψ';
        icon: (self iconNamed: #smallInfo);
        action: [ self showTrace ];
        yourself.

    actionBar := self newPresenter.
    actionBar layout: (SpBoxLayout newHorizontal
        spacing: 8;
        add: (self newButton
            label: 'Annuler';
            icon: (self iconNamed: #smallCancel);
            action: [ self inform: 'Annulé.' ];
            yourself) expand: true;
        add: psiButton expand: true;
        add: traceButton expand: true;
        add: (self newButton
            label: 'Enregistrer';
            icon: (self iconNamed: #smallSave);
            action: [ self inform: 'Enregistré !' ];
            yourself) expand: true;
        yourself).
]

{ #category : 'initialization' }
SRFormApp >> initializeWindow: aWindowPresenter [
    super initializeWindow: aWindowPresenter.
    aWindowPresenter
        title: 'Framework {A,X,Ψ,L}';
        initialExtent: 800 @ 900.
]

{ #category : 'accessing' }
SRFormApp >> levelDropList [

	^ levelDropList
]

{ #category : 'accessing' }
SRFormApp >> levelDropList: anObject [

	levelDropList := anObject
]

{ #category : 'accessing' }
SRFormApp >> metaContainer [

	^ metaContainer
]

{ #category : 'accessing' }
SRFormApp >> metaContainer: anObject [

	metaContainer := anObject
]

{ #category : 'accessing' }
SRFormApp >> psiButton [

	^ psiButton
]

{ #category : 'accessing' }
SRFormApp >> psiButton: anObject [

	psiButton := anObject
]

{ #category : 'accessing' }
SRFormApp >> psiEngine [

	^ psiEngine
]

{ #category : 'accessing' }
SRFormApp >> psiEngine: anObject [

	psiEngine := anObject
]

{ #category : 'accessing' }
SRFormApp >> showTrace [
    | log text |
    log := psiEngine traceLog.
    log isEmpty
        ifTrue: [ self inform: 'Aucune intercession enregistrée.' ]
        ifFalse: [
            text := log inject: '' into: [ :acc :each |
                acc , each key printString , ' — ' , each value , String cr ].
            self inform: text ]
]

{ #category : 'accessing' }
SRFormApp >> statusLabel [

	^ statusLabel
]

{ #category : 'accessing' }
SRFormApp >> statusLabel: anObject [

	statusLabel := anObject
]

{ #category : 'accessing' }
SRFormApp >> targetObject [
	^ targetObject
]

{ #category : 'accessing' }
SRFormApp >> targetObject1: anObject [

	targetObject := anObject
]

{ #category : 'accessing' }
SRFormApp >> targetObject: anObject [
    targetObject := anObject.
    "UNE SEULE FOIS — jamais recréé"
    metaContainer := anObject class descriptionForAXPL.
    psiEngine := AXPLReflexivityEngine new
        metaContainer: metaContainer;
        yourself.
    (levelDropList notNil and: [ psiButton notNil ])
        ifTrue: [ self updateInterface ].
]

{ #category : 'accessing' }
SRFormApp >> traceButton [

	^ traceButton
]

{ #category : 'accessing' }
SRFormApp >> traceButton: anObject [

	traceButton := anObject
]

{ #category : 'updating' }
SRFormApp >> updateInterface [
	| builder visibleDescs hidden visitor newLayout |
	targetObject ifNil: [ ^ self ].

	"① — Filtrage adaptatif"
	builder := AXPLFormBuilder new
		targetObject: targetObject;
		userLevel: levelDropList selectedItem;
		metaContainer: metaContainer;
		yourself.
	visibleDescs := builder build.

	"⑧ — Statut"
	statusLabel label: levelDropList selectedItem asString capitalized
		, ' Formulaire pour ' , targetObject class name.

	"Ψ et Trace visibles seulement en expert"
	levelDropList selectedItem = #expert
		ifTrue: [
			traceButton visible: true.
			psiButton
				label: 'Ψ — Intercession';
				enabled: true;
				action: [
					| index ancienLabel nouveauLabel currentLabels |
					currentLabels := metaContainer children collect: [ :d | d label ].
					index := UIManager default
						chooseFrom: currentLabels
						title: 'Ψ — Choisir le champ à modifier'.
					(index notNil and: [ index > 0 ]) ifTrue: [
						ancienLabel := currentLabels at: index.
						nouveauLabel := UIManager default
							request: 'Nouveau label pour "' , ancienLabel , '" :'
							initialAnswer: ancienLabel.
						(nouveauLabel notNil and: [ nouveauLabel notEmpty ])
							ifTrue: [
								"④ Intercession"
								psiEngine relabelDescription: ancienLabel
								          to: nouveauLabel.
								"⑤ Synchronisation"
								psiEngine updateExplanation: nouveauLabel
								          forLevel: #expert
								          with: 'Modifié par Ψ le '
								               , DateAndTime now printString.
								"⑥ → ⑦ → ⑧"
								self updateInterface ] ] ] ]
		ifFalse: [
			traceButton visible: false.
			psiButton
				label: '';
				enabled: false;
				action: [] ].

	"⑦ — Génération widgets"
	visitor := AXPLSpecVisitor new
		targetObject: targetObject;
		presenter: self.
	newLayout := visitor visit: visibleDescs.

	"② — Champs cachés"
	hidden := metaContainer children
		reject: [ :d | builder canUserSee: d ].
	hidden do: [ :d |
		| expl |
		expl := d commentFor: levelDropList selectedItem.
		newLayout add: (self newButton
			icon: (self iconNamed: #help);
			label: d label;
			action: [ self inform: (expl ifNil: [ 'Accès restreint.' ]) ])
			expand: false ].

	scrollablePresenter layout: newLayout.
]
