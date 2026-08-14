Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9446D0A8;
	Fri, 14 Aug 2026 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713962; cv=none; b=V7tbvEycQhuhP/nwjeDZCLBFo6rrI5Xm/CFc5quDyd+VhSo6fcMg3ciO8kc48PZ1DQxHY79LgjxKT9pFxoA+UOofnyaiKqMgDeSMVrvvr/a28YA/k8Zf2cbHuSWhm5smvvfSrp4wEuq3fHi1pm7VmXT8xTkOFRDvK6GGpbRDuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713962; c=relaxed/simple;
	bh=ZHn07VU8hTp1sFqeobtO/jBZArGcYpskXvxC3Wwz3bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnVeoKwW52RFxY34ioGwYTdLiGErA2B2QiOoBo359hS81gTIRdyexA7w3X0gQs1JEQa0lNWdYmU/HFpofnmyLvUE4P6S4AivOEk8lAiqZerIuvxB5flWC9MXzLan2Gcu+mxR0XwMdbUbb24fmh58ajMUDpL+VOd3y3VJKtQq3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKcLTr9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKcLTr9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7BD1F000E9;
	Fri, 14 Aug 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713961;
	bh=gIhPGcP8gh4CNZ2h6rH6iczWpS2P/luWPGhin+50KWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fKcLTr9GMatJLoVk5U5TdyJ+dFGBOEOYNQGXPUFxrEfIi0XB77vqYaj8GNYIQlCDm
	 8Ax5TOERp9VyaO5jjUIiWP9pRuosd5kRUqU8U9Yb0S0lWGLFZUZLKGV+TRqRQWTQJS
	 GrgZiTvH65M2dP1MEQw1x+pSvViaBu4fKjBasHdY7zSHF67q7NPqjobealrD1KO1Hl
	 vupRcsa7DJVsqaPFPdOI6tp2UOG2tsz26rYv9mGLEQXUViE/EDqUIZPsC912EyjOtY
	 eXqe25tlTPU+tlc/UTTUhN8xRVZm8DnSOvC4K5mfBaHqbiclyGKP5lMkWEJVfF0hYN
	 4eigXWnsPTaWw==
Date: Fri, 14 Aug 2026 15:25:57 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Your Name <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: bound the slot index before touching
 mt_io_flags
Message-ID: <an8WLYvCeL7KK8Fn@beelink>
References: <20260723224211.613112-1-you@example.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723224211.613112-1-you@example.com>

On Jul 23 2026, Your Name wrote:
> From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> 
> td->mt_io_flags is a single unsigned long.  Its first MT_IO_SLOTS_BITS
> bits track per-slot state, read back through MT_IO_SLOTS_MASK, while bit
> 32 holds MT_IO_FLAGS_RUNNING, which the report path and the sticky-finger
> timer take and release with test_and_set_bit_lock() and
> clear_bit_unlock().
> 
> set_bit()/clear_bit() are called on that word with the slot number as the
> bit index:
> 
> 	set_bit(slotnum, &td->mt_io_flags);
> 
> slotnum is bounded only by td->maxcontacts, which is taken from the HID
> CONTACTMAX feature value and can reach MT_MAX_MAXCONTACT (250).  Two
> things go wrong once a device reports a slot number of 8 or more:
> 
>  - a slot number of 32 sets MT_IO_FLAGS_RUNNING from the data path.
>    mt_expired_timeout() then finds the flag already set and returns
>    early, so sticky fingers are never released, and the
>    clear_bit_unlock() in the other path drops a lock it does not hold.
>    Several in-tree classes declare .maxcontacts of 40 and 60, so this is
>    reachable with ordinary hardware.
> 
>  - a slot number of BITS_PER_LONG or more writes past the end of the word
>    altogether, corrupting the struct mt_device fields that follow it.
> 
> The same unchecked index is used in mt_release_pending_palms(), where
> slotnum comes from a for_each_set_bit() bounded by td->maxcontacts, and
> in mt_release_contacts(), where it is bounded by mt->num_slots.
> 
> Bound the index to the reserved slot range in one place and use that for
> every set_bit()/clear_bit() on mt_io_flags.  Dropping the out-of-range
> slots is not a functional change: both readers of the slot state mask
> with MT_IO_SLOTS_MASK, so bits at or above MT_IO_SLOTS_BITS were never
> observable to begin with.
> 
> Also correct the comment on the field, which claimed that eight bits were
> sufficient because at most 250 slots are supported.

FWIW, this (and your next patch which should have been tied with this
one as a series) is already fixed upstream through 0a3fe972a7cb ("HID:
core: Mitigate potential OOB by removing bogus memset()") - applied on
July 2 according to the logs.

Please always test your patches against the latest HID tree.

Cheers,
Benjamin

> 
> Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0495152091e3..463eab9f73cd 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -98,6 +98,7 @@ enum report_mode {
>  };
>  
>  #define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
> +#define MT_IO_SLOTS_BITS		8 /* bits covered by MT_IO_SLOTS_MASK */
>  #define MT_IO_FLAGS_RUNNING		32
>  
>  static const bool mtrue = true;		/* default for true */
> @@ -175,9 +176,10 @@ struct mt_device {
>  	struct hid_haptic_device *haptic;	/* haptic related configuration */
>  	struct hid_device *hdev;	/* hid_device we're attached to */
>  	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
> -					 * first 8 bits are reserved for keeping the slot
> -					 * states, this is fine because we only support up
> -					 * to 250 slots (MT_MAX_MAXCONTACT)
> +					 * the first MT_IO_SLOTS_BITS bits are reserved
> +					 * for keeping the slot states; higher slot
> +					 * numbers are not tracked here, see
> +					 * mt_io_slot_set()
>  					 */
>  	__u8 inputmode_value;	/* InputMode HID feature value */
>  	__u8 maxcontacts;
> @@ -1027,6 +1029,25 @@ static int mt_compute_slot(struct mt_dev
>  	return input_mt_get_slot_by_key(input, *slot->contactid);
>  }
>  
> +/*
> + * Only the first MT_IO_SLOTS_BITS bits of mt_io_flags track slot state; the
> + * rest of the word holds unrelated flags such as MT_IO_FLAGS_RUNNING.  Slot
> + * numbers are bounded by td->maxcontacts, which is taken from the HID
> + * CONTACTMAX feature and can be much larger, so the index has to be checked
> + * before touching the word.
> + */
> +static void mt_io_slot_set(struct mt_device *td, int slotnum)
> +{
> +	if (slotnum < MT_IO_SLOTS_BITS)
> +		set_bit(slotnum, &td->mt_io_flags);
> +}
> +
> +static void mt_io_slot_clear(struct mt_device *td, int slotnum)
> +{
> +	if (slotnum < MT_IO_SLOTS_BITS)
> +		clear_bit(slotnum, &td->mt_io_flags);
> +}
> +
>  static void mt_release_pending_palms(struct mt_device *td,
>  				     struct mt_application *app,
>  				     struct input_dev *input)
> @@ -1036,7 +1057,7 @@ static void mt_release_pending_palms(str
>  
>  	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
>  		clear_bit(slotnum, app->pending_palm_slots);
> -		clear_bit(slotnum, &td->mt_io_flags);
> +		mt_io_slot_clear(td, slotnum);
>  
>  		input_mt_slot(input, slotnum);
>  		input_mt_report_slot_inactive(input);
> @@ -1247,9 +1268,9 @@ static int mt_process_slot(struct mt_dev
>  		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
>  		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
>  
> -		set_bit(slotnum, &td->mt_io_flags);
> +		mt_io_slot_set(td, slotnum);
>  	} else {
> -		clear_bit(slotnum, &td->mt_io_flags);
> +		mt_io_slot_clear(td, slotnum);
>  	}
>  
>  	return 0;
> @@ -2062,7 +2083,7 @@ static void mt_release_contacts(struct h
>  			for (i = 0; i < mt->num_slots; i++) {
>  				input_mt_slot(input_dev, i);
>  				input_mt_report_slot_inactive(input_dev);
> -				clear_bit(i, &td->mt_io_flags);
> +				mt_io_slot_clear(td, i);
>  			}
>  			input_mt_sync_frame(input_dev);
>  			input_sync(input_dev);
> -- 
> 2.43.0
> 
> 
