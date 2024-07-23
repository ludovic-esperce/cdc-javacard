#import "@local/afpa-document:0.1.0": afpa

// Déclaration des variables
#let title = "Cahier des charges : Javacard"
#let subtitle = "Projet de développement d'application Desktop"
#let date = datetime.today()
#let author = "Ludovic Esperce"

#show: doc => afpa(
  title,
  subtitle,
  date,
  author,
  doc
)
= Introduction

L'objectif de ce projet est de développer une application "desktop" Java permettant de gérer une liste de contacts et d'exporter les informations sous différents formats.

Choix technologiques :
- l'application doit être codée en Java (version 17 ou ultérieure)
- l'interface graphique devra être construite avec JavaFX
- les vues de l'application devront être codées en FXML

Modalités de travail :
- à faire en équipe de 2
- gestion du projet inspiré par une méthode agile
- utilisation d'un dépôt Git partagé avec création de branches
- date de début du projet : 25/07/2024
- "release date" et présentation du projet : 06/07/2024

#pagebreak()

= Fonctionnalités de l'application

Vous trouverez dans cette partie du cahier des charges une liste des fonctionnalités attendues :
- interface graphique ergonomique proposant une gestion des contacts
- possiblité de sauvegarder les informations de contact pour les recharger lorsque le logiciel se lance
- possiblité d'exporter les contacts sous les différents formats *vCard* et *JSON*

Fonctionnalités optionnelles :
- générer un QRCode contenant les informations de la vCard et l'afficher à l'écran
- possibilités d'exporter les contacts sous le format *CSV*

== Gestion de contacts

L'application devra proposer une *interface graphique ergonomique* permettant de gérer une liste de contacts.

Les opérations attendues sont :
- consultations d'une liste de contacts
- création de contacts
- modification de contacts
- suppression de contact

#image("assets/crud.png")

Une contact est défini par les caractéristiques suivantes :
- *nom* (obligatoire)
- *prénom* (obligatoire)
- *genre* : homme/femme/non-binaire (obligatoire)
- *date de naissance*
- *un pseudonyme* (optionnel)
- *adresse* (obligatoire)
- *numéro de téléphone personnel* (obligatoire)
- *numéro de téléphone professionnel* (optionnel)
- *une adresse email* (obligatoire)
- *une adresse postale*  (obligatoire)
- *un lien vers la page Github ou Gitlab du contact* (optionnel)

=== Tableau des informations de contact

Un tableau listant tous les contacts gérés par l'application est à développer.
Ce tableau devra être interface et le clic sur une ligne représentant un contact aura pour impact de pré-remplir les champs du formulaire de création/modification.

=== Formulaire de création/modification de contact

Il vous faudra imaginer un formulaire de création/modification de contact *ergonomique* afin de faciliter l'utilisation.

Veillez à bien vérifier la validité des informations saisies par l'utilisateur pour les champs :
- adresse email
- lien vers la page Github ou Gitlab

Si l'utilisateur saisit des données incorrectes il faudra une *indication visuelle* explicite indiquant le champ en erreur. 

La vérification de ces informations pourra se faire en utilisant des *expressions régulières*.

Une expression régulière est une chaîne de caractères type qui correspond à un motif (ou "pattern") de caractères possibles.
Ce motif permet de trouver une *correpondance dans une autre chaîne de caractère* (c'est le "matching").

Afin de découvrire le fonctionnement des expressions régulières il vous est conseillé de suivre le tutoriel en ligne #link("https://regexlearn.com/learn/regex101")[ReagexLean] (les 30 premiers exercices vous permettront de cerner le fonctionnement).

Une fois le fonctionnement des expressions régulières compris, vous pourrez vous référer à l'article #link("https://koor.fr/Java/Tutorial/java_regular_expression.wp")[disponible ici] pour apprendre à les implémenter en Java (l'article vous donne également la solution pour la vérification des adresses email).


=== Chargement de la liste des contacts

Il devra être possible de sauvegarder la liste des utilisateurs dans un fichier binaire afin de pouvoir les recharger lors du lancement de l'application.

Pour se faire vous pouvez mettre en place un système de *sérialisation binaire* de la liste de tous les contacts.

== Sauvegarde des contacts dans des fichiers

=== Sauvegarde dans un fichier vCard

==== Qu'est-ce qu'une vCard ?

#link("https://fr.wikipedia.org/wiki/VCard")[vCard] est un format standard ouvert d'échange de données personnelles ("Visit Card").
Une vCard est un fichier de contact qu'il est possible d'utiliser afin de partager les coordonnées d'une personne.

La structuration d'un vCard en version 4 est définie dans la #link("https://datatracker.ietf.org/doc/html/rfc6350")[RFC6350] développée par l'#link("https://fr.wikipedia.org/wiki/Internet_Engineering_Task_Force")[IETF].

Vous trouverez, en ligne, de nombreux exemples de vCard.
Voici un exemple fonctionnel de vCard4 :

```vcard
BEGIN:VCARD
VERSION:4.0
N:Gump;Forrest;;Mr.;
FN:Sheri Nom
ORG:Sheri Nom Co.
TITLE:Ultimate Warrior
PHOTO;MEDIATYPE=image/gif:http://www.sherinnom.com/dir_photos/my_photo.gif
TEL;TYPE=work,voice;VALUE=uri:tel:+1-111-555-1212
TEL;TYPE=home,voice;VALUE=uri:tel:+1-404-555-1212
ADR;TYPE=WORK;PREF=1;LABEL="Normality\nBaytown\, LA 50514\nUnited States of America":;;100 Waters Edge;Baytown;LA;50514;United States of America
ADR;TYPE=HOME;LABEL="42 Plantation St.\nBaytown\, LA 30314\nUnited States of America":;;42 Plantation St.;Baytown;LA;30314;United States of America
EMAIL:sherinnom@example.com
REV:20080424T195243Z
x-qq:21588891
END:VCARD
```

Il vous faudra prévoir une fonctionnalité permettant de sauvegarder dans un fichier ayant pour extension ".vcf" les contacts gérés via votre interface graphique.

Il vous faudra mener une analyse de la structure des vCard 4 afin de comprendre construire le contenu du fichier.

==== Ecriture dans un fichier de la vCard

La première étape est d'arriver à constuire une chaîne de caractères contenant les informations de la vCard.

Il vous faudra analyser le contenue d'une vCard (par exemple celle fournie en exemple) afin d'en comprendre la structuration. La #link("https://datatracker.ietf.org/doc/html/rfc6350")[RFC6350] pourra vous aider dans cette perspective.

Voici, par exemple, le contenu de la ligne d'adresse personnelle :
```vcard
ADR;TYPE=HOME;LABEL="42 Plantation St.\nBaytown\, LA 30314\nUnited States of America":;;42 Plantation St.;Baytown;LA;30314;United States of America
```

Ci-dessous un descriptif de la partie située après les ":" suite à la chaîne de caractères définissant le "LABEL".

#image("assets/addr-vcard.svg")

Une fois que ceci est fait il faut écrire cette chaîne dans un fichier.
Pour écrire dans un fichier vous pouvez vous inspirer des solutions présentées par #link("https://www.tutorialspoint.com/java/java_write_file.htm")[cet article].

=== Sauvegarde dans un fichier JSON

==== Détails de la fonctionnalité

En plus de la sauvegarde en vCard, l'application devra permettre sauvegarder les contacts en utilisant le format JSON.

JSON est un format de données textuel sous forme de tableau associatif (stockage "clé-valeur").

Vous pourrez découvrir le format JSON à l'aide de #link("https://grafikart.fr/tutoriels/json-77")[cette vidéo de Grafikart] ou en consultant #link("https://la-cascade.io/articles/json-pour-les-debutants")[cet article].

==== Conseils d'implémentation

Votre objectif est de récupérer les informations de contact issues d'objets et de sauvegarder ses informations dans un fichier ayant pour extension ".json".

Afin d'écrire des objets dans un JSON, vous pourrez utiliser une des nombreuses bibliothèques permettant de le faire, par exemple :
- #link("https://central.sonatype.com/artifact/com.googlecode.json-simple/json-simple")[json-simple] : tutoriel disponible #link("https://mkyong.com/java/json-simple-example-read-and-write-json/")[ici]
- #link("https://central.sonatype.com/artifact/com.fasterxml.jackson.core/jackson-databind")[jackson] : tutoriel disponible #link("https://mkyong.com/java/write-json-to-a-file-with-jackson/")[ici]
- #link("https://central.sonatype.com/artifact/com.squareup.moshi/moshi")[moshi] : tutoriel disponible #link("https://mkyong.com/java/how-to-parse-json-using-moshi/#convert-java-object-to-json-string")[ici]

`json-simple` est une solution qui permet de mener à bien la tâche demandée facilement.

#pagebreak()

= Conception graphique

== Contraintes graphiques

Il vous est demandé de concenoir une application compatibles avec les tailles de fenêtre allant de *800px x 600px* à *1920px x 1080px*.

L'organisation des composants graphiques devra rester harmonieuse pour toute les tailles intermédiaires.

== Conception de "wireframe"

Pour ce projet, il ne vous est pas demandé de mener une recherche graphique poussée (le design importe peu, vous allez vous concentrer sur les fonctionnalités) mais il vous faudra faire en sorte de développer une interface la plus ergonomique possible.

Habituellement, pour construire une maquette graphique, vous devriez suivre les phases suivants :
+ *zoning* : schématisation grossière de ce sera que la vue de l'application. On y indique uniquement des rectangles qui correspondent à des blocs de composants graphiques logiquement liés.
+ *wireframe* : version plus précise du zoning sur lequel on ajoute du texte et des détails sur les composants graphiques utilisés. Attention cependant, il n'y a pas encore de notion de "design" dans cette phase
+ *maquette haute fidelité / mockup* : développement grpahique plus poussé se voulant au plus proche du design final (avec l'intégration des couleurs, des images...)

Vous trouverez des exemples de ces 3 phases dans l'article #link("https://olivier-godard.medium.com/zoning-wireframe-mockup-prototype-mais-à-quoi-ça-correspond-cd82de10338")[disponible ici].

Pour ce projet il vous est fortement conseillé de constuire une "zonin" et un "wireframe" pour 2 résolutions spécifiques :
- 800px x 600px
- 1920px x 1080px

La maquette haute fidelité importe moins dans notre cas du fait qu'il n'est pas demandé de mettre en place un style complexe.

Pour dessiner ces "zoning" et "wireframe" deux choix s'offrent à vous :
- dessiner sur une feuille
- dessiner en utilisant un outil collaboratif en ligne tel que #link("https://penpot.app/")["Penpot"]

#link("https://penpot.app/")[
  #figure(
    image("assets/penpot-logo.svg", width: 25%),
    caption: [Logo de Penpot],
  ) 
]


Attention, veillez à faire valider votre maquette par le client avant de commencer à coder.

#pagebreak()

= Proposition d'achitecture logicielle

Ci-dessous une proposition d'architecture logicielle utilisant le langage UML (hors fonctionnalités optionelles) :

// TODO intégrer le diagramme UML

= Phases de travail

== Mise en place du projet

=== Préparation du "backlog"

Cette phase permet de cibler les besoins utilisateurs et mener une *analyse fonctionnelle*.

Une fois les objectifs clairs, vous pourrez créer un "backlog" de tâches à effectuer et mettre en place un outil de gestion de projet de votre choix.

Dans le cadre de ce projet nous ferons qu'une seul "sprint" de la durée du projet.


= Pour aller plus loin

Si le temps vous le permet, vous pourrez 