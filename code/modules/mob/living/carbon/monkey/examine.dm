/mob/living/carbon/monkey/examine(mob/user)
	if( (user.sdisabilities & BLIND || user.blinded || user.stat) && !istype(user,/mob/dead/observer) )
		to_chat(user, "<span class='notice'>Something is there but you can't see it.</span>")
		return

	var/msg = "<span class='info'>*---------*\nThis is \icon[src] \a <EM>[src]</EM>!\n"

	if (src.handcuffed)
		msg += "It is \icon[src.handcuffed] handcuffed!\n"
	if (src.wear_mask)
		msg += "It has \icon[src.wear_mask] \a [src.wear_mask] on its head.\n"
	if (src.l_hand)
		msg += "It has \icon[src.l_hand] \a [src.l_hand] in its left hand.\n"
	if (src.r_hand)
		msg += "It has \icon[src.r_hand] \a [src.r_hand] in its right hand.\n"
	if (src.back)
		msg += "It has \icon[src.back] \a [src.back] on its back.\n"
	if (src.stat == DEAD)
		msg += "<span class='deadsay'>It is limp and unresponsive, with no signs of life.</span>\n"
	else
		msg += "<span class='warning'>"
		if (src.getBruteLoss())
			if (src.getBruteLoss() < 30)
				msg += "It has minor bruising.\n"
			else
				msg += "<B>It has severe bruising!</B>\n"
		if (src.getFireLoss())
			if (src.getFireLoss() < 30)
				msg += "It has minor burns.\n"
			else
				msg += "<B>It has severe burns!</B>\n"
		if (src.fire_stacks > 0)
			msg += "It's covered in something flammable.\n"
		if (src.fire_stacks < 0)
			msg += "It's soaked in water.\n"

		if (src.stat == UNCONSCIOUS)
			msg += "It isn't responding to anything around it; it seems to be asleep.\n"
		msg += "</span>"

	if(chestburst == 2)
		msg += "<span class='warning'><b>It has a big hole in its chest!</b></span>\n"

	if (src.digitalcamo)
		msg += "It is repulsively uncanny!\n"

	msg += "*---------*</span>"

	to_chat(user, msg)
	return