// ====================================================================
// Adaptateur de fixation côté alimentation Mean Well LRS-600
// Pour Creality Ender 5 Plus
// ====================================================================
// Auteur: RMonnot
// Licence: MIT
// ====================================================================
// Cet adaptateur se fixe directement sur l'alimentation Mean Well
// et compense la différence de hauteur avec l'alimentation d'origine
// ====================================================================

// PARAMÈTRES PRINCIPAUX

// Dimensions Mean Well LRS-600-24
longueur_alimentation = 215;    // Longueur de l'alimentation
largeur_alimentation = 115;     // Largeur de l'alimentation
hauteur_alimentation = 30;      // Hauteur de l'alimentation

// Trous de fixation Mean Well
espacement_trous_x = 205;       // Espacement horizontal des trous
espacement_trous_y = 105;       // Espacement vertical des trous
diametre_trou_meanwell = 4.5;   // Diamètre des trous Mean Well (avec jeu)

// Adaptateur
hauteur_adaptateur = 20;        // Hauteur pour compenser la différence (20mm)
epaisseur_cadre = 8;            // Épaisseur du cadre autour
largeur_rebord = 15;            // Largeur du rebord de fixation

// Trous pour fixation sur le châssis
diametre_trou_chassis = 4.2;    // Diamètre trou pour vis M4 châssis
espacement_trous_chassis_x = 205; // Espacement trous châssis
espacement_trous_chassis_y = 105; // Espacement trous châssis

// Ouvertures pour ventilation
ajouter_ventilation = true;     // Ajouter des fentes de ventilation
largeur_fente = 5;              // Largeur des fentes
espacement_fentes = 10;         // Espacement entre fentes

// PARAMÈTRES D'IMPRESSION
$fn = 100;

// ====================================================================
// MODULES
// ====================================================================

module cadre_base() {
    difference() {
        // Cadre extérieur
        cube([
            longueur_alimentation + 2 * epaisseur_cadre,
            largeur_alimentation + 2 * epaisseur_cadre,
            hauteur_adaptateur
        ]);
        
        // Évidement central pour l'alimentation
        translate([epaisseur_cadre, epaisseur_cadre, -1])
        cube([
            longueur_alimentation,
            largeur_alimentation,
            hauteur_adaptateur - epaisseur_cadre + 1
        ]);
    }
}

module trous_fixation_meanwell() {
    // Trous pour fixer l'adaptateur sur l'alimentation Mean Well
    offset_x = epaisseur_cadre + (longueur_alimentation - espacement_trous_x) / 2;
    offset_y = epaisseur_cadre + (largeur_alimentation - espacement_trous_y) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_trous_x,
                offset_y + j * espacement_trous_y,
                -1
            ])
            cylinder(h = hauteur_adaptateur + 2, d = diametre_trou_meanwell);
        }
    }
}

module rebords_fixation_chassis() {
    // Rebords aux 4 coins pour fixation sur le châssis
    offset_x = epaisseur_cadre + (longueur_alimentation - espacement_trous_chassis_x) / 2;
    offset_y = epaisseur_cadre + (largeur_alimentation - espacement_trous_chassis_y) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_trous_chassis_x - largeur_rebord/2,
                offset_y + j * espacement_trous_chassis_y - largeur_rebord/2,
                hauteur_adaptateur - epaisseur_cadre
            ])
            difference() {
                cube([largeur_rebord, largeur_rebord, epaisseur_cadre]);
                
                // Trou pour vis de fixation châssis
                translate([largeur_rebord/2, largeur_rebord/2, -1])
                cylinder(h = epaisseur_cadre + 2, d = diametre_trou_chassis);
            }
        }
    }
}

module fentes_ventilation() {
    if (ajouter_ventilation) {
        // Fentes sur les côtés longs
        nombre_fentes = floor((longueur_alimentation - 40) / espacement_fentes);
        
        for (i = [0:nombre_fentes-1]) {
            // Côté avant
            translate([
                epaisseur_cadre + 20 + i * espacement_fentes,
                0,
                hauteur_adaptateur / 2
            ])
            cube([largeur_fente, epaisseur_cadre + 1, hauteur_adaptateur / 2 + 1]);
            
            // Côté arrière
            translate([
                epaisseur_cadre + 20 + i * espacement_fentes,
                largeur_alimentation + epaisseur_cadre,
                hauteur_adaptateur / 2
            ])
            cube([largeur_fente, epaisseur_cadre + 1, hauteur_adaptateur / 2 + 1]);
        }
        
        // Fentes sur les côtés courts
        nombre_fentes_court = floor((largeur_alimentation - 40) / espacement_fentes);
        
        for (i = [0:nombre_fentes_court-1]) {
            // Côté gauche
            translate([
                0,
                epaisseur_cadre + 20 + i * espacement_fentes,
                hauteur_adaptateur / 2
            ])
            cube([epaisseur_cadre + 1, largeur_fente, hauteur_adaptateur / 2 + 1]);
            
            // Côté droit
            translate([
                longueur_alimentation + epaisseur_cadre,
                epaisseur_cadre + 20 + i * espacement_fentes,
                hauteur_adaptateur / 2
            ])
            cube([epaisseur_cadre + 1, largeur_fente, hauteur_adaptateur / 2 + 1]);
        }
    }
}

// ====================================================================
// ASSEMBLAGE FINAL
// ====================================================================

module adaptateur_alimentation() {
    difference() {
        union() {
            cadre_base();
            rebords_fixation_chassis();
        }
        trous_fixation_meanwell();
        fentes_ventilation();
    }
}

adaptateur_alimentation();

// ====================================================================
// NOTES D'UTILISATION
// ====================================================================
// Cet adaptateur se fixe sur l'alimentation Mean Well LRS-600 :
// 
// 1. Fixez l'adaptateur sur l'alimentation avec 4 vis M4
// 2. L'adaptateur crée une surface de fixation surélevée de 20mm
// 3. Fixez l'ensemble sur le châssis via les rebords supérieurs
// 
// Les fentes de ventilation permettent à l'air de circuler
// pour refroidir l'alimentation
//
// IMPORTANT: Vérifiez que les vis ne sont pas trop longues
// pour ne pas endommager l'alimentation !