Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E2374A14
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049147; cv=none; b=u58Uyp2KHcQy27f5ElrgDOfZ/r9XCGF74TZNr1NQPlMxvLxpUdXV2LZv7yj0HY09+RodNZEEmK9gJ/FF4lpw0QKRlq2m+m19v9zaqMz528506K8mtX/kLRm0gtSy3ZDxkMXWAiqL1UBWCTwB+xI1hjU/ctFlcYFvT0UsYb0M6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049147; c=relaxed/simple;
	bh=pvIxTi4nBps2yCKCTqTz1v+NCpvllJvajWMrWul87yg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQg5M5B+MdLa1g9CfKnZMmLQ0utSIo8o8cVFe9e0fA4DKajHD47ELjBBiuVDmvSfvQO8m8Jr6h4mk9tV5pbWe02Iy68KUfMkEYAkaer3ssPao9c0/qwT2MNTTJc8kfT5oTt08h7ezqSFZNTmGWk+5sszFf9BwpcKfXbbGXhKQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vo591qVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+TwmfLKW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vo591qVt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+TwmfLKW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vo591qVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+TwmfLKW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vo591qVt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+TwmfLKW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 785724372;
	Sun, 26 Jul 2026 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ColZjKgYCSc0rIyaCsI5Mg3E8IZXlR4q/WVPwnxCNs=;
	b=vo591qVtulAa2CUsQXoG2lNC0xuutP8RFxTZPvoexwPo6xu0XKJf4LHZTkOGjBhRSXcLWy
	fySmTgmNvKzdsDs59ceGZFcqpqmKPu8oM9mbmTdgxP56E47dr0YiGu6M3mEKUNSEsh5oHD
	4scr3O9G8Zg71GHI0fk7lqJcuCDnx/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ColZjKgYCSc0rIyaCsI5Mg3E8IZXlR4q/WVPwnxCNs=;
	b=+TwmfLKWsJb165ISc+94BCnCwawY0PcD187Bpbgd4dgYyg4zI/4VjD49UmND4uSEBg1yUR
	Qdv6Uz0JoQd86NAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ColZjKgYCSc0rIyaCsI5Mg3E8IZXlR4q/WVPwnxCNs=;
	b=vo591qVtulAa2CUsQXoG2lNC0xuutP8RFxTZPvoexwPo6xu0XKJf4LHZTkOGjBhRSXcLWy
	fySmTgmNvKzdsDs59ceGZFcqpqmKPu8oM9mbmTdgxP56E47dr0YiGu6M3mEKUNSEsh5oHD
	4scr3O9G8Zg71GHI0fk7lqJcuCDnx/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ColZjKgYCSc0rIyaCsI5Mg3E8IZXlR4q/WVPwnxCNs=;
	b=+TwmfLKWsJb165ISc+94BCnCwawY0PcD187Bpbgd4dgYyg4zI/4VjD49UmND4uSEBg1yUR
	Qdv6Uz0JoQd86NAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47C36779B9;
	Sun, 26 Jul 2026 06:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGGKDzawZWosewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 06:59:02 +0000
Date: Sun, 26 Jul 2026 08:59:01 +0200
Message-ID: <87cxwab5je.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix use-after-free in ump_to_endpoint()
In-Reply-To: <20260726051337.41124-1-baul.lee@xbow.com>
References: <20260726051337.41124-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,xbow.com:email]

On Sun, 26 Jul 2026 07:13:37 +0200,
Baul Lee wrote:
> 
> create_midi2_ump() registers a card-owned snd_ump_endpoint and stores a
> back-pointer to its per-interface snd_usb_midi2_ump object in
> ump->private_data, but it never installs an ump->private_free hook and
> never clears that pointer.
> 
> If a later step of snd_usb_midi_v2_create() fails, its error path calls
> free_all_midi2_umps(), which kfree()s the snd_usb_midi2_ump object while
> the already-registered endpoint keeps pointing at it.  The created
> /dev/snd/umpC*D* node stays exposed, so the first operation of any UMP
> open, ump_to_endpoint(), dereferences the dangling ump->private_data and
> reads rmidi->eps[dir] out of freed memory.
> 
> A malicious USB MIDI 2.0 device that makes creation fail after the
> endpoint is registered can thus trigger a slab use-after-free read on a
> subsequent open of the UMP node.
> 
> Clear the endpoint's back-pointer before freeing the object, and let
> ump_to_endpoint() tolerate a NULL private_data so the open/close/trigger
> callbacks fail cleanly (their callers already handle a NULL endpoint)
> instead of dereferencing a stale pointer.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
