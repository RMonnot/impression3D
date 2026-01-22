// ====================================================================
// Entretoise pour adaptateur d'alimentation Mean Well LRS-600
// Creality Ender 5 Plus
// ====================================================================
// Auteur: RMonnot
// Licence: MIT
// ====================================================================

// PARAMÈTRES PRINCIPAUX - Modifiez ces valeurs selon vos besoins
hauteur_entretoise = 20;        // Hauteur de l'entretoise (mm)
diametre_trou_vis = 4.2;        // Diamètre du trou pour vis M4 (avec jeu)
diametre_exterieur = 18;        // Diamètre extérieur de l'entretoise
diametre_base = 20;             // Diamètre de la base élargie
hauteur_base = 2;               // Hauteur de la base élargie

// PARAMÈTRES D'IMPRESSION
$fn = 100;                      // Résolution des cercles (plus = plus lisse)

// ====================================================================
// MODULE PRINCIPAL
// ====================================================================

module entretoise() {
    difference() {
        union() {
            // Base élargie pour meilleure stabilité
            cylinder(h = hauteur_base, d = diametre_base);
            
            // Corps principal de l'entretoise
            translate([0, 0, hauteur_base])
            cylinder(h = hauteur_entretoise - hauteur_base, d = diametre_exterieur);
        }
        
        // Trou traversant pour la vis M4
        translate([0, 0, -0.5])
        cylinder(h = hauteur_entretoise + 1, d = diametre_trou_vis);
    }
}

// ====================================================================
// GÉNÉRATION DE L'OBJET
// ====================================================================

entretoise();

// ====================================================================
// NOTES D'UTILISATION
// ====================================================================
// Pour imprimer 4 entretoises, dupliquez ce fichier 4 fois dans votre slicer
// ou modifiez le code ci-dessous pour générer les 4 entretoises ensemble

// Option: Générer 4 entretoises espacées (décommenter pour activer)
/*
spacing = 25;
for (i = [0:1]) {
    for (j = [0:1]) {
        translate([i * spacing, j * spacing, 0])
        entretoise();
    }
}
*/
