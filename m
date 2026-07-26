Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3634B410
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048805; cv=none; b=KwlEi8AOEu1BANmjYIty6tCVEHicJzr3EY9jrijOysLLC2Bnrp5fMsyLCiipGZyQgrLtSjncyxJv7FoIStEQr6G+WguWkFssssiWr3GGGnsMmf1NgVQGSRWX1baMFbHI+bzZ+IQZg80Vaie720NhA1noP4qS1Ec8QIzoE7UIuPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048805; c=relaxed/simple;
	bh=mJJA1lZ+HsRZR2ayJj8JxnWN7pR+m3FuTKxZoGEsz2w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK/bDbzw+E/b6IHwdbR1fSm3VetGGBLAUrThwLQZdLVM4Mv+eVhx81VpXWHpKLbQH/5LpSWThyFdErcBtHKF7QWqWFUqOrDG7tIsTA4zNEcS5WoNuGn0WOQlRgDDtqVlWfuuQ9+XcSVzr3WuUBxLO4g44KOH6zN3U23Q9vnRmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWfOVUTd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4B5AAzcI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWfOVUTd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4B5AAzcI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWfOVUTd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4B5AAzcI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWfOVUTd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4B5AAzcI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 095FB7CE1B;
	Sun, 26 Jul 2026 06:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785048802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqBiX6wtBdPVRUc55kaw+7zZvk/f/gRYw3pSFHy6F1M=;
	b=ZWfOVUTdfJZTyuxihjSM3IEg1AySZlBmqUpENrak4xkT8sfGXV9p4QT2MHYbCZFfVsiavh
	9KzIxJ3SK/xzSDQbIfW2J8wBkAVfuZkE07bJ71eqfNv95ovwBtOqiqireQ0SC4PtzboDhK
	HXMr57ZzvmeZYbFeVyUvC852OfqYPKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785048802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqBiX6wtBdPVRUc55kaw+7zZvk/f/gRYw3pSFHy6F1M=;
	b=4B5AAzcIlQKg+QfKCrIjzlCILNpTBVnshxhXB31v0C+zJPV8KQm7EzidpbLs9s83APCVjF
	RB100R7pWbdAl+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785048802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqBiX6wtBdPVRUc55kaw+7zZvk/f/gRYw3pSFHy6F1M=;
	b=ZWfOVUTdfJZTyuxihjSM3IEg1AySZlBmqUpENrak4xkT8sfGXV9p4QT2MHYbCZFfVsiavh
	9KzIxJ3SK/xzSDQbIfW2J8wBkAVfuZkE07bJ71eqfNv95ovwBtOqiqireQ0SC4PtzboDhK
	HXMr57ZzvmeZYbFeVyUvC852OfqYPKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785048802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqBiX6wtBdPVRUc55kaw+7zZvk/f/gRYw3pSFHy6F1M=;
	b=4B5AAzcIlQKg+QfKCrIjzlCILNpTBVnshxhXB31v0C+zJPV8KQm7EzidpbLs9s83APCVjF
	RB100R7pWbdAl+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6A83779B9;
	Sun, 26 Jul 2026 06:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iq/VLeGuZWqjdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 06:53:21 +0000
Date: Sun, 26 Jul 2026 08:53:21 +0200
Message-ID: <87jyqib5su.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: raoxu <raoxu@uniontech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	rongqianfeng@vivo.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: lx6464es: fix period byte count for 16-bit streams
In-Reply-To: <8BB12E8D92A7CDBA+20260723085710.2567463-1-raoxu@uniontech.com>
References: <8BB12E8D92A7CDBA+20260723085710.2567463-1-raoxu@uniontech.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Thu, 23 Jul 2026 10:57:10 +0200,
raoxu wrote:
> 
> From: Xu Rao <raoxu@uniontech.com>
> 
> The lx6464es driver advertises both 16-bit and packed 24-bit PCM formats,
> but lx_trigger_start() and lx_interrupt_request_new_buffer() calculate the
> DMA period size as runtime->period_size * runtime->channels * 3.  That is
> only correct for the packed 24-bit formats.
> 
> For 16-bit streams the driver submits buffers that are 50% larger than the
> actual ALSA period and advances the DMA address by the same wrong amount.
> For example, with 2 channels, 256 frames and 4 periods, the third buffer
> already extends beyond the ALSA buffer and the fourth buffer starts outside
> it.
> 
> Use snd_pcm_lib_period_bytes() so the byte count matches the runtime
> format, channel count and period size.
> 
> Fixes: 02bec4904508 ("ALSA: lx6464es - driver for the digigram lx6464es interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Thanks, applied now.


Takashi
