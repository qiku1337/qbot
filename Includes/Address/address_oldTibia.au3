;adressy zmiennych
global $clientexe_global = "Old Tibia Client"
global $key_global = "Old Tibia"
global $servername_global = "Old Tibia"

global $mana_static = 0x000408C0
global $mana_offset[5] = [Null, Dec("A8"), Dec("7C"), Dec("54"), Dec("740")]

global $hp_static = 0x00050A68
global $hp_offset[2] = [Null, Dec("0")]

global $name_static = 0x0048C4F8
global $name_offset[2] = [Null, Dec("FC")]

global $cap_static = 0x0048C4F8
global $cap_offset[2] = [Null, Dec("3A8")]

global $light_static = 0x0004DB00
Global $light_offset[2] = [Null, Dec("B4")]

global $rslot_static = 0x0048C4F8
global $rslot_offset[2] = [Null, Dec("2B0")]

global $battle_static = 0x0048D574
global $battle_offset[11] = [Null, Dec("4"), Dec("C"), Dec("3C"), Dec("3C"), Dec("1C"), Dec("3F0"), Dec("8"), Dec("8"), Dec("18"), Dec("3C")]

global $ifattack_static = 0x000346A4
global $ifattack_offset[2] = [Null, 0]

global $iflogin_static = 0x0024A470
global $iflogin_offset[2] = [Null, 0]

global $charxy_static = 0x0048DE4C
global $charx_offset[8] = [Null, Dec("8C"), Dec("30"), Dec("34"), Dec("4"), Dec("1C"), Dec("8"), Dec("2B0")]
global $chary_offset[8] = [Null, Dec("8C"), Dec("30"), Dec("34"), Dec("4"), Dec("1C"), Dec("8"), Dec("2B4")]

global $selectedserver_static = 0x000346A4
global $selectedserver_offset[8] = [Null, Dec("4"), Dec("0"), Dec("1C"), Dec("8"), Dec("438"), Dec("14"), Dec("180")]