state("Kena-Win64-Shipping") {
    long isLoading: 0x05E93B90, 0x2F8;
}

isLoading {
    if (current.isLoading == 0xFFFFFFFF) {
        return true;
    } else {
        return false;
    }
}
