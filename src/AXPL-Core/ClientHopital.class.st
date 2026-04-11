"
""Objet métier exemple démontrant la généricité du framework.
Contient 13 variables d'instance couvrant un dossier médical complet.
descriptionForAXPL : méthode de classe qui déclare les descriptions graduelles
avec commentaires #simple/#base/#expert pour chaque champ.
Peut être remplacé par n'importe quel objet métier (Etudiant, Produit, etc.)
sans modifier une seule ligne du framework.""
"
Class {
	#name : 'ClientHopital',
	#superclass : 'Object',
	#instVars : [
		'nom',
		'prenom',
		'sexe',
		'age',
		'isUrgent',
		'dateAdmission',
		'numeroChambre',
		'telephone',
		'assurance',
		'allergies',
		'antecedents',
		'diagnostic',
		'traitement'
	],
	#category : 'AXPL-Core',
	#package : 'AXPL-Core'
}

{ #category : 'description' }
ClientHopital class >> descriptionForAXPL [
	| container |
	container := SRPriorityContainer new label: 'Dossier Médical AXPL'.
	
	"--- NIVEAU SIMPLE ---"
	container add: (SRStringDescription new 
		label: 'Nom'; 
		accessor: #nom; 
		level: #simple;
		comment: (Dictionary new 
			at: #simple put: 'Votre nom de famille officiel.';
			at: #base   put: 'Identifiant pivot pour la corrélation du dossier civil.';
			at: #expert put: 'Clé primaire d''indexation pour l''unicité du dossier patient (RGPD).';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Prénom'; 
		accessor: #prenom; 
		level: #simple;
		comment: (Dictionary new 
			at: #simple put: 'Votre prénom usuel.';
			at: #base   put: 'Attribut d''unicité pour minimiser les risques d''homonymie.';
			at: #expert put: 'Variable de désambiguïsation dans les protocoles d''identification.';
			yourself)).

	container add: (SRSelectionDescription new 
		label: 'Sexe'; 
		accessor: #sexe; 
		options: #('Masculin' 'Féminin' 'Autre');
		level: #simple;
		comment: (Dictionary new 
			at: #simple put: 'Information biologique pour votre suivi.';
			at: #base   put: 'Paramètre requis pour l''ajustement des dosages physiologiques.';
			at: #expert put: 'Indicateur métabolique pilotant les algorithmes de pharmacocinétique.';
			yourself)).

	container add: (SRBooleanDescription new 
		label: 'Urgent'; 
		accessor: #isUrgent; 
		level: #simple;
		comment: (Dictionary new 
			at: #simple put: 'Indique si vous avez besoin d''une attention immédiate.';
			at: #base   put: 'Alerte pour le personnel de garde et la gestion des flux.';
			at: #expert put: 'Variable prioritaire pilotant l''ordonnancement de la file d''attente.';
			yourself)).

	"--- NIVEAU BASE ---"
	container add: (SRNumberDescription new 
		label: 'Âge'; 
		accessor: #age; 
		level: #base;
		comment: (Dictionary new 
			at: #simple put: 'Votre âge actuel.';
			at: #base   put: 'Indicateur pour déclencher des alertes spécifiques (pédiatrie/gériatrie).';
			at: #expert put: 'Facteur de risque démographique utilisé pour l''analyse prédictive.';
			yourself)).

	container add: (SRDateDescription new 
		label: 'Date d''Admission'; 
		accessor: #dateAdmission; 
		level: #base;
		comment: (Dictionary new 
			at: #base   put: 'Jour et heure de votre arrivée à l''hôpital.';
			at: #expert put: 'Horodatage système pour le calcul de la durée moyenne de séjour (DMS).';
			yourself)).

	container add: (SRStringDescription new 
		label: 'N° Chambre'; 
		accessor: #numeroChambre; 
		level: #base;
		comment: (Dictionary new 
			at: #base   put: 'Votre lieu d''hébergement actuel.';
			at: #expert put: 'Donnée de localisation pour la traçabilité des soins de proximité.';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Téléphone'; 
		accessor: #telephone; 
		level: #base;
		comment: (Dictionary new 
			at: #base   put: 'Numéro pour vous joindre ou joindre vos proches.';
			at: #expert put: 'Canal de communication primaire pour la coordination post-hospitalière.';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Assurance'; 
		accessor: #assurance; 
		level: #base;
		comment: (Dictionary new 
			at: #base   put: 'Votre couverture santé (Mutuelle/Sécu).';
			at: #expert put: 'Vérification des droits pour la validation du circuit de facturation.';
			yourself)).

	"--- NIVEAU EXPERT ---"
	container add: (SRStringDescription new 
		label: 'Allergies'; 
		accessor: #allergies; 
		level: #expert;
		comment: (Dictionary new 
			at: #simple put: 'Substances qui vous rendent malade.';
			at: #base   put: 'Sécurité alimentaire et médicamenteuse de premier niveau.';
			at: #expert put: 'Donnée critique : Analyse des risques d''anaphylaxie (Sécurité Patient).';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Antécédents'; 
		accessor: #antecedents; 
		level: #expert;
		comment: (Dictionary new 
			at: #base   put: 'Vos anciennes maladies ou opérations.';
			at: #expert put: 'Historique clinique utilisé pour l''interprétation des symptômes actuels.';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Diagnostic'; 
		accessor: #diagnostic; 
		level: #expert;
		comment: (Dictionary new 
			at: #base   put: 'La conclusion médicale sur votre état.';
			at: #expert put: 'Interprétation clinique protégée par le secret professionnel.';
			yourself)).

	container add: (SRStringDescription new 
		label: 'Traitement'; 
		accessor: #traitement; 
		level: #expert;
		comment: (Dictionary new 
			at: #simple put: 'Les médicaments que vous devez prendre.';
			at: #base   put: 'Plan de soins pour la dispensation infirmière.';
			at: #expert put: 'Instructions pharmacologiques actives soumises à prescription.';
			yourself)).

	^ container
]

{ #category : 'accessing' }
ClientHopital >> age [

	^ age
]

{ #category : 'accessing' }
ClientHopital >> age: anObject [

	age := anObject
]

{ #category : 'accessing' }
ClientHopital >> allergies [

	^ allergies
]

{ #category : 'accessing' }
ClientHopital >> allergies: anObject [

	allergies := anObject
]

{ #category : 'accessing' }
ClientHopital >> antecedents [

	^ antecedents
]

{ #category : 'accessing' }
ClientHopital >> antecedents: anObject [

	antecedents := anObject
]

{ #category : 'accessing' }
ClientHopital >> assurance [

	^ assurance
]

{ #category : 'accessing' }
ClientHopital >> assurance: anObject [

	assurance := anObject
]

{ #category : 'accessing' }
ClientHopital >> dateAdmission [

	^ dateAdmission
]

{ #category : 'accessing' }
ClientHopital >> dateAdmission: anObject [

	dateAdmission := anObject
]

{ #category : 'accessing' }
ClientHopital >> diagnostic [

	^ diagnostic
]

{ #category : 'accessing' }
ClientHopital >> diagnostic: anObject [

	diagnostic := anObject
]

{ #category : 'initialization' }
ClientHopital >> initialize [
	super initialize.
	nom := ''.
	prenom := ''.
	isUrgent := false.
	age := 0.
	allergies := 'Aucune connue'.
	dateAdmission := Date today.
	numeroChambre := ''.
   telephone := ''.
   assurance := ''.
   antecedents := ''.
   diagnostic := ''.
   traitement := ''.
]

{ #category : 'accessing' }
ClientHopital >> isUrgent [

	^ isUrgent
]

{ #category : 'accessing' }
ClientHopital >> isUrgent: anObject [

	isUrgent := anObject
]

{ #category : 'accessing' }
ClientHopital >> nom [

	^ nom
]

{ #category : 'accessing' }
ClientHopital >> nom: anObject [

	nom := anObject
]

{ #category : 'accessing' }
ClientHopital >> numeroChambre [

	^ numeroChambre
]

{ #category : 'accessing' }
ClientHopital >> numeroChambre: anObject [

	numeroChambre := anObject
]

{ #category : 'accessing' }
ClientHopital >> prenom [

	^ prenom
]

{ #category : 'accessing' }
ClientHopital >> prenom: anObject [

	prenom := anObject
]

{ #category : 'accessing' }
ClientHopital >> sexe [

	^ sexe
]

{ #category : 'accessing' }
ClientHopital >> sexe: anObject [

	sexe := anObject
]

{ #category : 'accessing' }
ClientHopital >> telephone [

	^ telephone
]

{ #category : 'accessing' }
ClientHopital >> telephone: anObject [

	telephone := anObject
]

{ #category : 'accessing' }
ClientHopital >> traitement [

	^ traitement
]

{ #category : 'accessing' }
ClientHopital >> traitement: anObject [

	traitement := anObject
]
