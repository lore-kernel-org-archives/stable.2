Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687241;
	b=JzgYHsTaioCAlDYrCktPRoHpX3GpvvoNM5ILxB1WoKidJ8aAqofUUURCAk1o1LYei54V
	 bNo3Fxdj1kKVBoM8YqbgAIlswrAGKhni5gCMYFMxWFXnqpiAnR70ejBBZwazWMUfNZ3Y3
	 tlTJaK1RfB8gKWvydEe03AdgjkBjDMjQKQZ6OL4/0P7oQTP+eeucfO8jJXqSl3nL5TDYT
	 snnCBWsA63/l7gVeZhuZVcWK5eOQnHKxpQcKBwYqlHmxeQGNwuQzYB0IoU45SyHTbj7BA
	 KRpO16FijfkUW+WjyQjHDZNkm85axT9JB2NnO/FAqOnYoiuRI7lqrKmqHh5PSe6YOIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687241;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=UFFp1oiGPIwV8RD8ciokVUvncMDM8WVuzmh4qG6CApE=;
	b=T9w4Ht768QHzxZjUPJ1IL6lOGI1Ai2CbNqHYb84bM85i5KNMkeIyDAgbky33PRwEhHrZ
	 gMa4CwpmCmTv2y6kDXslKPp9nXXE/cIagu/+ZeYID+Arj9YJAt8NagSQFVGQh2Evg3bym
	 QGN/KvgXb2zM8xmAGNJvFOh5iVU94wQT2SL22fWizu3UqUgRQ0cDMDZRfpbOItKp/Xskn
	 c/zBCI6QH/AW7iYUjpV/JCTjM79E2LTHtzytPGoGEI+IVwjfw51GUKQrY/X7Sb1sLhjh4
	 +B6gX5wVFnG8u6MDhmGlYi4ejqGY2Rsuu/4XxXro2HYHzLQuIr9b4Pt1mR4TCB+Vo3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CERyQ3DQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="2j2d3/W2";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OauXt523;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QKejRXX8;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A5606A321;
	Thu, 26 Nov 2026 10:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CERyQ3DQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2j2d3/W2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OauXt523;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QKejRXX8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD12C22608;
	Thu, 26 Nov 2026 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795687238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFFp1oiGPIwV8RD8ciokVUvncMDM8WVuzmh4qG6CApE=;
	b=CERyQ3DQ4HGhJ5DYl83HjbSu3zVSwSJQtcQwghJhQOp0bMjNCYo7WZ/4r5i+UnLpxc7OQS
	sHkJ5TUf5LcqUGlRP3hzuewZ7mNWg4Lw3gTL8sO0ayixjJijtaqTlWZ5ZQFO+/+4RyRSE6
	5waRw9IOqakAulYC1QLNY7ZParPRocY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795687238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFFp1oiGPIwV8RD8ciokVUvncMDM8WVuzmh4qG6CApE=;
	b=2j2d3/W2G1dFlCKn3Euu/DICXfb9HeSGVLzESiwW5OFEJjAsdsltJj87A5qzeEy9vlNtzr
	of6ipMb+p9NDyCDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OauXt523;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QKejRXX8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795687237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFFp1oiGPIwV8RD8ciokVUvncMDM8WVuzmh4qG6CApE=;
	b=OauXt523YqXZ4nqClv7Q9Szx8Hyz5S6b1tf/JmtzX6+KbkSUWC+ZNoIoVW7XCcUpIgLLqu
	yMW6bO76zTUo9kx34Z6zK+Cbw30Dd/CtfIt6gYgzBUc2dJa68R8J35SFvd/sOkfZiXfrl2
	jgQJdj5VL36wwv3yzmZ36US+5mbvXJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795687237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFFp1oiGPIwV8RD8ciokVUvncMDM8WVuzmh4qG6CApE=;
	b=QKejRXX8nDmiIlTvUEXnBSG9jNPyDvzO6OMU0bFZ60FCIpq8gJhtsLwyyBqXqbJ44R8CGB
	j6VoAMDB86OUsdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 814A1134C3;
	Thu, 26 Nov 2026 10:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ObgzFkUDCGv1BgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Nov 2026 10:00:37 +0000
Date: Thu, 26 Nov 2026 11:00:37 +0100
Message-ID: <87ld6f6hfe.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: security@nitrohex.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: timer: Protect the slave instance flags with the timer lock
In-Reply-To: <20261126-alsa-timer-slave-flags-v2-1-8e07a536fea3@nitrohex.com>
References: <20261126-alsa-timer-slave-flags-v2-1-8e07a536fea3@nitrohex.com>
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,nitrohex.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: CD12C22608

On Thu, 26 Nov 2026 10:18:33 +0100,
Rongen Wang via B4 Relay wrote:
> 
> From: Rongen Wang <security@nitrohex.com>
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
>    __snd_timer_user_ioctl.isra.0+0xe93/0x28f0
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

Applied now.  Thanks.


Takashi
