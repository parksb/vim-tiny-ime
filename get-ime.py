#!/usr/bin/python
import objc
import Foundation

#
# Load carbon framework
#
carbon = {}

bundle = Foundation.NSBundle.bundleWithIdentifier_('com.apple.HIToolbox')
objc.loadBundleFunctions(bundle, carbon, [
    ('TISCopyCurrentKeyboardLayoutInputSource', '@@'),
    ('TISGetInputSourceProperty', '@@@'),
])
objc.loadBundleVariables(bundle, carbon, [
    ('kTISPropertyLocalizedName', '@'),
])

#
# Print IME Name
#
source = carbon['TISCopyCurrentKeyboardLayoutInputSource']()
if source != None:
    name = carbon['TISGetInputSourceProperty'](source, carbon['kTISPropertyLocalizedName'])
    print name
