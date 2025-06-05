local DEFAULT_FRAGMENTS_COUNT = 1
local MAX_FRAGMENTS_COUNT = {
    ["Base.Bullets38"] = 1,
    ["Base.Bullets9mm"] = 1,
    ["Base.Bullets45"] = 2,
    ["Base.Bullets44"] = 3,
    ["Base.223Bullets"] = 3,
    ["Base.556Bullets"] = 3,
    ["Base.308Bullets"] = 3,
    ["Base.ShotgunShells"] = 3
}

local function getFragmentCount(weapon)
    local ammoType = weapon:getAmmoType()
    local maxFragmentsCount = MAX_FRAGMENTS_COUNT[ammoType] or DEFAULT_FRAGMENTS_COUNT

    return ZombRand(maxFragmentsCount) + 1
end

local function onHitZombie(zombie, wielder, bodyPartType, weapon)
    if wielder:isDoHandToHandAttack() then
        return
    end

    if not weapon:isRanged() then
        return
    end

    local fragmentCount = getFragmentCount(weapon)

    for i = 1, fragmentCount do
        local fragmentItem = instanceItem("Base.Bullet_Fragments")
        zombie:addItemToSpawnAtDeath(fragmentItem)
    end
end

Events.OnHitZombie.Add(onHitZombie)
