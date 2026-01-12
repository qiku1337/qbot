;adressy zmiennych
global $clientexe_global = "otclient_gl"
global $servername_global = "Realera8.0"

$addr = 0x009E7C20
$first_mana = Dec("4A8")

global $mana_static = $addr
global $mana_offset[2] = [Null, $first_mana]

global $hp_static = $addr
global $hp_offset[2] = [Null, $first_mana - Dec("38")]

global $hp_max_static = $addr
global $hp_max_offset[2] = [Null, $first_mana - Dec("30")]

global $name_static = $addr
global $name_offset[2] = [Null, $first_mana- Dec("394")]

global $cap_static = $addr
global $cap_offset[2] = [Null, $first_mana - Dec("20")]

global $rslot_static = $addr
global $rslot_offset[2] = [Null, $first_mana]

global $light_static = $addr
Global $light_offset[2] = [Null, $first_mana - Dec("3FC")]

global $battle_static = 0x0048C114
global $battle_offset[8] = [Null, 4, 12, 60, 116, 1032, 24, 92]

global $ifattack_static = 0x00078818
global $ifattack_offset[2] = [Null, Dec("4")]

global $iflogin_static = 0x005B73C8
global $iflogin_offset[2] = [Null, Dec("C4C")]
