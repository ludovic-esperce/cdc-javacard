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

L'objectif de ce projet est de développer une application "desktop" Java permettant de gérer une liste d'utilisateur et d'exporter des VCard.

Choix technologiques :
- l'application deva être codée en Java (version 17 ou ultérieure)
- l'interface graphique devra être construite avec JavaFX
- les vues de l'application devront être en FXML

= Fonctionnalités attendues

Vous trouverez dans cette partie du cahier des charges une liste des fonctionnalités attendues.

== Gestion de contacts

L'application devra proposer une *interface graphique* ergonomique permettant de gérer une liste de personnes.

Les opérations attendues sont :
- consultations d'une liste de contacts
- création de contacts
- modification de contacts
- suppression de contact

#image("assets/crud.png")

Une contact est défini par les caractéristiques suivantes :
- *nom* (obligatoire)
- *prénom* (obligatoire)
- *adresse* (obligatoire)
- *numéro de téléphone* (obligatoire)
- *une adresse email* (obligatoire)
- *une adresse postale*  (obligatoire)
- *un pseudonyme* (optionnel)

=== Chargement de la liste des contacts

Il devra être possible de sauvegarder la liste des utilisateurs dans un fichier binaire afin de pouvoir les recharger lors du lancement de l'application.

Pour se faire vous pouvez mettre en place un système de *sérialisation binaire* de toute la liste des contacts

== Sauvegarde des contacts dans des fichiers

=== Sauvegarde dans un fichier vCard

#link("https://fr.wikipedia.org/wiki/VCard")[vCard] est un format standard ouvert d'échange de données personnelles ("Visit Card" ).
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
PHOTO;MEDIATYPE#image/gif:http://www.sherinnom.com/dir_photos/my_photo.gif
TEL;TYPE#work,voice;VALUE#uri:tel:+1-111-555-1212
TEL;TYPE#home,voice;VALUE#uri:tel:+1-404-555-1212
ADR;TYPE#WORK;PREF#1;LABEL#"Normality\nBaytown\, LA 50514\nUnited States of America":;;100 Waters Edge;Baytown;LA;50514;United States of America
ADR;TYPE#HOME;LABEL#"42 Plantation St.\nBaytown\, LA 30314\nUnited States of America":;;42 Plantation St.;Baytown;LA;30314;United States of America
EMAIL:sherinnom@example.com
REV:20080424T195243Z
x-qq:21588891
END:VCARD
```

Il vous faudra prévoir une fonctionnalité permettant de sauvegarder dans un fichier ayant pour extension ".vcf" les contacts gérés via votre interface graphique.

=== Sauvegarde dans un fichier JSON

==== Détails de la fonctionnalité

En plus de la sauvegarde en vCard, l'application devra permettre sauvegarder les contacts en utilisant le format JSON.

JSON est un format de données textuel se rapprochant d'un tableau associatif.

Vous pourrez découvrir le format JSON à l'aide de #link("https://grafikart.fr/tutoriels/json-77")[cette vidéo de Grafikart] ou en consultant #link("https://la-cascade.io/articles/json-pour-les-debutants")[cet article].

==== Conseils d'implémentation

Votre objectif est de récupérer les informations de contact issues d'objets et de sauvegarder ses informations dans un fichier ayant pour extension ".json".

Afin d'écrire des objets dans un JSON, vous pourrez utiliser une des nombreuses bibliothèques permettant de le faire, par exemple :
- #link("https://central.sonatype.com/artifact/com.googlecode.json-simple/json-simple")[json-simple] : tutoriel disponible #link("https://mkyong.com/java/json-simple-example-read-and-write-json/")[ici]
- #link("https://central.sonatype.com/artifact/com.fasterxml.jackson.core/jackson-databind")[jackson] : tutoriel disponible #link("https://mkyong.com/java/write-json-to-a-file-with-jackson/")[ici]
- #link("https://central.sonatype.com/artifact/com.squareup.moshi/moshi")[moshi] : tutoriel disponible #link("https://mkyong.com/java/how-to-parse-json-using-moshi/#convert-java-object-to-json-string")[ici]

Comme son nom l'indique, "json-simple" permettant de mener à bien la tâche demandée facilement.
