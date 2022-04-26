cfg = {}

cfg.attachables = {
    [`weapon_carbinerifle`] = {  -- The hashkey of the weapon itself.
        model = `w_ar_carbinerifle`, -- The hashkey of the weapon model that gets attached.
        attachBone = 24818, -- Which bone you want to attach the weapon to. See https://wiki.gtanet.work/index.php?title=Bones for a list.
        defaultLoc = "front", -- The default location the weapon attaches to. Must match a value of one of the options in the "loc" table.
        loc = {
            ["front"] = {
                pos = vector3(-0.07, 0.23, -0.001),
                rot = vector3(180.0, 145.0, -10.0),
            },
            ["back"] = {
                pos = vector3(-0.090, -0.15, 0.01),
                rot = vector3(160.0, 0.0, 0.0),
            }
        },
        components = {
            [`component_carbinerifle_clip_01`] = { -- The hashkey of the component.
                attachBone = 'WAPClip', -- Which bone of the weapon you want to attach the component to. This is found in the weapons.meta under AttachPoints > > Item > AttachBone.
                model = `w_ar_carbinerifle_mag1` -- The hashkey of the component model that gets attached.
            },
            [`component_carbinerifle_clip_02`] = {
                attachBone = 'WAPClip',
                model = `w_ar_carbinerifle_mag2`
            },
            [`component_at_scope_medium`] = {
                attachBone = 'WAPScop',
                model = `w_at_scope_medium`
            },
            [`component_at_ar_flsh`] = {
                attachBone = 'WAPFlshLasr',
                model = `w_at_ar_flsh`
            },
            [`component_at_ar_supp`] = {
                attachBone = 'WAPSupp',
                model = `w_at_ar_supp`
            },
            [`component_at_ar_afgrip`] = {
                attachBone = 'WAPGrip',
                model = `w_at_ar_afgrip`
            }
        }
    },

    [`weapon_pumpshotgun`] = {
        model = `w_sg_pumpshotgun`,
        attachBone = 24818,
        defaultLoc = "back",
        loc = {
            ["front"] = {
                pos = vector3(-0.07, 0.23, -0.001),
                rot = vector3(180.0, 145.0, -10.0),
            },
            ["back"] = {
                pos = vector3(-0.090, -0.15, 0.01),
                rot = vector3(160.0, 0.0, 0.0),
            }
        },
        components = {
            [`component_at_ar_flsh`] = {
                attachBone = 'WAPFlshLasr',
                model = `w_at_ar_flsh`
            },
            [`component_at_sr_supp`] = {
                attachBone = 'WAPSupp',
                model = `w_at_ar_supp`
            }
        }
    },

}