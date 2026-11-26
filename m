Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679992;
	b=sTI5+EWYjIG4dZNcF9rLa8mXet2RH9ouoiBz60t4uYVSYAKnocfv5/Wr3a398Cj25sCe
	 ORg/XElsgI0iBZLhVDlFw+uy/XE5ruKMNeWsZct+srCjIdWNSaPTvRxHXls0ERH0hWjdb
	 UWZVCYATcgh0pkfTSAlUypaAX4tQqnEMu/10gcRD8gxTWYv2q+I3OYEdUehdrapI0aRa1
	 3yfLD28/6b0veeeYs2uu+HcKRX+cmW6sv4ejx4SM4y9yAm3U4NNtRolhB4S9tBD7U3Kax
	 5mB5tv+Vlp3B0vhVzoZgr3jjjMxu67UiDuPyW3M0Gxi2ucQz7qPieLF6GuCgd8wf5+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679992;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=gCPt567FbipQ8XQWwv7dIOHhbEG1keVFm7aWXmFbupg=;
	b=pIuqcCsZPxyb2OBKUoUpdyvo79yh/UFAXwC0QLzQw3uip2zBWhQUMf8I3F5Dq4fqkfjc
	 A6Rk5szoRkIPHNPjaRGk+lk511h/zXALdVDrDPRl8HnVKMWb+MWqSa/wc0QAcAWgXMVLs
	 DoOV4j27maLShfNbitpXNk8dK4gf6bMH6vy7f9OQvX0fg45uXm8OMPsrvQEZbUQQE5Rz+
	 H01GIf5zcfGHirEFJaaNr9GcyUnKgmJNVGzY3r8FbSF7t5WWYiy2FzgiV6F41BeVQTbCl
	 EW8K6QZiDXCuNmg3JaAydwP2i+C3C1gRrm1qsggNLH5Y39kUwO7pXupLwI/sozttJTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MYgQ6js8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amPlUiyF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MYgQ6js8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amPlUiyF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D4606A31C;
	Thu, 26 Nov 2026 07:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MYgQ6js8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amPlUiyF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MYgQ6js8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amPlUiyF
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 662A12261F;
	Thu, 26 Nov 2026 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795679989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCPt567FbipQ8XQWwv7dIOHhbEG1keVFm7aWXmFbupg=;
	b=MYgQ6js8aXpLrX4w3gZOX3/L7t6pU3fUCT7WpwXDySv6BnAjiv0JX0m+bZmchfrCBNrpHY
	lYf4gdYrbc0UKeP5vD+4J5n+cvUguA2XOo2XQkYE+ui/nri2luoH0lzMutBKFsbZSGOCrX
	vb+kMkBGv35RCUHE/9KCCq71Wk48nk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795679989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCPt567FbipQ8XQWwv7dIOHhbEG1keVFm7aWXmFbupg=;
	b=amPlUiyFq26eSZasWvCZOLZoxf4F78BljD2e3knhZ1Co28BBr0ry9kuwULGwUtOhD/mSKr
	W0PVFDx4dEBs5dCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MYgQ6js8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=amPlUiyF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795679989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCPt567FbipQ8XQWwv7dIOHhbEG1keVFm7aWXmFbupg=;
	b=MYgQ6js8aXpLrX4w3gZOX3/L7t6pU3fUCT7WpwXDySv6BnAjiv0JX0m+bZmchfrCBNrpHY
	lYf4gdYrbc0UKeP5vD+4J5n+cvUguA2XOo2XQkYE+ui/nri2luoH0lzMutBKFsbZSGOCrX
	vb+kMkBGv35RCUHE/9KCCq71Wk48nk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795679989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCPt567FbipQ8XQWwv7dIOHhbEG1keVFm7aWXmFbupg=;
	b=amPlUiyFq26eSZasWvCZOLZoxf4F78BljD2e3knhZ1Co28BBr0ry9kuwULGwUtOhD/mSKr
	W0PVFDx4dEBs5dCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D14B813432;
	Thu, 26 Nov 2026 07:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3/GKPTmB2vsCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Nov 2026 07:59:48 +0000
Date: Thu, 26 Nov 2026 08:59:48 +0100
Message-ID: <87pkvs58gb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rongen Wang <security@nitrohex.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: timer: Protect the slave instance flags with the timer lock
In-Reply-To: <20261125192053.5664-1-security@nitrohex.com>
References: <20261125192053.5664-1-security@nitrohex.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 662A12261F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51

On Wed, 25 Nov 2026 20:21:12 +0100,
Rongen Wang wrote:
> 
> snd_timer_start_slave() and snd_timer_stop_slave() set and clear
> SNDRV_TIMER_IFLG_RUNNING in timeri->flags while holding only
> timeri_lock.  For a slave that is linked to a master, the interrupt
> path updates the same word under timer->lock:
> snd_timer_process_callbacks() sets SNDRV_TIMER_IFLG_CALLBACK before it
> calls the instance callback and clears it afterwards.  Both sides do a
> plain read-modify-write, so when they overlap one of the two updates is
> lost.
> 
> If the set of SNDRV_TIMER_IFLG_CALLBACK is lost,
> snd_timer_close_locked() does not wait for the callback that is still
> running, the owner frees the instance, and the interrupt path clears
> the flag in the freed object:
> 
>   BUG: KASAN: slab-use-after-free in snd_timer_process_callbacks+0x269/0x2b0
>   Read of size 4 at addr ffff888007e5cc10 by task poc/90
>    snd_timer_process_callbacks+0x269/0x2b0
>    snd_timer_interrupt+0x7b8/0x1100
>    snd_utimer_ioctl+0x7c/0xb0
>   Freed by task 91:
>    kfree+0x127/0x3b0
>    __snd_timer_
> user_ioctl.isra.0+0xe93/0x28f0
> 
> If the clear is lost instead, the flag stays set: the instance gets no
> further callbacks, and closing it spins in the drain loop of
> snd_timer_close_locked() with register_mutex held, which blocks every
> other open and close of an ALSA timer.
> 
> Take timer->lock around the whole flag update of a linked slave, as
> snd_timer_start1() and snd_timer_stop1() do for master instances.  The
> callers hold timeri_lock, so timeri->timer is stable, and the lock
> order is the one these functions already use.  A slave that is not
> linked to a master cannot be reached from any timer and needs no
> additional protection.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongen Wang <security@nitrohex.com>

The code change looks OK, but the patch can't be applied cleanly,
as some lines are strangely broken in the middle.

Please resubmit a clean patch, at best, verify that the posted patch
can be applied cleanly beforehand.


thanks,

Takashi
