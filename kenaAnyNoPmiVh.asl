state("Kena-Win64-Shipping") {
    long startGameFromSave: 0x5BA7AB4;
    byte255 cutsceneFilenameAddress: 0x060E8848, 0x100, 0x88, 0;
    byte255 tutorialCutsceneFilenameAddress: 0x05BA3930, 0x10, 0x88, 0;
    byte relicCounter: 0x060D4AC0, 0x30, 0x620, 0xC0;
}

init {
    // Filename variables
    vars.sproutCutsceneFilename = "57-00-30-00-5F-00-52-00-6F-00-74-00-50-00-61-00-72-00-61-00-64-00-65-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32"; // W0_RotParade_PC.bk2
    vars.dashAbilityFilename = "57-00-33-00-5F-00-44-00-61-00-73-00-68-00-41-00-62-00-69-00-6C-00-69-00-74-00-79-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // W3_DashAbility_PC.bk2
    vars.toshiFilename = "57-00-33-00-5F-00-54-00-6F-00-73-00-68-00-69-00-44-00-65-00-66-00-65-00-61-00-74-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // W3_ToshiDefeat_PC.bk2
    vars.gameCompleteFilename = "57-00-33-00-5F-00-45-00-6E-00-64-00-47-00-61-00-6D-00-65-00-5F-00-50-00-43-00"; // W3_EndGame
    vars.bowTutorialFilename = "42-00-6F-00-77-00-41-00-62-00-69-00-6C-00-69-00-74-00-79-00-5F-00-54-00-75-00-74-00-6F-00-72-00-69-00-61-00-6C-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // BowAbility_Tutorial_PC.bk2

    // Split flags
    vars.didSproutSplit = false;
    vars.didDashSplit = false;
    vars.didMaskMakerSplit = false;
    vars.didWarriorSplit = false;
    vars.didHunterSplit = false;
    vars.didToshiSplit = false;
}

start {

    // Start from save to skip cutscene
    if (current.startGameFromSave == 0x900000018) {
        return true;
    }
}

onReset {
    // Reset split flags
    vars.didSproutSplit = false;
    vars.didDashSplit = false;
    vars.didMaskMakerSplit = false;
    vars.didWarriorSplit = false;
    vars.didBowSplit = false;
    vars.didHunterSplit = false;
    vars.didToshiSplit = false;
}

split {
    // Sprout
    if (!vars.didSproutSplit && old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.sproutCutsceneFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.sproutCutsceneFilename))) {
            vars.didSproutSplit = true;
            return true;
        }
    }

    // Dash
    if (!vars.didDashSplit && vars.didSproutSplit && old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.dashAbilityFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.dashAbilityFilename))) {
            vars.didDashSplit = true;
            return true;
        }
    }

    // Mask Maker
    if (!vars.didMaskMakerSplit && current.relicCounter != null && current.relicCounter == 0x32) {
        vars.didMaskMakerSplit = true;
        return true;
    }

    // Warrior
    if (!vars.didWarriorSplit && current.relicCounter != null && current.relicCounter == 0x33) {
        vars.didWarriorSplit = true;
        return true;
    }

    // Bow
    if (old.tutorialCutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.tutorialCutsceneFilenameAddress).Contains(vars.bowTutorialFilename) && (current.tutorialCutsceneFilenameAddress == null || !BitConverter.ToString(current.tutorialCutsceneFilenameAddress).Contains(vars.bowTutorialFilename))) {
            vars.didBowSplit = true;
            return true;
        }
    }

    // Hunter
    if (!vars.didHunterSplit && current.relicCounter != null && current.relicCounter == 0x35) {
        vars.didHunterSplit = true;
        return true;
    }

    // Toshi
    if (!vars.didToshiSplit && old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.toshiFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.toshiFilename))) {
            vars.didToshiSplit = true;
            return true;
        }
    }

    // End Game
    if (old.cutsceneFilenameAddress != null && current.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.gameCompleteFilename)) {
            return true;
        }
    }
}
