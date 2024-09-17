
-- Constructor 
function (self, unitId, unitFrame, envTable, scriptTable)
    
    -- Define mid and low priority units by their Unit IDs (numeric values)
    envTable.midPriorityUnits = {
        [225985] = true,  -- Example Mid-Priority Unit ID
        [23456] = true,  -- Example Mid-Priority Unit ID
    }
    
    envTable.lowPriorityUnits = {
        [225978] = true,  -- Example Low-Priority Unit ID
        [45678] = true,  -- Example Low-Priority Unit ID
    }
    
end


-- Nameplate Updated
function (self, unitId, unitFrame, envTable, modTable)
    -- Get the NPC ID directly from the nameplate
    local unitID = Plater.GetNpcIDFromGUID(unitFrame.namePlateUnitGUID)
    if not unitID then return end -- Ensure we have a valid Unit ID
    
    -- Get the scale values from the options
    local midScale = modTable.config.midPriorityScale
    local lowScale = modTable.config.lowPriorityScale
    
    -- Get options for hiding health text, cast bar text, and unit name (defaulting to false)
    local hideMidHealthText = modTable.config.hideMidHealthText
    local hideMidCastBarText = modTable.config.hideMidCastBarText
    local hideLowHealthText = modTable.config.hideLowHealthText
    local hideLowCastBarText = modTable.config.hideLowCastBarText
    local hideLowUnitName = modTable.config.hideLowUnitName 
    
    -- Mid priority scaling and conditional hiding of health text and cast bar text
    if envTable.midPriorityUnits[unitID] then
        -- Set scale for mid-priority units
        unitFrame:SetScale(midScale)
        
        -- Conditionally hide health text for mid-priority units
        if hideMidHealthText then
            unitFrame.healthBar.lifePercent:Hide() -- Hide life percentage
        end
        
        -- Conditionally hide cast bar text for mid-priority units
        if hideMidCastBarText and unitFrame.castBar then
            unitFrame.castBar.Text:Hide() -- Hide the cast bar text
            unitFrame.castBar.TargetName:Hide() -- Hide the cast target text
            Plater.HideCastBar(unitFrame) -- Hide the entire cast bar (optional)
        end
        
    -- Low priority scaling and conditional hiding of health text, cast bar text, and unit name
    elseif envTable.lowPriorityUnits[unitID] then
        -- Set scale for low-priority units
        unitFrame:SetScale(lowScale)
        
        -- Conditionally hide health text for low-priority units
        if hideLowHealthText then
            unitFrame.healthBar.lifePercent:Hide() -- Hide life percentage
        end
        
        -- Conditionally hide the unit name for low-priority units
        if hideLowUnitName then
            unitFrame.unitName:SetFont(unitFrame.unitName:GetFont(), 1) -- Set the font size to 1
            Plater.RefreshName(unitFrame) -- Force refresh to ensure the name stays hidden
        end
        
        -- Conditionally hide cast bar text for low-priority units
        if hideLowCastBarText and unitFrame.castBar then
            unitFrame.castBar.Text:Hide() -- Hide the cast bar text
            unitFrame.castBar.TargetName:Hide() -- Hide the cast target text
            Plater.HideCastBar(unitFrame) -- Hide the entire cast bar (optional)
        end
    end
end
