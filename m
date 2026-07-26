Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068A70836
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785052192; cv=none; b=EV+XYmu5kP2QlwtRvCmYEOOv74NhooemCu6kbUZdU9gehrZx+hrp2xv3DURSRjCuK4qDm3jhZSwZpyt2iI40p/VmjwY50D0kArZobra3TVk9msX3gmCnpvpfZB/C/+KlUPG1l5xxSiLFB0hf3d2+cJX1sIAfznYyS84moLltPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785052192; c=relaxed/simple;
	bh=HHBQSuidZB+Q9lDYKT9qRX64FEz2POIzefyYO/c6gxs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV2sfwEjd0S3kxvEmgH2IlweQiB3NHXzTiKuZNEQsUXuXhOg3JqCR0d/Np7tp8oVaw50peiwnskz+RRzN9OaJBIXFJZM1/76ir6pz4A6rEvDmOFvZ2rRz0dtgpdVti1C39QLf8zvAifjAgRqe7b/RcgSCKAgapCi9bcUwfkBwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B+slsJ03; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wsbi7w4t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B+slsJ03; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wsbi7w4t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B+slsJ03";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wsbi7w4t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B+slsJ03";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wsbi7w4t"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54C0E7D49C;
	Sun, 26 Jul 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785052188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqw54Hq420QlpvBUowNyOLAp1cX0xgtatNypg/KjjKk=;
	b=B+slsJ036bHdFMWP4Q8Le2dBQS/gj13Bigz8x8dbFyFP35UBY7CmQFddvkxjuSIe9p1CiA
	2RJMhBkJFgPzZE91qGmXm3OFsLQsnnv002OtypgbUX3Xr4CkhmFoPvrxszwgE0VuEWEZmW
	ehLpII2sr98KHHzIT2/8aZ9Z+KB3d2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785052188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqw54Hq420QlpvBUowNyOLAp1cX0xgtatNypg/KjjKk=;
	b=Wsbi7w4ttCb3f9K35vJ4XZspsdRrIvbomWf7as5vb8UFu8Ro3Wdc1XvK+LEXfy1NkAvDLH
	98b5gwMjVphIqrAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785052188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqw54Hq420QlpvBUowNyOLAp1cX0xgtatNypg/KjjKk=;
	b=B+slsJ036bHdFMWP4Q8Le2dBQS/gj13Bigz8x8dbFyFP35UBY7CmQFddvkxjuSIe9p1CiA
	2RJMhBkJFgPzZE91qGmXm3OFsLQsnnv002OtypgbUX3Xr4CkhmFoPvrxszwgE0VuEWEZmW
	ehLpII2sr98KHHzIT2/8aZ9Z+KB3d2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785052188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqw54Hq420QlpvBUowNyOLAp1cX0xgtatNypg/KjjKk=;
	b=Wsbi7w4ttCb3f9K35vJ4XZspsdRrIvbomWf7as5vb8UFu8Ro3Wdc1XvK+LEXfy1NkAvDLH
	98b5gwMjVphIqrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8CC1779B9;
	Sun, 26 Jul 2026 07:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OxuVMRu8ZWpaKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 07:49:47 +0000
Date: Sun, 26 Jul 2026 09:49:47 +0200
Message-ID: <8733x6b36s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.com,
	tiwai@suse.de,
	perex@perex.cz,
	clemens@ladisch.de,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
In-Reply-To: <20260726074500.50145-1-baul.lee@xbow.com>
References: <20260726052040.41315-1-baul.lee@xbow.com>
	<20260726074500.50145-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,xbow.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sun, 26 Jul 2026 09:45:00 +0200,
Baul Lee wrote:
> 
> snd_usbmidi_akai_output() computes its fill-loop bound
> 
> 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
> 
> as a signed int, so a small device-advertised bulk-OUT max_transfer
> makes buf_end negative.  The loop guard then compares the u32
> urb->transfer_buffer_length against that negative int: the usual
> arithmetic conversion turns buf_end into a large unsigned value, so the
> guard stays true and each iteration keeps appending SysEx framing and
> payload bytes past the end of the URB transfer buffer, which is only
> max_transfer bytes long.
> 
> A USB device that advertises a tiny bulk-OUT endpoint can therefore
> trigger an attacker-length- and content-controlled heap out-of-bounds
> write when a process writes to the created /dev/snd/midiC*D* node.
> 
> Return early when there is no room for even one SysEx, so the loop is
> never entered with a bound that would wrap.  The loop is the last
> statement of the function, so bailing out is equivalent to it not
> running.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 4434ade8c933 ("ALSA: usb-audio: add support for Akai MPD16")
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v2: use an explicit "buf_end <= 0" early return instead of casting the
>     loop guard to int, as suggested by Takashi Iwai. Verified with the
>     reproducer under KASAN on v7.2-rc4: without the patch the kernel
>     reports a slab-out-of-bounds write in snd_usbmidi_akai_output(),
>     with it the same run is clean.

Applied now.  Thanks!


Takashi
