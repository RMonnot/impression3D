// ====================================================================
// Plaque de montage pour adaptateur d'alimentation Mean Well LRS-600
// Creality Ender 5 Plus
// ====================================================================
// Auteur: RMonnot
// Licence: MIT
// ====================================================================

// PARAMÈTRES PRINCIPAUX - Modifiez ces valeurs selon vos besoins

// Dimensions de la plaque
longueur_plaque = 220;          // Longueur de la plaque (mm)
largeur_plaque = 120;           // Largeur de la plaque (mm)
epaisseur_plaque = 5;           // Épaisseur de la plaque (mm)

// Trous de fixation d'origine (Ender 5 Plus)
espacement_trous_origine_x = 205;  // Espacement horizontal des trous d'origine
espacement_trous_origine_y = 105;  // Espacement vertical des trous d'origine

// Trous pour Mean Well LRS-600
espacement_trous_meanwell_x = 205; // Espacement horizontal Mean Well
espacement_trous_meanwell_y = 105; // Espacement vertical Mean Well

// Trous de vis
diametre_trou_vis = 4.2;        // Diamètre du trou pour vis M4 (avec jeu)
diametre_fraisage = 8;          // Diamètre pour tête de vis fraisée

// Nervures de renforcement
ajouter_nervures = true;        // true = avec nervures, false = sans
epaisseur_nervure = 3;          // Épaisseur des nervures
hauteur_nervure = 3;            // Hauteur des nervures

// PARAMÈTRES D'IMPRESSION
$fn = 100;                      // Résolution des cercles

// ====================================================================
// MODULES
// ====================================================================

module plaque_base() {
    cube([longueur_plaque, largeur_plaque, epaisseur_plaque]);
}

module trou_vis(fraise = false) {
    cylinder(h = epaisseur_plaque + 2, d = diametre_trou_vis);
    if (fraise) {
        translate([0, 0, epaisseur_plaque - 2])
        cylinder(h = 3, d = diametre_fraisage);
    }
}

module trous_fixation_origine() {
    // Position des 4 trous de fixation d'origine
    offset_x = (longueur_plaque - espacement_trous_origine_x) / 2;
    offset_y = (largeur_plaque - espacement_trous_origine_y) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_trous_origine_x,
                offset_y + j * espacement_trous_origine_y,
                -1
            ])
            trou_vis(fraise = true);
        }
    }
}

module trous_fixation_meanwell() {
    // Position des 4 trous pour Mean Well
    offset_x = (longueur_plaque - espacement_trous_meanwell_x) / 2;
    offset_y = (largeur_plaque - espacement_trous_meanwell_y) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_trous_meanwell_x,
                offset_y + j * espacement_trous_meanwell_y,
                -1
            ])
            trou_vis(fraise = false);
        }
    }
}

module nervures() {
    if (ajouter_nervures) {
        // Nervure horizontale centrale
        translate([0, (largeur_plaque - epaisseur_nervure) / 2, epaisseur_plaque])
        cube([longueur_plaque, epaisseur_nervure, hauteur_nervure]);
        
        // Nervure verticale centrale
        translate([(longueur_plaque - epaisseur_nervure) / 2, 0, epaisseur_plaque])
        cube([epaisseur_nervure, largeur_plaque, hauteur_nervure]);
    }
}

// ====================================================================
// ASSEMBLAGE FINAL
// ====================================================================

module plaque_montage() {
    difference() {
        union() {
            plaque_base();
            nervures();
        }
        trous_fixation_origine();
        trous_fixation_meanwell();
    }
}

plaque_montage();

// ====================================================================
// NOTES D'UTILISATION
// ====================================================================
// Cette plaque permet de fixer l'alimentation Mean Well LRS-600
// sur les points de montage d'origine de l'Ender 5 Plus
// 
// Les nervures ajoutent de la rigidité à la plaque
// Vous pouvez les désactiver en mettant ajouter_nervures = false