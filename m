Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16049EC55;
	Mon, 28 Sep 2026 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593870; cv=none; b=V1ZczfqLFTWMfQoW+9FcMHleNbOCQTVHpNzqnL3Hw5WUj0NHWubQrNCMwZZlampLMj6EJA8pFOQt6DFF9YcGCotKgYXKFVK6GNGZ5I2jKtMH/FyADvY50zCmhnqUXU8wiRND21/b2hSA0iVPyELOFardcKku/UNP3fDRN0z7nzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593870; c=relaxed/simple;
	bh=WwcJLZXhW1Ey4ikyjpbGr3diJl2G9UzqacYH7ysXweo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4+exd96vLRTBxY1dJkVEa0aLrj+BaPVe5smPCdHB3z9tGcNQFPA3v6sYTQLyeuzP0+v0USu1OKAsLzqqv5BlK2/lGO1fxzXu7GqDOJnDVv3njs4bv5t7Hvf6KbSukZzxaJ72mDBj7eoWq0/96u3TT7VfabSSHN5tHKt3m+9RXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WfOdWCSt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GcKPagLZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ex0MByJv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RaUAzALA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WfOdWCSt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GcKPagLZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ex0MByJv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RaUAzALA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E97E226EE;
	Mon, 28 Sep 2026 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUFvMdleO1P2p8X0u737gP/pCiqH9L18qM9IlQNh9uY=;
	b=WfOdWCStjBvfZm4aCypo3uyCDdsWQ52BEIMe6n/+ffxeLyPn+u9K/mLp+OxAUdqAXWgDCh
	d6xMeXyDO0DWhO4YBWMxA5/4MZZlL2wtJ1KSnqhNbHHOsNM3ef55KgxLHaeYPYrocvyvCU
	E4jV2rc1X8g7SWlE6qfXGIRDNKNiItA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUFvMdleO1P2p8X0u737gP/pCiqH9L18qM9IlQNh9uY=;
	b=GcKPagLZ/AdAuePx9iGySb0PGaktLQnweRBF01ZgY9vQTjmJ2Rb++dITIniUe4FCWzMCin
	NUhoUKaIhiqyQEAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790593858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUFvMdleO1P2p8X0u737gP/pCiqH9L18qM9IlQNh9uY=;
	b=Ex0MByJvbGP3bVh1kntsBLQLJPlW1URDMEyuct7sbFVz0uEyKRSm/MK5+lLKJnrd/KEYwo
	rmIpDOLI/6IvlqMpvghI9oTDpfuwdhYWw5dKSmmOjH/0Quz7yIYxf6+9wy0dHu4z7dJhZm
	6Fpu19UBdRSjgCJKvBomji2fCCxT1tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790593858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PUFvMdleO1P2p8X0u737gP/pCiqH9L18qM9IlQNh9uY=;
	b=RaUAzALAvNMox6iqMmOBj3oy93aRw6zKOm2IjAqMYKNFSZxMPlHlNQ156vxsirnmJT/25G
	LAG4lFz0fNoV+QCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9D51340F;
	Mon, 28 Sep 2026 11:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pSSeBkJLumqCKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 11:10:58 +0000
Date: Mon, 28 Sep 2026 13:10:57 +0200
Message-ID: <878q4l7hry.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: clemens@ladisch.de,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	co+24304d323d28f156@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ua101: reject mismatched capture/playback packet sizes
In-Reply-To: <20260918225753.1278505-1-xmei5@asu.edu>
References: <20260918225753.1278505-1-xmei5@asu.edu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[24304d323d28f156];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Sat, 19 Sep 2026 00:57:53 +0200,
Xiang Mei wrote:
> 
> detect_usb_format() cross-checks bSubframeSize, bBitResolution and
> tSamFreq between the capture and playback interfaces, but never relates
> the two endpoints' wMaxPacketSize and bNrChannels.  Each playback URB
> gets a buffer of ua->playback.max_packet_bytes, while the number of
> bytes written into it is derived from the capture stream:
> capture_urb_complete() computes frames from the received capture packet
> and capture.frame_bytes, and start_usb_playback() and playback_work()
> multiply that by playback.frame_bytes.
> 
> A device declaring a large capture wMaxPacketSize with few capture
> channels and a small playback wMaxPacketSize with many playback channels
> therefore memset()s and memcpy()s past the end of the playback buffer,
> in open() of the PCM node the driver registers during probe.
> usb_submit_urb() rejects the over-long iso_frame_desc[0].length with
> -EMSGSIZE, but only after the write.
> 
> Reject such descriptors at probe time.  Genuine UA-101/UA-1000 hardware
> declares proportional packet sizes and is unaffected.
> 
>   BUG: KASAN: slab-out-of-bounds in start_usb_playback (sound/usb/misc/ua101.c:586)
>   Write of size 2048 at addr ffff8881098f3c00 by task exploit/5021
>   Call Trace:
>    __asan_memset (mm/kasan/shadow.c:84)
>    start_usb_playback (sound/usb/misc/ua101.c:586)
>    playback_pcm_open (sound/usb/misc/ua101.c:679)
>    snd_pcm_open_substream (sound/core/pcm_native.c:2829)
>    snd_pcm_open (sound/core/pcm_native.c:2865 sound/core/pcm_native.c:2932)
>    snd_pcm_playback_open (sound/core/pcm_native.c:2891)
>    snd_open (sound/core/sound.c:166)
>    chrdev_open (fs/char_dev.c:411)
>    do_dentry_open (fs/open.c:996)
>    vfs_open (fs/open.c:1101)
>    path_openat (fs/namei.c:4837 fs/namei.c:5000)
>    do_file_open (fs/namei.c:5029)
>    do_sys_openat2 (fs/open.c:1417)
>    __x64_sys_openat (fs/open.c:1423 fs/open.c:1439 fs/open.c:1434)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
>   The buggy address belongs to the object at ffff8881098f3c00
>    which belongs to the cache kmalloc-192 of size 192
>   The buggy address is located 0 bytes inside of
>    allocated 168-byte region [ffff8881098f3c00, ffff8881098f3ca8)
> 
> Cc: stable@vger.kernel.org
> Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
> Reported-by: <co+24304d323d28f156@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Applied now.  Thanks.


Takashi
