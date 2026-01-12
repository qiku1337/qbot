;adressy zmiennych
global $clientexe_global = "javaw.exe"
global $key_global = "QiktorMirage"
global $servername_global = "Mirage"

global $mana_static = 0x00942AC0
global $mana_offset[2] = [Null, Dec("4A0")-Dec("58")]

global $hp_static = 0x00942AC0
global $hp_offset[2] = [Null, Dec("468")-Dec("58")]

global $hp_max_static = 0x00942AC0
global $hp_max_offset[2] = [Null, Dec("470")-Dec("58")]

global $name_static = 0x00942AC0
global $name_offset[2] = [Null, Dec("104")+Dec("8")]

global $cap_static = 0x00942AC0
global $cap_offset[2] = [Null, Dec("478")-Dec("58")]

global $rslot_static = 0x00942AC0
global $rslot_offset[2] = [Null, Dec("380")-Dec("58")]

global $light_static = 0
Global $light_offset[2] = [Null, 164]

global $battle_static = 0x00804064
global $battle_offset[11] = [Null, Dec("6C"), Dec("4"), Dec("28"), Dec("C"), Dec("14"), Dec("3F0"), Dec("8"), Dec("8"), Dec("18"), Dec("54")]

global $ifattack_static = 0x000346C4
global $ifattack_offset[2] = [Null, 0]

global $iflogin_static = 0x00073030
global $iflogin_offset[2] = [Null, 0]
