$reibeck_volume = 1.0
$reibeck_phase = 4.0 * 4
$reibeck_wavelength = 15.0 * 4

$gabbro_volume = 1.0
$gabbro_phase = 10.0 * 4
$gabbro_wavelength = 34.0 * 4

$feldspar_volume = 1.0
$feldspar_phase = 4.0 * 4
$feldspar_wavelength = 10.0 * 4

$solanum_volume = 1.0
$solanum_phase = 7.0 * 4
$solanum_wavelength = 14.0 * 4

$esker_volume = 1.0
$esker_phase = 6.0 * 4
$esker_wavelength = 12.0 * 4

$chert_volume = 1.0
$chert_phase = 32.0 * 4
$chert_wavelength = 64.0 * 4

define :harmonic_phase do |phase, wavelength|
  time = tick
  cycle_position = (time + phase) % wavelength
  volume = Math.cos((cycle_position / wavelength) * Math::PI * 2) * 0.5 + 0.5
  volume
end

define :update_volumes do
  $reibeck_volume = harmonic_phase($reibeck_phase, $reibeck_wavelength)
  $gabbro_volume = harmonic_phase($gabbro_phase, $gabbro_wavelength)
  $feldspar_volume = harmonic_phase($feldspar_phase, $feldspar_wavelength)
  $solanum_volume = harmonic_phase($solanum_phase, $solanum_wavelength)
  $esker_volume = harmonic_phase($esker_phase, $esker_wavelength)
  $chert_volume = harmonic_phase($chert_phase, $chert_wavelength)
end

# invariant: shortest note is double whole
define :harmonica do |n, l: 1.0, amp: 1.0|
  vol = amp
  attack = 0.1
  attack_offset = 0.04
  decay = 1.0
  release = 0.5
  sustain = l - attack - decay - release
  play_dials n, amp: vol, attack: attack, decay: decay, sustain: sustain, release: release
  play_dials n + 7 + 0.04, amp: vol * 0.5, attack: attack - attack_offset, decay: decay, sustain: sustain, release: release
  play_dials n + 12 - 0.05, amp: vol * 0.4, attack: attack - (attack_offset / 2.0), decay: decay, sustain: sustain, release: release
  sleep l
end

# invariant: shortest note is half note.
define :bass_flute do |n, l: 1.0, amp: 1.0|
  attack = 0.15
  decay = 0.15
  release = 0.1
  sustain = l - attack - decay - release
  play_dials n, amp: amp, attack: attack, decay: decay, sustain: sustain, release: release
  sleep l
end

define :normal do |n, l: 1.0, amp: 1.0|
  normal_base n, l: l, amp: amp
  sleep l
end

define :normal_base do |n, l: 1.0, amp: 1.0|
  attack = 0.2 * l
  decay = 0.2 * l
  sustain = 0.3 * l
  release = 0.3 * l
  play_dials n, amp: amp, attack: attack, decay: decay, sustain: sustain, release: release
end

define :play_dials do |n, amp: 1.0, attack: 0.1, decay: 0.1, sustain: 0.2, release: 0.3|
  iterable = n.is_a?(Array) || n.is_a?(Range) ? n : [n]
  for n in iterable do
    play n, amp: amp, attack: attack, decay: decay, sustain: sustain, release: release
  end
end

whole = 1.0
half = 0.5
quarter = 0.25
eighth = 0.125
dotted_quarter = quarter + eighth

define :theme_melody do |amp: 1.0|
  # Measure 1
  normal :C4, l: quarter, amp: amp
  normal :G4, l: quarter, amp: amp
  normal :B4, l: dotted_quarter, amp: amp
  normal :G4, l: eighth, amp: amp
  
  # Measure 2
  normal :C5, l: eighth, amp: amp
  normal :B4, l: eighth, amp: amp
  normal :A4, l: eighth, amp: amp
  normal :G4, l: eighth, amp: amp
  normal :A4, l: eighth, amp: amp
  normal :B4, l: eighth, amp: amp
  normal :G4, l: quarter, amp: amp
  
  # Measure 3
  normal :C4, l: quarter, amp: amp
  normal :G4, l: quarter, amp: amp
  normal :B4, l: dotted_quarter, amp: amp
  normal :G4, l: eighth, amp: amp
  
  # Measure 4
  normal :C5, l: eighth, amp: amp
  normal :B4, l: eighth, amp: amp
  normal :A4, l: eighth, amp: amp
  normal :G4, l: eighth, amp: amp
  normal :A4, l: eighth, amp: amp
  normal :B4, l: eighth, amp: amp
  normal :D5, l: eighth, amp: amp
  normal :B4, l: eighth, amp: amp
end

define :esker do
  use_synth :sine

  vol_modifiter = 0.8
  
  4.times do
    normal :C4, l: quarter, amp: vol_modifiter * $esker_volume
    normal :G4, l: quarter, amp: vol_modifiter * $esker_volume
    normal :B4, l: dotted_quarter, amp: vol_modifiter * $esker_volume
    normal :G4, l: eighth, amp: vol_modifiter * $esker_volume
    
    # Measure 2
    normal :C5, l: eighth, amp: vol_modifiter * $esker_volume
    normal :B4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :A4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :G4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :A4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :B4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :G4, l: quarter, amp: vol_modifiter * $esker_volume
    
    # Measure 3
    normal :C4, l: quarter, amp: vol_modifiter * $esker_volume
    normal :G4, l: quarter, amp: vol_modifiter * $esker_volume
    normal :B4, l: dotted_quarter, amp: vol_modifiter * $esker_volume
    normal :G4, l: eighth, amp: vol_modifiter * $esker_volume
    
    # Measure 4
    normal :C5, l: eighth, amp: vol_modifiter * $esker_volume
    normal :B4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :A4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :G4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :A4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :B4, l: eighth, amp: vol_modifiter * $esker_volume
    normal :D5, l: eighth, amp: vol_modifiter * $esker_volume
    normal :B4, l: eighth, amp: vol_modifiter * $esker_volume
  end
end

define :chert_congas do
  conga = :tabla_ghe4
  
  # Measure 1
  sleep eighth
  sample conga, amp: $chert_volume
  sleep eighth
  sample conga, amp: $chert_volume
  sleep quarter
  sample conga, amp: $chert_volume
  sleep quarter
  sample conga, amp: $chert_volume
  sleep eighth
  sample conga, amp: $chert_volume
  sleep eighth
  
  # Measure 2
  sleep whole
  
  # Measure 3
  sleep eighth
  sample conga, amp: $chert_volume
  sleep eighth
  sample conga, amp: $chert_volume
  sleep quarter
  sample conga, amp: $chert_volume
  sleep quarter
  sample conga, amp: $chert_volume
  sleep eighth
  sample conga, amp: $chert_volume
  sleep eighth
  
  # Measure 4
  sleep eighth
  sample conga, amp: $chert_volume
  sleep half
  sample conga, amp: $chert_volume
  sleep quarter
  sample conga, amp: $chert_volume
  sleep eighth
end

define :chert_frame do
  frame = :tabla_tas3 # :drum_tom_mid_soft
  
  # Measure 1
  sample frame, amp: $chert_volume
  sleep quarter
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sleep quarter
  
  # Measure 2
  sample frame, amp: $chert_volume
  sleep quarter
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep quarter
  sample frame, amp: $chert_volume
  sleep quarter
  
  # Measure 3
  sample frame, amp: $chert_volume
  sleep quarter
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sleep quarter
  
  # Measure 4
  sample frame, amp: $chert_volume
  sleep eighth
  sleep eighth
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sleep eighth
  sample frame, amp: $chert_volume
  sleep eighth
  sleep eighth
end

define :chert do
  4.times do
    in_thread do
      chert_congas
    end
    in_thread do
      chert_frame
    end
    sleep 4
  end
end

define :feldspar do
  use_synth :fm
  
  harmonica :D5, l: whole * 2, amp: $feldspar_volume
  harmonica :G4, l: whole * 2, amp: $feldspar_volume
  harmonica :D4, l: whole * 2, amp: $feldspar_volume
  harmonica :G3, l: whole * 2, amp: $feldspar_volume
  harmonica :C3, l: whole * 2, amp: $feldspar_volume
  harmonica :D3, l: whole * 2, amp: $feldspar_volume
  harmonica :C3, l: whole * 2, amp: $feldspar_volume
  harmonica :D3, l: whole * 2, amp: $feldspar_volume
end

define :gabbro do
  use_synth :hollow
  
  bass_flute :C4, l: whole * 2, amp: $gabbro_volume
  bass_flute :D4, l: whole * 2, amp: $gabbro_volume
  bass_flute :E4, l: whole * 2, amp: $gabbro_volume
  bass_flute :D4, l: whole, amp: $gabbro_volume
  bass_flute :G4, l: half, amp: $gabbro_volume
  bass_flute :A4, l: half, amp: $gabbro_volume
  bass_flute :C4, l: whole * 2, amp: $gabbro_volume
  bass_flute :D4, l: whole * 2, amp: $gabbro_volume
  bass_flute :E4, l: whole * 2, amp: $gabbro_volume
  bass_flute :D4, l: whole * 2, amp: $gabbro_volume
end

define :reibeck do
  use_synth :pluck
  vol_modifiter = 2.0
  
  4.times do
    normal :C4, l: quarter, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: quarter, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: dotted_quarter, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: eighth, amp: vol_modifiter * $reibeck_volume
    
    # Measure 2
    normal :C5, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :A4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :A4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: quarter, amp: vol_modifiter * $reibeck_volume
    
    # Measure 3
    normal :C4, l: quarter, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: quarter, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: dotted_quarter, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: eighth, amp: vol_modifiter * $reibeck_volume
    
    # Measure 4
    normal :C5, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :A4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :G4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :A4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :D5, l: eighth, amp: vol_modifiter * $reibeck_volume
    normal :B4, l: eighth, amp: vol_modifiter * $reibeck_volume
  end
end

define :solanum_treble do
  amp = 3.0
  
  2.times do
    # Measure 1-2
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :D4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :D4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :G4, l: quarter, amp: amp * $solanum_volume
    normal :A4, l: quarter, amp: amp * $solanum_volume
    
    # Measure 3-4
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :Fs4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :Fs4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :C5, l: quarter, amp: amp * $solanum_volume
    normal :B4, l: quarter, amp: amp * $solanum_volume
    
    # Measure 5-6
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :D4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :B3, l: dotted_quarter, amp: amp * $solanum_volume
    normal :G4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :C4, l: quarter, amp: amp * $solanum_volume
    normal :B3, l: quarter, amp: amp * $solanum_volume
    
    # Measure 7-8
    normal :A4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :B4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :A4, l: dotted_quarter, amp: amp * $solanum_volume
    normal :B4, l: dotted_quarter, amp: amp * $solanum_volume
    
    normal :A4, l: eighth, amp: amp * $solanum_volume
    normal :B4, l: eighth, amp: amp * $solanum_volume
    normal :D5, l: eighth, amp: amp * $solanum_volume
    normal :B4, l: eighth, amp: amp * $solanum_volume
  end
end

define :four_quarter do |n, amp: 1.0|
  normal n, l: quarter, amp: amp * $solanum_volume
  normal n, l: quarter, amp: amp * $solanum_volume
  normal n, l: quarter, amp: amp * $solanum_volume
  normal n, l: quarter, amp: amp * $solanum_volume
end

define :solanum_bass do
  amp = 1.5
  
  # Line 1
  four_quarter :C3, amp: amp
  four_quarter :C3, amp: amp
  four_quarter :D3, amp: amp
  four_quarter :D3, amp: amp
  four_quarter :E3, amp: amp
  
  # Line 2
  four_quarter :E3, amp: amp
  four_quarter :D3, amp: amp
  four_quarter :D3, amp: amp
  four_quarter :C3, amp: amp
  four_quarter :C3, amp: amp
  four_quarter :D3, amp: amp
  
  # Line 3
  four_quarter :D3, amp: amp
  four_quarter :E3, amp: amp
  four_quarter :E3, amp: amp
  four_quarter :D3, amp: amp
  four_quarter :D3, amp: amp
end

define :solanum do
  use_synth :piano
  in_thread do
    solanum_treble
  end
  in_thread do
    solanum_bass
  end
end

# In F#
# All notes are natural except F.

use_bpm 92 / 4

in_thread do
  loop do
    update_volumes
    sleep 0.1
  end
end
in_thread do
  loop do
    in_thread do
      esker
    end
    
    in_thread do
      chert
    end
    
    in_thread do
      feldspar
    end
    
    in_thread do
      gabbro
    end
    
    in_thread do
      reibeck
    end
    
    in_thread do
      solanum
    end
    
    sleep 16
  end
end

