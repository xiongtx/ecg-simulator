; pin 1 = Frequency change button
; pin 3 = Waveform change button
; pin 4 = LED
; b0 = waveform shape variable
; b1 = waveform frequency variable
; sine_pause = sine PAUSE variable
; sine_pause_modifier = sine PAUSE variable modIFer
; w3 = NSR PAUSE modIFier
; w4 = PVC pause modifier

; WARNING
; 	Each 16-bit variable (w's) consists of two 8-bit variables (b's) in the following fashion:
;	w_[n] = {b_[2n], b_[2n+1]}
;	
; 	Therefore, using w0 will overwrite {b0, b1}. Don't do this by mistake!

SETFREQ m4 

DACSETUP %10100000

init:
	
	; Frequency button
	SYMBOL button_freq = pinC.1
	
	; Shape button
	SYMBOL button_shape = pinC.3
	
	; LED
	SYMBOL LED = C.4
	
	SYMBOL waveform_freq = b0
	LET waveform_freq = 0
	
	SYMBOL waveform_shape = b1
	LET waveform_shape = 0
	
	SYMBOL num_freqs = b2
	LET num_freqs = 2
	
	SYMBOL num_shapes = b3
	LET num_shapes = 4
	
	SYMBOL target_state_freq = b4
	LET target_state_freq = 0
	
	SYMBOL target_state_shape = b5
	LET target_state_shape = 0
	
	SYMBOL button_freq_voltage = b6
	LET button_freq_voltage = 0
	
	SYMBOL button_shape_voltage = b7
	LET button_shape_voltage = 0
	
	SYMBOL flg_button_freq_down = b8
	LET flg_button_freq_down = 0
	
	SYMBOL flg_button_shape_down = b9
	LET flg_button_shape_down = 0
	
	SYMBOL flg_exit_square = b10
	LET flg_exit_square = 0
	
	SYMBOL sine_pause = w6
	SYMBOL sine_pause_modifier = w7
	SYMBOL nsr_pause_modifier = w8
	SYMBOL pvc_pause_modifier = w9
	
main:
	IF button_freq = 1 AND flg_button_freq_down = 0 THEN
		LET flg_button_freq_down = 1
		GOSUB change_freq
	ENDIF
	GOSUB select_freq

	IF button_shape = 1 AND flg_button_shape_down = 0 OR flg_exit_square = 1 THEN
		LET flg_button_shape_down = 1
		LET flg_exit_square = 0
		GOSUB change_shape
	ENDIF
	GOSUB select_shape
	
	GOTO main

change_freq:
	waveform_freq = waveform_freq + 1 % num_freqs
	GOTO main

change_shape:
	waveform_shape = waveform_shape + 1 % num_shapes
	GOTO main
				
select_freq:
	SELECT CASE waveform_freq
		CASE 0
			LET sine_pause_modifier = 970
			LET nsr_pause_modifier = 420
			LET pvc_pause_modifier = 430
		CASE 1
			LET sine_pause_modifier = 425
			LET nsr_pause_modifier = 20
			LET pvc_pause_modifier = 30
		ELSE
			LET waveform_freq = 0
			GOSUB select_freq
	ENDSELECT
	
	;READADC button_freq, button_freq_voltage
	IF button_freq = 0 THEN
		LET flg_button_freq_down = 0
	ENDIF
	
	RETURN

select_shape:
	SELECT CASE waveform_shape
		CASE 0
			GOSUB nsr
		CASE 1
			GOSUB pvc
		CASE 2
			GOSUB sine
		CASE 3
			GOSUB square
		ELSE
			LET waveform_shape = 0
			GOSUB select_shape
	ENDSELECT
	
	IF button_shape = 0 THEN
		LET flg_button_shape_down = 0
	ENDIF
	
	RETURN

nsr: 
	LOW LED
	
	DACLEVEL 5 
	
	PAUSE 8 
	 
	HIGH LED
	
	DACLEVEL 6 
	 PAUSE 15 
	DACLEVEL 7 
	 PAUSE 8 
	DACLEVEL 8 
	 PAUSE 16 
	DACLEVEL 9 
	 PAUSE 8 
	DACLEVEL 10 
	 PAUSE 7 
	DACLEVEL 9 
	 PAUSE 16 
	DACLEVEL 8 
	 PAUSE 8 
	DACLEVEL 7 
	 PAUSE 8 
	DACLEVEL 6 
	 PAUSE 39 
	DACLEVEL 7 
	 PAUSE 7 
	DACLEVEL 8 
	 PAUSE 8 
	DACLEVEL 16 
	 PAUSE 8 
	DACLEVEL 28 
	 PAUSE 8 
	DACLEVEL 31 
	 PAUSE 8 
	DACLEVEL 10 
	 PAUSE 8 
	DACLEVEL 0 
	 PAUSE 7 
	DACLEVEL 2 
	 PAUSE 8 
	DACLEVEL 6 
	 PAUSE 8 
	DACLEVEL 8 
	 PAUSE 8 
	DACLEVEL 7 
	 PAUSE 23 
	DACLEVEL 8 
	 PAUSE 16 
	DACLEVEL 7 
	 PAUSE 8 
	DACLEVEL 8 
	 PAUSE 78 
	DACLEVEL 9 
	 PAUSE 15 
	DACLEVEL 10 
	 PAUSE 24 
	DACLEVEL 11 
	 PAUSE 23 
	DACLEVEL 12 
	 PAUSE 16 
	DACLEVEL 13 
	 PAUSE 16 
	DACLEVEL 14 
	 PAUSE 31 
	DACLEVEL 13 
	 PAUSE 8 
	DACLEVEL 12 
	 PAUSE 7 
	DACLEVEL 11 
	 PAUSE 8 
	DACLEVEL 9 
	 PAUSE 8 
	DACLEVEL 8 
	 PAUSE 8 
	DACLEVEL 7 
	 PAUSE 8 
	DACLEVEL 6 
	 PAUSE 23 
	DACLEVEL 5
	
	PAUSE nsr_pause_modifier
	
	RETURN

pvc:

	LOW LED
	
	DACLEVEL 9 
	 PAUSE 2 
	 
	HIGH LED
	
	DACLEVEL 10 
	 PAUSE 6 
	DACLEVEL 11 
	 PAUSE 6 
	DACLEVEL 12 
	 PAUSE 2 
	DACLEVEL 13 
	 PAUSE 3 
	DACLEVEL 14 
	 PAUSE 3 
	DACLEVEL 15 
	 PAUSE 3 
	DACLEVEL 17 
	 PAUSE 5 
	DACLEVEL 18 
	 PAUSE 3 
	DACLEVEL 19 
	 PAUSE 3 
	DACLEVEL 20 
	 PAUSE 5 
	DACLEVEL 19 
	 PAUSE 3 
	DACLEVEL 18 
	 PAUSE 3 
	DACLEVEL 16 
	 PAUSE 3 
	DACLEVEL 14 
	 PAUSE 3 
	DACLEVEL 11 
	 PAUSE 2 
	DACLEVEL 7 
	 PAUSE 3 
	DACLEVEL 3 
	 PAUSE 3 
	DACLEVEL 1 
	 PAUSE 3 
	DACLEVEL 0 
	 PAUSE 2 
	DACLEVEL 1 
	 PAUSE 3 
	DACLEVEL 2 
	 PAUSE 6 
	DACLEVEL 3 
	 PAUSE 8 
	DACLEVEL 2 
	 PAUSE 6 
	DACLEVEL 1 
	 PAUSE 8 
	DACLEVEL 0 
	 PAUSE 3 
	DACLEVEL 1 
	 PAUSE 11 
	DACLEVEL 0 
	 PAUSE 8 
	DACLEVEL 1 
	 PAUSE 3 
	DACLEVEL 2 
	 PAUSE 3 
	DACLEVEL 3 
	 PAUSE 3 
	DACLEVEL 5 
	 PAUSE 3 
	DACLEVEL 7 
	 PAUSE 2 
	DACLEVEL 9 
	 PAUSE 3 
	DACLEVEL 11 
	 PAUSE 3 
	DACLEVEL 13 
	 PAUSE 3 
	DACLEVEL 14 
	 PAUSE 2 
	DACLEVEL 15 
	 PAUSE 9 
	DACLEVEL 16 
	 PAUSE 14 
	DACLEVEL 17 
	 PAUSE 5 
	DACLEVEL 16 
	 PAUSE 6 
	DACLEVEL 17 
	 PAUSE 5 
	DACLEVEL 16 
	 PAUSE 3 
	DACLEVEL 17 
	 PAUSE 11 
	DACLEVEL 16 
	 PAUSE 12 
	DACLEVEL 17 
	 PAUSE 2 
	DACLEVEL 16 
	 PAUSE 9 
	DACLEVEL 17 
	 PAUSE 19 
	DACLEVEL 18 
	 PAUSE 14 
	DACLEVEL 19 
	 PAUSE 3 
	DACLEVEL 20 
	 PAUSE 14 
	DACLEVEL 21 
	 PAUSE 3 
	DACLEVEL 22 
	 PAUSE 2 
	DACLEVEL 23 
	 PAUSE 12 
	DACLEVEL 24 
	 PAUSE 2 
	DACLEVEL 25 
	 PAUSE 3 
	DACLEVEL 26 
	 PAUSE 11 
	DACLEVEL 27 
	 PAUSE 3 
	DACLEVEL 28 
	 PAUSE 6 
	DACLEVEL 29 
	 PAUSE 8 
	DACLEVEL 30 
	 PAUSE 3 
	DACLEVEL 31 
	 PAUSE 8 
	DACLEVEL 30 
	 PAUSE 3 
	DACLEVEL 31 
	 PAUSE 8 
	DACLEVEL 30 
	 PAUSE 3 
	DACLEVEL 29 
	 PAUSE 3 
	DACLEVEL 28 
	 PAUSE 3 
	DACLEVEL 27 
	 PAUSE 5 
	DACLEVEL 25 
	 PAUSE 6 
	DACLEVEL 24 
	 PAUSE 3 
	DACLEVEL 21 
	 PAUSE 2 
	DACLEVEL 20 
	 PAUSE 6 
	DACLEVEL 19 
	 PAUSE 3 
	DACLEVEL 18 
	 PAUSE 2 
	DACLEVEL 17 
	 PAUSE 3 
	DACLEVEL 15 
	 PAUSE 6 
	DACLEVEL 14 
	 PAUSE 8 
	DACLEVEL 13 
	 PAUSE 9 
	DACLEVEL 12 
	 PAUSE 2 
	DACLEVEL 13 
	 PAUSE 3 
	DACLEVEL 12 
	 PAUSE 8 
	DACLEVEL 11 
	 PAUSE 14 
	DACLEVEL 10 
	 PAUSE 14 
	DACLEVEL 9 
	 PAUSE 9 
	DACLEVEL 8 
	 PAUSE 2 
	DACLEVEL 9 
	 PAUSE 14 
	DACLEVEL 10 
	
	PAUSE pvc_pause_modifier
	
	RETURN

sine:
	LOW LED
	
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 16 
	 PAUSE sine_pause 
	
	HIGH LED
	
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 17 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 18 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 19 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 20 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 21 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 22 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 23 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 24 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 25 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 26 
	 PAUSE sine_pause 
	LET sine_pause = 16 * sine_pause_modifier / 1000 
	 DACLEVEL 27 
	 PAUSE sine_pause 
	LET sine_pause = 18 * sine_pause_modifier / 1000 
	 DACLEVEL 28 
	 PAUSE sine_pause 
	LET sine_pause = 20 * sine_pause_modifier / 1000 
	 DACLEVEL 29 
	 PAUSE sine_pause 
	LET sine_pause = 30 * sine_pause_modifier / 1000 
	 DACLEVEL 30 
	 PAUSE sine_pause 
	LET sine_pause = 80 * sine_pause_modifier / 1000 
	 DACLEVEL 31 
	 PAUSE sine_pause 
	LET sine_pause = 30 * sine_pause_modifier / 1000 
	 DACLEVEL 30 
	 PAUSE sine_pause 
	LET sine_pause = 22 * sine_pause_modifier / 1000 
	 DACLEVEL 29 
	 PAUSE sine_pause 
	LET sine_pause = 18 * sine_pause_modifier / 1000 
	 DACLEVEL 28 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 27 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 26 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 25 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 24 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 23 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 22 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 21 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 20 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 19 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 18 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 17 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 16 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 15 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 14 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 13 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 12 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 11 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 10 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 9 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 8 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 7 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 6 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 5 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 4 
	 PAUSE sine_pause 
	LET sine_pause = 18 * sine_pause_modifier / 1000 
	 DACLEVEL 3 
	 PAUSE sine_pause 
	LET sine_pause = 22 * sine_pause_modifier / 1000 
	 DACLEVEL 2 
	 PAUSE sine_pause 
	LET sine_pause = 30 * sine_pause_modifier / 1000 
	 DACLEVEL 1 
	 PAUSE sine_pause 
	LET sine_pause = 80 * sine_pause_modifier / 1000 
	 DACLEVEL 0 
	 PAUSE sine_pause 
	LET sine_pause = 30 * sine_pause_modifier / 1000 
	 DACLEVEL 1 
	 PAUSE sine_pause 
	LET sine_pause = 20 * sine_pause_modifier / 1000 
	 DACLEVEL 2 
	 PAUSE sine_pause 
	LET sine_pause = 18 * sine_pause_modifier / 1000 
	 DACLEVEL 3 
	 PAUSE sine_pause 
	LET sine_pause = 16 * sine_pause_modifier / 1000 
	 DACLEVEL 4 
	 PAUSE sine_pause 
	LET sine_pause = 14 * sine_pause_modifier / 1000 
	 DACLEVEL 5 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 6 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 7 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 8 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 9 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 10 
	 PAUSE sine_pause 
	LET sine_pause = 12 * sine_pause_modifier / 1000 
	 DACLEVEL 11 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 12 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 13 
	 PAUSE sine_pause 
	LET sine_pause = 10 * sine_pause_modifier / 1000 
	 DACLEVEL 14 
	 PAUSE sine_pause 
	LET sine_pause = 8 * sine_pause_modifier / 1000 
	 DACLEVEL 15 
	 PAUSE sine_pause 
	
	RETURN

square:	
	DO
		IF button_shape = 0 THEN
			LET flg_button_shape_down = 0
		ENDIF
		IF button_shape = 1 AND flg_button_shape_down = 0 THEN
			LET flg_button_shape_down = 1
			LET flg_exit_square = 1
			EXIT	
		ENDIF
		
		;READADC button_freq, button_freq_voltage
		IF button_freq = 1 THEN
			LOW LED
			
			DACLEVEL 30
			PAUSE 1000
			
			HIGH LED
			
			DACLEVEL 0
			PAUSE 1000
			
			EXIT
		ENDIF
	LOOP

	RETURN