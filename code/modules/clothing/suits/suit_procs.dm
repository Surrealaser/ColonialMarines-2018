/obj/item/clothing/suit/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == WEAR_JACKET)
		check_limb_support(TRUE, user)

/obj/item/clothing/suit/dropped(mob/living/carbon/human/user)
	. = ..()
	check_limb_support(FALSE, user)

/obj/item/clothing/suit/Dispose(mob/living/carbon/human/user)
	check_limb_support(FALSE, user)
	return ..()

// Some space suits are equipped with reactive membranes that support
// broken limbs - at the time of writing, only the ninja suit, but
// I can see it being useful for other suits as we expand them. ~ Z
// The actual splinting occurs in /datum/limb/proc/fracture()
/obj/item/clothing/suit/proc/check_limb_support(equip = FALSE, mob/living/carbon/human/H = null)
	// If this isn't set, then we don't need to care.
	if(!supporting_limbs?.len)
		return

	if(!H)
		H = loc

	// If the holder isn't human, or the holder IS and is wearing the suit, it keeps supporting the limbs.
	if(!istype(H, /mob/living/carbon/human))
		return

	for(var/datum/limb/E in H.limbs)
		if(equip)
			if((E.status & LIMB_BROKEN) && !(E.status & LIMB_STABILIZED) && supporting_limbs.Find(E.body_part))
				E.status |= LIMB_STABILIZED
				to_chat(H, "<span class='notice'><b>You feel [src] constrict about your [E.display_name], stabilizing it.</b></span>")
				playsound(loc, 'sound/machines/hydraulics_1.ogg', 15, 0, 1)
		else
			if((E.status & LIMB_STABILIZED) && supporting_limbs.Find(E.body_part))
				E.status &= ~LIMB_STABILIZED
				to_chat(H, "<span class='danger'>You feel the pressure from [src] about your [E.display_name] release, leaving it unsupported.</span>")
				playsound(loc, 'sound/machines/hiss.ogg', 15, 0, 1)


/obj/item/clothing/suit/proc/secure_limb(datum/limb/E, mob/living/carbon/human/user)
	if(!supporting_limbs?.len || !user || !E)
		return

	// If the holder isn't human, or the holder IS and is wearing the suit, it keeps supporting the limbs.
	if(!istype(user, /mob/living/carbon/human))
		return

	if((E.status & LIMB_BROKEN) && !(E.status & LIMB_STABILIZED) && supporting_limbs.Find(E.body_part))
		E.status |= LIMB_STABILIZED
		playsound(loc, 'sound/machines/hydraulics_1.ogg', 15, 0, 1)
		to_chat(user, "<span class='notice'><b>You feel [src] constrict about your [E.display_name], stabilizing it.</b></span>")
