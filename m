Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17574746CF
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859641; cv=none; b=YGK/mVpfmRozn1Y+Uv9axkBst/9X0/e/K9CcwKEdqXqZhKFmJDtu7cGIphd0kkzsEGxqn386WbsKg4Ac3Nt8yRIqggj0TFOx/kA/Qnfwr9ISrkukWc1EhDuhRM896pZBpOy1osru9iayRyIv0+FLk8qBJYZypmejQP2P2m/9xeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859641; c=relaxed/simple;
	bh=0eiisYAm+1enV9BqCmdNdgBxpwLndFGB7ROkLcOTte8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbJXD9khDroe68FjA2xH2MLJvZTUcFc3fnXvH4PzdEXVBFifWu6abABuBZncC4sX4pVB42EtSTrntVuM6FJz1R81Xlose5vjs5QRDB1HN2yh9bDVIa2wyfFsghY5CEbwGc626oRcv/RQ59AnRRCLrRH6YIQVDY85XObFaWIY64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJq0BMzu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1pN654+C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1YR0EJGU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kY+LiWkh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJq0BMzu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1pN654+C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1YR0EJGU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kY+LiWkh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01CEB3DF9;
	Tue,  4 Aug 2026 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785859634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ievpcyz5UJBJ9G9fjdq/98l0EXmq1NY787SwMBSUoQY=;
	b=LJq0BMzusDMguwfjgZYRSa4p30sYCvKGCIQq40FYtCtjjYGR1suDux5aInUVc5J4SJs21o
	InT2QSl5yBDUXNYxe3d7VjX3V0fdKePIV8vIEFtACi64FioQXGaS3GTa+QyAF4ivIFAHPs
	MVsmU6jcAdBahUfi2IRqZ7RB/k3IKUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785859634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ievpcyz5UJBJ9G9fjdq/98l0EXmq1NY787SwMBSUoQY=;
	b=1pN654+C4Hor50+hyQasxuajJN5uANZpiRhugGYDRLxVaO5HnEkPQYM3ZbP8QM1CRAebEo
	VMZSbdqGqc3h85AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785859630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ievpcyz5UJBJ9G9fjdq/98l0EXmq1NY787SwMBSUoQY=;
	b=1YR0EJGUCFgwPqtA8Pcex52A9I4dJwOY1T/ousctCyqAYNCz6EZjRIaK1ER9gxr29LFb19
	HgMaZ02Z37xZWMDFTaSjYSI/xA0D8BPjUghyfOt9jD7x0G3dnTdreti8bM9850Rw+M6Huz
	yxOlzsCVDVanF5SJFa3XBYs6HpKo/Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785859630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ievpcyz5UJBJ9G9fjdq/98l0EXmq1NY787SwMBSUoQY=;
	b=kY+LiWkhRSa0H9Tw0d/ZgIIE7OFPwK8FEPGId285uXHM0RhMNfuSaqbxOFJnXsThFBoYAo
	Bef/sXA+O1T0h6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCAEB779BE;
	Tue,  4 Aug 2026 16:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rBLlLC0OcmrjKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Aug 2026 16:07:09 +0000
Date: Tue, 04 Aug 2026 18:07:09 +0200
Message-ID: <874ih9j2du.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	ramiserifpersia@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: us144mkii: re-anchor capture URBs on resubmission
In-Reply-To: <20260804123625.91769-1-baul.lee@xbow.com>
References: <20260804123625.91769-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org,xbow.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,xbow.com:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.29
X-Spam-Level: 

On Tue, 04 Aug 2026 14:36:25 +0200,
Baul Lee wrote:
> 
> capture_urb_complete() resubmits each capture URB without anchoring it:
> 
> 	usb_get_urb(urb);
> 	ret = usb_submit_urb(urb, GFP_ATOMIC);
> 
> Anchoring is a property of a submission, not of the URB.  The giveback
> path calls usb_unanchor_urb() before urb->complete(), so an URB
> resubmitted from its own completion handler is off the anchor.  The
> capture URBs are anchored once, at stream start, so from the first
> completion onward tascam->capture_anchor is empty.
> 
> tascam_free_urbs(), tascam_disconnect(), tascam_suspend() and the
> stop-work path all call usb_kill_anchored_urbs(&tascam->capture_anchor)
> to reap the capture URBs before anything is freed.  With the anchor empty
> those calls return immediately and the URBs stay queued on the host
> controller.
> 
> tascam_free_urbs() then returns the capture transfer buffers with
> usb_free_coherent(), and snd_card_free() releases the snd_card
> allocation that embeds tascam (card->private_data).  The controller
> completes the queued URBs afterwards, writing device-supplied data into
> the freed transfer buffer, and capture_urb_complete() dereferences the
> freed driver object.
> 
> KASAN on 7.2.0-rc5 (arm64):
> 
>   BUG: KASAN: slab-use-after-free in dummy_timer
>   Write of size 512 at addr ffff000015b62000
>    __asan_memcpy
>    dummy_timer
>    hrtimer_run_softirq
>   Allocated by task 64:
>    usb_alloc_coherent
>    tascam_alloc_urbs
>    tascam_probe
>   Freed by task 170:
>    usb_free_coherent
>    tascam_free_urbs
>    tascam_disconnect
>    usb_unbind_interface
> 
>   BUG: KASAN: slab-use-after-free in capture_urb_complete
>   Read of size 4 at addr ffff0000170ee878
>   Freed by task 170:
>    release_card_device
>    snd_card_free
>    tascam_disconnect
> 
> Restore the usb_anchor_urb() between the reference count bump and the
> resubmission.  That also makes the handler's usb_unanchor_urb() failure
> arm meaningful again and restores usb_kill_anchored_urbs() as a barrier
> on the disconnect, suspend and stop-work paths.
> 
> The anchoring was removed on the premise that the URB is already anchored
> from the initial submission, which does not hold once the first giveback
> has run.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 5cff1529a2f9 ("ALSA: us144mkii: capture_urb_complete: redundant usb_anchor_urb corrupts anchor list on each resubmission")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
