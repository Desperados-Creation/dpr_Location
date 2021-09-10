Config = {
    LocationVehicule = {
        position = {
            vector3(-499.76, -672.79, 32.8)
        },

        vehicule ={
            {Nom = "Scooter", Vehicule = "faggio", Price = 300},
            {Nom = "Panto", Vehicule = "panto", Price = 500},
            {Nom = "Blista", Vehicule = "blista", Price = 750},
            {Nom = "Prairie", Vehicule = "prairie", Price = 1000},
        }
    },

    blip = true, -- Affichage du blip (true = oui, false = non)

    BlipName = 'Location', -- Nom du blip
    BlipId = 225, -- Id du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipTaille = 0.7, -- Taille du blip
    BlipCouleur = 10, -- Couleur du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipRange = true, -- Garder le blip sur la map (true = désactiver, false = activé)


    Ped = true,

    PedType = 'cs_josh',
    PedPosition = vector3(-500.75, -671.95, 32.05),
    PedRotation = 221.92,


    MarkerType = 36, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
    MarkerSizeLargeur = 1.0, -- Largeur du marker
    MarkerSizeEpaisseur = 1.0, -- Épaisseur du marker
    MarkerSizeHauteur = 1.0, -- Hauteur du marker
    MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
    MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
    MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

    Text = "Appuyer sur ~b~[E] ~s~pour louer un ~b~véhicule ~s~!"
}
