Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6B3AE6F5
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660088; cv=none; b=kxSyIf+kyQ5/2U5ljwr5tcwaA8JElQzUnNbmRNqxPs4n9CJrQC3e1Ss+Akha7WcEa1pZyrgB3G1pUaiVNDgjOldr10OSD944UC3ZMqPtQgNBEMTG+xwGqG6kkrfmcUmdBHwKnLbcxf39hVVtUS2kumwF/zMoRlXn4Ty1HbKQhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660088; c=relaxed/simple;
	bh=SjaZfvcnMjlUB/r4CGiIFCGO685RtMUV7DSyAIMhSgo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9j8Lzb/Q3jYE1gEP1lFyUKLDGhqvl99BLKjsvfJNMl76gjCsWBRKqbwJTzqjoWbwkXvuY8FXOX8TYwuo+1RPOjD5OF01uMr+/tfnZE2xn1VXcJ2Jed36rzBZ8SbD/CDRr132MgoShCQmdcR1tvmtZpG8qMXsQJpt3X+KfNtbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WnWnEQOb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KqDOltKO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zuI/hQ03; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bmYADGk0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WnWnEQOb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KqDOltKO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zuI/hQ03";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmYADGk0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B0EB21C4B;
	Tue, 29 Sep 2026 05:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790660072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyCIA/ALCwlqDgVFKzh+aLBduuAD/F4jpZh+nNsQxMY=;
	b=WnWnEQObIPhYAP3eKCkd9206kfir4S4gyPk/MtUf9SyKVuVROpmpK8EwgoEkWHOClZTBuU
	crZA9tgp4YwMKrLSq+m/YMxLx0se+xG9sft3AB+bWUJc7cLXK0ZTS70U2S3rAck/jxBNuc
	1mNmCOGQPOFUed4QdVCC0uyZW8WEpeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790660072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyCIA/ALCwlqDgVFKzh+aLBduuAD/F4jpZh+nNsQxMY=;
	b=KqDOltKOjZspSME1j/e3zXiPym/Hy/sPRCGqpIY9SAycsvxLJ7WfUJmbEfIkhzpH1a8qiS
	GYOLuFChzipfI9CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zuI/hQ03";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bmYADGk0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790660068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyCIA/ALCwlqDgVFKzh+aLBduuAD/F4jpZh+nNsQxMY=;
	b=zuI/hQ03j/3osxvJKfT5g7g6equVHvjW+3B3dH5gtlaLAeoAl2ARTkRqFXLsv7de84SUY5
	WREQ6F5UFMD7+qWPa9zhWARVymN4OnsU4eKvyWkS/2dSF+LkUDHM3/1by+rvD+cwC4qpvl
	XN8ziFCdrMSHvRRyLpNVZQUAE9+h/6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790660068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CyCIA/ALCwlqDgVFKzh+aLBduuAD/F4jpZh+nNsQxMY=;
	b=bmYADGk0ftXAWs4TlD6tbFSSj6pbLg/JAELjbCwcYEWaTfGzzpde7QFjCvJN36QkNJ0P8i
	zVzxyQzWBZUyYwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC199133F1;
	Tue, 29 Sep 2026 05:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vsFzMONNu2qMGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 05:34:27 +0000
Date: Tue, 29 Sep 2026 07:34:27 +0200
Message-ID: <87v77o39jw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks
In-Reply-To: <20260928182352.309457-1-danishkhateeb03@gmail.com>
References: <20260928182352.309457-1-danishkhateeb03@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 4B0EB21C4B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO

On Mon, 28 Sep 2026 20:23:52 +0200,
Danish Khateeb wrote:
> 
> 32-bit tasks on a 64-bit kernel can't use userspace-driven timers. The
> compat handler for /dev/snd/timer doesn't list SNDRV_TIMER_IOCTL_CREATE,
> so creating a timer fails with -ENOTTY. The file returned for a timer
> has no .compat_ioctl either, so SNDRV_TIMER_IOCTL_TRIGGER fails with
> -ENOTTY too.
> 
> struct snd_timer_uinfo has the same layout for 32-bit and 64-bit tasks,
> and SNDRV_TIMER_IOCTL_TRIGGER takes no argument, so both commands can
> be passed through unchanged.
> 
> The utimer selftest doesn't catch this when built with -m32: it takes
> -ENOTTY from SNDRV_TIMER_IOCTL_CREATE to mean CONFIG_SND_UTIMER=n and
> skips.
> 
> Fixes: 37745918e0e7 ("ALSA: timer: Introduce virtual userspace-driven timers")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi
