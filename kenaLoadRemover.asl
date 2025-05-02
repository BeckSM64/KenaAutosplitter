state("Kena-Win64-Shipping") {
    long isLoading1: 0x05E93B90, 0x2F8;
    long isLoading2: 0x5BA7930;
}

isLoading {
    if (current.isLoading1 != 0x0 || current.isLoading2 == 0xFFFFFFFF) {
        return true;
    } else {
        return false;
    }
}
