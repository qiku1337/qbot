;adressy zmiennych
global $clientexe_global = "WAD"
global $servername_global = "DBL"

$addr = 0x0EECB588
;0x00A093D0
$first_mana = Dec("208")
;Dec("4C8")
;AC light
;4C loc
global $mana_static = $addr
global $mana_offset[2] = [Null, $first_mana]

global $hp_static = $addr
global $hp_offset[2] = [Null, Dec("4C")]
;global $hp_offset[2] = [Null, $first_mana - Dec("38")]

global $hp_max_static = $addr
global $hp_max_offset[2] = [Null, Dec("-50")]
;global $hp_max_offset[2] = [Null, $first_mana - Dec("30")]

global $cap_static = $addr
global $cap_offset[2] = [Null, $first_mana - Dec("28")]

global $name_static = $addr
global $name_offset[2] = [Null, $first_mana- Dec("3B4")]

global $rslot_static = $addr
global $rslot_offset[2] = [Null, $first_mana]

global $light_static = $addr
Global $light_offset[2] = [Null, Dec("AC")]

global $battle_static = 0x0048C114
global $battle_offset[8] = [Null, 4, 12, 60, 116, 1032, 24, 92]

global $ifattack_static = 0x00074258
global $ifattack_offset[2] = [Null, Dec("4")]

global $iflogin_static = 0x00958C90
global $iflogin_offset[2] = [Null, Dec("0")]
