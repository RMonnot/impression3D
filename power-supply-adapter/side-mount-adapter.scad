// ====================================================================
// Adaptateur de fixation latéral Mean Well LRS-600 pour Ender 5 Plus
// ====================================================================
// Auteur: RMonnot
// Licence: MIT
// ====================================================================
// Cet adaptateur permet de fixer l'alimentation Mean Well LRS-600
// sur le châssis latéral de l'Ender 5 Plus
// ====================================================================

// PARAMÈTRES - Mean Well LRS-600 (mesures réelles)
espacement_meanwell_horizontal = 160;  // Espacement horizontal des trous Mean Well
espacement_meanwell_vertical = 18;     // Espacement vertical des trous Mean Well
diametre_trou_meanwell = 4.2;          // Diamètre trou M4 avec jeu

// PARAMÈTRES - Châssis Ender 5 Plus
espacement_chassis_horizontal = 150;   // Espacement horizontal châssis
espacement_chassis_vertical = 25;      // Espacement vertical châssis  
diametre_trou_chassis = 4.2;           // Diamètre trou M4 avec jeu
diametre_fraisage = 8.5;               // Diamètre pour tête de vis fraisée
profondeur_fraisage = 2.5;             // Profondeur du fraisage

profondeur_fraisage_chassis = 3.2;       // Profondeur du fraisage du chassis

// PARAMÈTRES - Plaque adaptateur
longueur_plaque = 180;                 // Longueur totale de la plaque
hauteur_plaque = 50;                   // Hauteur totale de la plaque
epaisseur_plaque = 5;                  // Épaisseur de la plaque

// Nervures de renforcement
ajouter_nervures = true;               // Ajouter des nervures
epaisseur_nervure = 3;                 // Épaisseur des nervures
hauteur_nervure = 4;                   // Hauteur des nervures

// PARAMÈTRES D'IMPRESSION
$fn = 100;                             // Résolution des cercles

// ====================================================================
// MODULES
// ====================================================================

module plaque_base() {
    cube([longueur_plaque, hauteur_plaque, epaisseur_plaque]);
}

module trous_meanwell() {
    // Centrage des trous Mean Well
    offset_x = (longueur_plaque - espacement_chassis_horizontal) / 2;
    offset_y = (hauteur_plaque - espacement_chassis_vertical) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_meanwell_horizontal,
                offset_y + j * espacement_meanwell_vertical,
                -1
            ]){
                cylinder(h = epaisseur_plaque + 2, d = diametre_trou_meanwell);
                if(i == 1 || (i==0 && j ==1)){
                    // Fraisage pour tête de vis
                    translate([0, 0, epaisseur_plaque - profondeur_fraisage + 1])
                    cylinder(h = profondeur_fraisage + 1, d = diametre_fraisage);
                }
            }
        }
    }
}

module trous_chassis() {
    // Centrage des trous châssis
    offset_x = (longueur_plaque - espacement_chassis_horizontal) / 2;
    offset_y = (hauteur_plaque - espacement_chassis_vertical) / 2;
    
    for (i = [0:1]) {
        for (j = [0:1]) {
            translate([
                offset_x + i * espacement_chassis_horizontal,
                offset_y + j * espacement_chassis_vertical,
                -1
            ]) {
                // Trou principal
                cylinder(h = epaisseur_plaque + 2, d = diametre_trou_chassis);
                
                // Fraisage pour tête de vis
                if(i == 1 || (i==0 && j ==1)){
                cylinder(h = profondeur_fraisage_chassis, d = diametre_fraisage);
                }
            }
        }
    }
}

module nervures_renforcement() {
    if (ajouter_nervures) {
        // Nervure horizontale centrale
        translate([10, (hauteur_plaque - epaisseur_nervure) / 2, 0])
        cube([longueur_plaque - 20, epaisseur_nervure, hauteur_nervure]);
        
        // Nervures verticales entre les trous
        positions_x = [
            (longueur_plaque - espacement_meanwell_horizontal) / 2 + espacement_meanwell_horizontal / 2
        ];
        
        for (x = positions_x) {
            translate([x - epaisseur_nervure/2, 10, 0])
            cube([epaisseur_nervure, hauteur_plaque - 20, hauteur_nervure]);
        }
    }
}

// ====================================================================
// ASSEMBLAGE FINAL
// ====================================================================

module adaptateur_lateral() {
    difference() {
        union() {
            plaque_base();
            nervures_renforcement();
        }
        trous_meanwell();
        trous_chassis();
    }
}

adaptateur_lateral();

// ====================================================================
// INSTRUCTIONS D'INSTALLATION
// ====================================================================
// 1. Imprimez cette pièce en PETG ou ABS (remplissage 60-80%)
// 2. Fixez l'adaptateur sur le CÔTÉ de l'alimentation Mean Well
//    avec 4 vis M4 (longueur ~8-10mm)
// 3. Fixez l'ensemble sur le châssis de l'Ender 5 Plus
//    avec 4 vis M4 (têtes fraisées si possible)
// 
// ATTENTION: Les trous sont fraisés côté châssis pour des vis
// à tête plate. Côté Mean Well, utilisez des vis normales.
// ====================================================================
