Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737836920C;
	Wed,  7 Oct 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381902; cv=none; b=q0N8U4WYFC7wZkTi7kz+Xbc1uVIbhDFW3GqoaI69tmhOs8xFIVkDIGkRWThHB/EpurrQqdShjxXDClwE7+YFDedf2ECZpODsq8h3jGoZrk1Ws5skPkLTd6eg5MdEE0gKvQq3mbFFpOuaEOrL8fTSOlk1UVw71Vq0GIkZEehpIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381902; c=relaxed/simple;
	bh=PbwuoTc+gBHz0AcD+4yhyq/HboT0WdObEUu9FDg0ckc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDb4doDPwzD/14ZTHg32zMrS802ofUYK57eBN5MYKx+YEJ08OgvYT2O51/ItHvsyaN5a3oC6dZa4fkWUkQnGqbYLiuVh02JXaSgKLx/xnY97DPS0Dnalt19g6Ba0cOjdRIqBm11OJzhQa/ORuePzz84ODEET8wnq5mdAZ1oQgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pVFQR6PD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8l4/5QZk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uH5ZSvSv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tG86S2IA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pVFQR6PD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8l4/5QZk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uH5ZSvSv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tG86S2IA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0DE61F443;
	Wed,  7 Oct 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791381891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zdSmLzev2n3sftdz+1rh2aD0yt5DHgo8KO/DZ7WqPM=;
	b=pVFQR6PD8lNaHL/0KYc5KYdPq9+yOHjwggs5VgtVHK6xrNXAjLDriy6FSjUMYcbjSOFioO
	6RvtdfzuR/uh29srQFe0RlPS00aVzIo38m53ECy9M9g4C+vHfPYsuwLQ6TRIdqW/obBlWo
	lz0h0EAFHam7czpGqaAGRT1aDlEdvY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791381891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zdSmLzev2n3sftdz+1rh2aD0yt5DHgo8KO/DZ7WqPM=;
	b=8l4/5QZkkwbiYqUiIGEtPhk3wILvZB0Rg3/xervcZh8YBpnt1qub1szL/UNPsK+KKV3hlL
	EIGB8/LyE7KdErCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uH5ZSvSv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tG86S2IA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791381889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zdSmLzev2n3sftdz+1rh2aD0yt5DHgo8KO/DZ7WqPM=;
	b=uH5ZSvSvNjndg2wCfvM4yIMhECoJ/8uzWTXlSTOYvleRPVhTG3/Ih7c/ZAdCcyep9PpUnu
	ttJEacYiE8w/hTMRMlRm3BL21sJumM+7soZjY+TPx174XK4n/DLLJTmVNcWh18aFAHBEhi
	P/P//i2Ae+Vko4PSTwPGn7rqUzzLgvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791381889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9zdSmLzev2n3sftdz+1rh2aD0yt5DHgo8KO/DZ7WqPM=;
	b=tG86S2IAgR8I9Dfc2DhsSZrRJaaDaGtCvUdiT9J+i6RSzorxbL7yNfrBbmp+PYguw/P8W5
	KrzzZM4EnSnj80DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DDC113312;
	Wed,  7 Oct 2026 14:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SBGiGYFRxmq3MgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Oct 2026 14:04:49 +0000
Date: Wed, 07 Oct 2026 16:04:49 +0200
Message-ID: <878q49obcu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated SET_PARAMS
In-Reply-To: <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
	<20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D0DE61F443

On Wed, 07 Oct 2026 15:25:06 +0200,
Peter Ujfalusi wrote:
> 
> snd_compr_allocate_buffer() unconditionally overwrites
> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
> is permitted repeatedly while the stream is in the OPEN state, so a
> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
> previous buffer on every call, exhausting kernel memory.
> 
> Free any framework-owned buffer before replacing it, mirroring the
> ownership check already used in snd_compr_free().
> 
> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 7c397b1c9231..c0ed76e1c844 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
>  			return -ENOMEM;
>  	}
>  
> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
> +	if (!stream->runtime->dma_buffer_p)
> +		kfree(stream->runtime->buffer);
> +

I'd rather put to the else block above (or even better, if
(stream->runtime->dma_buffer_p) block above that point).

The code is specific to that condition, after all.


thanks,

Takashi
