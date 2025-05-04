state("Kena-Win64-Shipping") {
    byte255 cutsceneFilenameAddress: 0x060E8848, 0x100, 0x88, 0;
    byte255 tutorialCutsceneFilenameAddress: 0x05BA3930, 0x10, 0x88, 0;
}

init {
    vars.sproutCutsceneFilename = "57-00-30-00-5F-00-52-00-6F-00-74-00-50-00-61-00-72-00-61-00-64-00-65-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32"; // W0_RotParade_PC.bk2
    vars.dashAbilityFilename = "57-00-33-00-5F-00-44-00-61-00-73-00-68-00-41-00-62-00-69-00-6C-00-69-00-74-00-79-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // W3_DashAbility_PC.bk2
    vars.toshiFilename = "57-00-33-00-5F-00-54-00-6F-00-73-00-68-00-69-00-44-00-65-00-66-00-65-00-61-00-74-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // W3_ToshiDefeat_PC.bk2
    vars.gameCompleteFilename = "57-00-33-00-5F-00-45-00-6E-00-64-00-47-00-61-00-6D-00-65-00-5F-00-50-00-43-00"; // W3_EndGame
    vars.bowTutorialFilename = "42-00-6F-00-77-00-41-00-62-00-69-00-6C-00-69-00-74-00-79-00-5F-00-54-00-75-00-74-00-6F-00-72-00-69-00-61-00-6C-00-5F-00-50-00-43-00-2E-00-62-00-6B-00-32-00"; // BowAbility_Tutorial_PC.bk2
}

split {
    // Sprout
    if (old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.sproutCutsceneFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.sproutCutsceneFilename))) {
            return true;
        }
    }

    // Dash
    if (old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.dashAbilityFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.dashAbilityFilename))) {
            return true;
        }
    }

    // Bow
    if (old.tutorialCutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.tutorialCutsceneFilenameAddress).Contains(vars.bowTutorialFilename) && (current.tutorialCutsceneFilenameAddress == null || !BitConverter.ToString(current.tutorialCutsceneFilenameAddress).Contains(vars.bowTutorialFilename))) {
            return true;
        }
    }

    // Toshi
    if (old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(old.cutsceneFilenameAddress).Contains(vars.toshiFilename) && (current.cutsceneFilenameAddress == null || !BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.toshiFilename))) {
            return true;
        }
    }

    // End Game
    if (old.cutsceneFilenameAddress != null) {
        if (BitConverter.ToString(current.cutsceneFilenameAddress).Contains(vars.gameCompleteFilename)) {
            return true;
        }
    }
}
