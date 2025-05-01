state("Kena-Win64-Shipping") {
    long isLoading: 0x05E93B90, 0x2F8;
    long gainControlOfKena: 0x5BA7AB4; // 7FF6 568A 7AB4
    string35 sproutString: 0x060E8848, 0xD0, 0x130, 0x20B5; // Looking for BP_00_02_ToshiAppear_Checkpoint_End
    string35 dashString: 0x060E8848, 0xD0, 0x130, 0x20AD; // Looking for BP_HiddenCheckpoint_PostDashAbility
    // string35 maskMakerString: 0x060E8848, 0xD0, 0x130, 0x2148; // Looking for W03.Relic.Mask
    byte255 maskMakerByteArray: 0x060E8848, 0xD0, 0x130, 0x2000; // Looking for W03.Relic.Mask
    string255 maskMakerString2: 0x060E8848, 0xD0, 0x130, 0x2000; // Looking for W03.Relic.Mask
    string35 warriorString: 0x060E8848, 0xD0, 0x130, 0x21EF; // Looking for BP_HiddenCheckpoint6_2
    // string35 gorgeString: 0x060E8848, 0xD0, 0x130, 0x20A1; // Looking for BP_WarpShrine_W1_Ascent
    string35 gorgeString: 0x060E8848, 0xD0, 0x130, 0x2196; // Looking for BP_WarpShrine_W1_Ascent
    string35 startingString: 0x060E8848, 0xD0, 0x130, 0x20B3; // Looking for BP_StartingCheckpoint
}

init {
    vars.didGameStart = false;
    vars.didSplitSprout = false;
    vars.didSplitDash = false;
    vars.didSplitMaskMaker = false;
    vars.didSplitWarrior = false;
    vars.didSplitTarosTree = false;

    // Used to see if the game started yet
    vars.preGameLoad = 0x0600000012;
    vars.postGameLoad = 0x0900000018;
}

start {

    // Start timer
    if (!vars.didGameStart) {
        // if (current.gainControlOfKena == vars.postGameLoad) {
        //     vars.didGameStart = true;
        //     return true;
        // }
        if (current.startingString != null) {
            if (current.startingString.ToString() == "BP_StartingCheckpoint") {
                vars.didGameStart = true;
                return true;
            }
        }
    }
    return false;
}

onReset {
    vars.didGameStart = false;
    vars.didSplitSprout = false;
    vars.didSplitDash = false;
    vars.didSplitMaskMaker = false;
    vars.didSplitWarrior = false;
    vars.didSplitTarosTree = false;
}

update {
    if (current.startingString != null) {
        print(current.startingString.ToString());
    }
}

isLoading {
    if (current.isLoading == 0xFFFFFFFF) {
        return true;
    } else {
        return false;
    }
}

split {

    // Sprout
    if (!vars.didSplitSprout && current.sproutString == "BP_00_02_ToshiAppear_Checkpoint_End") {
        vars.didSplitSprout = true;
        return true;
    }

    // Dash
    if (!vars.didSplitDash && current.dashString == "BP_HiddenCheckpoint_PostDashAbility") {
        vars.didSplitDash = true;
        return true;
    }

    // Mask Maker
    // if (!vars.didSplitMaskMaker && current.maskMakerString == "W03.Relic.Mask") {
    //     vars.didSplitMaskMaker = true;
    //     return true;
    // }
    // 5730332E52656C69632E4D61736B

    // Mask Maker
    if (!vars.didSplitMaskMaker && current.maskMakerByteArray != null) {
        if (BitConverter.ToString(current.maskMakerByteArray).Contains("57-30-33-2E-52-65-6C-69-63-2E-4D-61-73-6B")) {
            vars.didSplitMaskMaker = true;
            return true;
        }
    }

    // Warrior
    if (!vars.didSplitWarrior && current.warriorString == "BP_HiddenCheckpoint6_2") {
        vars.didSplitWarrior = true;
        return true;
    }

    // Taro's Tree
    if (!vars.didSplitTarosTree && current.gorgeString == "BP_WarpShrine_W1_Ascent") {
        vars.didSplitTarosTree = true;
        return true;
    }
}

