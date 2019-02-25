
function KillBang(text)
   SendAddonMessage("kshot_ScrollingTextEvent", text, "BATTLEGROUND")
   
   SendAddonMessage("kshot_KillSoundEvent", 20, "BATTLEGROUND");
end

function KCheck()
   kshot:CheckBGVersions()
end

function KGCheck()
   kshot:CheckGuildVersions()
end

function KWhisper(text, target)
   print("Sent mnall text: " .. text .. " to " .. target)
   SendAddonMessage("kshot_txt", text, "WHISPER", target)
end

function KLargeText(text, target)
   print("Sent large text: " .. text .. " to " .. target)
   SendAddonMessage("kshot_ScrollingTextEvent", text, "WHISPER", target)
end

function KSound(text, target)
   print("Sent sound to " .. target)
   SendAddonMessage("kshot_KillSoundEvent", text, "WHISPER", target) 
end

function KShot(name, target)
   kshot:kshot_Killshot(name, target)
end