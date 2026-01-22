// ====================================================================
// Entretoise verticale Mean Well LRS-600 pour Ender 5 Plus
// ====================================================================
// Auteur: RMonnot
// Licence: MIT
// ====================================================================
// Cette entretoise corrige l'espacement vertical entre l'alimentation
// Mean Well (18mm) et le châssis Ender 5 Plus (25mm)
// ====================================================================

// PARAMÈTRES PRINCIPAUX
espacement_meanwell = 18;          // Espacement vertical Mean Well
espacement_chassis = 25;           // Espacement vertical châssis
difference_espacement = espacement_chassis - espacement_meanwell; // 7mm

// Dimensions de l'entretoise
longueur_entretoise = 40;          // Longueur de l'entretoise
largeur_entretoise = 15;           // Largeur de l'entretoise
epaisseur_entretoise = 5;          // Épaisseur de l'entretoise
hauteur_totale = espacement_chassis + 7; // Hauteur totale avec marges

// Trous
diametre_trou = 4.2;               // Diamètre trou M4 avec jeu
diametre_trou_partage = 4.5;       // Trou 3 (partagé) légèrement plus large

// Nervures
ajouter_nervures = true;
epaisseur_nervure = 3;
hauteur_nervure = 3;

// PARAMÈTRES D'IMPRESSION
$fn = 100;

// ====================================================================
// MODULES
// ====================================================================

module corps_entretoise() {
    cube([longueur_entretoise, largeur_entretoise, hauteur_totale]);
}

module trous_fixation() {
    // Centrage horizontal des trous
    offset_x = longueur_entretoise / 2;
    offset_y = largeur_entretoise / 2;
    
    // Trou 1 (Haut) - CHÂSSIS uniquement
    translate([offset_x, offset_y, -1])
    cylinder(h = epaisseur_entretoise + 2, d = diametre_trou);
    
    // Trou 2 (Milieu) - ALIMENTATION uniquement
    translate([offset_x, offset_y, difference_espacement - 1])
    cylinder(h = epaisseur_entretoise + 2, d = diametre_trou);
    
    // Trou 3 (Bas) - CHÂSSIS + ALIMENTATION (partagé)
    translate([offset_x, offset_y, espacement_chassis - 1])
    cylinder(h = epaisseur_entretoise + 2, d = diametre_trou_partage);
}

module nervures() {
    if (ajouter_nervures) {
        // Nervure verticale centrale
        translate([(longueur_entretoise - epaisseur_nervure) / 2, 0, 0])
        cube([epaisseur_nervure, largeur_entretoise, hauteur_totale]);
        
        // Nervure horizontale centrale
        translate([0, (largeur_entretoise - epaisseur_nervure) / 2, 0])
        cube([longueur_entretoise, epaisseur_nervure, hauteur_totale]);
    }
}

// ====================================================================
// ASSEMBLAGE FINAL
// ====================================================================

module entretoise_verticale() {
    difference() {
        union() {
            corps_entretoise();
            nervures();
        }
        trous_fixation();
    }
}

entretoise_verticale();

// ====================================================================
// NOTES D'INSTALLATION
// ====================================================================
// Imprimez 2 entretoises (gauche + droite)
// 
// Installation:
// 1. Trou 3 (bas): Vis M4 x 20mm traverse entretoise + alimentation
// 2. Trou 2 (milieu): Vis M4 x 10mm dans alimentation seule
// 3. Trou 1 (haut): Vis M4 x 10mm dans châssis seul
//
// Espacement résultant:
// - Mean Well: Trou 2 → Trou 3 = 18mm ✓
// - Châssis: Trou 1 → Trou 3 = 25mm ✓
// ====================================================================