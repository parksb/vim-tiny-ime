import Carbon

//
// Print IME Name
//
if let source = TISCopyCurrentKeyboardLayoutInputSource()?.takeUnretainedValue() {
  if let ref = TISGetInputSourceProperty(source, kTISPropertyLocalizedName) {
    let name = Unmanaged<CFString>.fromOpaque(ref).takeUnretainedValue() as String
    print(name)
  }
}
