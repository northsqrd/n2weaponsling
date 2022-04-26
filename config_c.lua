cfg = {}

cfg.attachables = {
    [`weapon_carbinerifle`] = {
        model = `w_ar_carbinerifle`,
        attachBone = 24818,
        pos = vector3(-0.07, 0.23, -0.001),
        rot = vector3(180.0, 145.0, -10.0),
        components = {
            [`component_carbinerifle_clip_01`] = {
                attachBone = 'WAPClip',
                model = `w_ar_carbinerifle_mag1`
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
        pos = vector3(-0.090, -0.15, 0.01),
        rot = vector3(160.0, 0.0, 0.0),
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