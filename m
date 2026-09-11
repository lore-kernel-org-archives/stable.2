Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B83C0A09;
	Fri, 11 Sep 2026 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108816; cv=none; b=oaaGfe2d784+pccT+bHpw6iOLlWPTuB4CseDVcWGyGdnRbvYqLOq0A4ZL4gF4NV1TG4Txjcy3GQx1lIe2gsqsTef94WGlQF5Afp6QZVNkgEhFAEzzj3XURN0mhIC1CiiDf6CvXYbg4RUy/RabWCLvnCsvP/xT16Hx4hpNhXbFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108816; c=relaxed/simple;
	bh=tRWM5y+0dE/VOBSDc6x3WrT0coqsiXUSJs+1Xi709rs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igupeSddiTNBnEAT8hyHNOUawz1ep318Gk2CbZFP64wFLYs01vaYBHDXELPuSr9oYB3fIBvZBwYH9dZKe6wLiHruzpvq5pzvXaubwB4T+Sb/MZ+QazfTcylaPLL7NBOLPjKpx55iv2hWTGIB/0NnMitea4WCAeGFGRV99Gksmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yEnm0Izw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pe4xkyEn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDh9/Zxo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JY6ODkla; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yEnm0Izw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pe4xkyEn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDh9/Zxo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JY6ODkla"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A721F21C9B;
	Fri, 11 Sep 2026 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789108799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgYhEQ+dw/AKfJ1+Lnb6jlz6dYJ/Sd4FXNe2B48mzHw=;
	b=yEnm0IzwykOAqspQTlAIYH/di5DzOozQrGcU3m8p6zvqf/GHjYDelFgnMupmpxBvQPPz5U
	itquCL0Q6/8Syl8W+GvCzNMbgLMbZY954yS/nMMkG3KqIv9Pt3xOH2pjTlw8wutdXIz8M4
	SxnhePE4/N1Nu71RNd/vfDAwuq9JFZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789108799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgYhEQ+dw/AKfJ1+Lnb6jlz6dYJ/Sd4FXNe2B48mzHw=;
	b=pe4xkyEnXdJOJgzUsj9R8vyDG+HJ+HJpM/yI2KNcix85bXbSkkX67UkSXe4MjmE1H0Jy0M
	LWR9Q6b0qGHIt4AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mDh9/Zxo";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JY6ODkla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789108795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgYhEQ+dw/AKfJ1+Lnb6jlz6dYJ/Sd4FXNe2B48mzHw=;
	b=mDh9/ZxoRDGQCwMM6GvZSJa27CrDo+RorPDoO60jfjhuSVOUnOZokdzpWz+o7RKnpFxyW1
	BBzroQYkf/CENSwL/xSUqmqlyxXPmPibjTlhunX6KR6w3zrdoO512croQkbezekr4kpQ6r
	mvIDi/3jOPKV4goDysgpII84i5WXg+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789108795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgYhEQ+dw/AKfJ1+Lnb6jlz6dYJ/Sd4FXNe2B48mzHw=;
	b=JY6ODklamngMsyq17oIjNUDtKaJWwooaLFTeTD4fxHtMkBHmrWPBmNBvLjGbgmfvgBivqS
	px8k4Ay9pHqjKZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36CD8132D3;
	Fri, 11 Sep 2026 06:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b7TDCzuio2ofGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Sep 2026 06:39:55 +0000
Date: Fri, 11 Sep 2026 08:39:54 +0200
Message-ID: <87ld98jnph.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: Fix race between concurrent START and hw_params/hw_free
In-Reply-To: <20260911051605.3448607-1-ljp1205831794@gmail.com>
References: <20260911051605.3448607-1-ljp1205831794@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A721F21C9B
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,tencent.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Fri, 11 Sep 2026 07:15:59 +0200,
Aohan Mei wrote:
> 
> From: Aohan Mei <henrymei@tencent.com>
> 
> snd_pcm_hw_params() and snd_pcm_hw_free() validate the stream state
> only once, under the stream lock at entry, and then free/realloc the
> DMA buffer (snd_pcm_lib_free_pages() -> snd_pcm_set_runtime_buffer(NULL),
> followed by the sleeping allocation in snd_pcm_lib_malloc_pages()) and
> update the runtime fields without holding the stream lock.  The state,
> however, stays SNDRV_PCM_STATE_PREPARED until the final
> snd_pcm_set_state() at the very end of the operation.
> 
> A concurrent SNDRV_PCM_IOCTL_START takes only the stream lock and
> merely requires state == PREPARED in snd_pcm_pre_start(), so it can
> slip into that window: snd_pcm_post_start() sets the state RUNNING,
> arms the driver data plane and fills the initial silence through
> snd_pcm_playback_silence().  The data plane then keeps operating on
> the buffer that hw_params/hw_free is tearing down concurrently; once
> snd_pcm_set_runtime_buffer(NULL) has cleared runtime->dma_area, the
> silence fill in fill_silence() -> get_dma_ptr() dereferences a NULL
> pointer, and on real hardware the device may additionally keep
> DMA-ing into the freed pages.
> 
> Close the race by leaving the PREPARED state atomically with the
> entry state check, inside the same stream lock critical section: a
> START that already completed makes the hw_params/hw_free state check
> fail with -EBADFD, and a later START observes SETUP and fails in
> snd_pcm_pre_start() with -EBADFD as well, so the data plane can never
> be armed while the buffer is being freed or reallocated.  Both
> functions impose SETUP as their resulting state anyway, hence this
> does not change the state machine semantics visible to user space.
> 
> The buffer_mutex/buffer_accessing serialization introduced by the
> earlier fixes for the prepare-vs-hw_params races cannot simply be
> extended to the START path: the trigger action has to run under the
> IRQ-off stream spinlock for atomic PCMs, and failing START with
> -EBUSY whenever a read/write transfer is in flight would be a user
> visible regression.  Transitioning the state atomically at entry
> avoids both problems.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>

Could you check whether the issue still happens with 7.3-rc2?
The race should have been already addressed there.


thanks,

Takashi
