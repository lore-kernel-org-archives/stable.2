Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5723CF1ED
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442898; cv=none; b=hkjTKds/XlE3SOpHiGSUweS4jZpIL+om/wATNup7lI7I8h/F05XsIjl4x80EAo2R2KH3rKMz6HIMEo9xD3W3AFkuTckSjFcBAE59jpeywFZxq7jxWRZstf3WfFKszGzEverBss7KQbnl3IQ5bXKZOld3Wg0xQ+nEut7HGapjYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442898; c=relaxed/simple;
	bh=z5WC5Oh8VXR9CcMI4p5XcyJpZLp7SF8z1n4K/iuDZkA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGqhbiOZYz5VI4nWVQvx6X6U6lKmSr816qKwDLDIopgZ5qXk0u3oHrY5VI0SOu8sVKKLrjjySpLZG3ZkD3vf6YCe8aCOhNbj+hy3VV+4A2IK6+8gp8qGigHdExwQ+S7/aSQMJEV9eji9X9+EFMEAPPXPCKV89VR3cNrhzShEbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KtHzrvNL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=la++t47T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u6wYS2ur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FuQs3qHB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KtHzrvNL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="la++t47T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u6wYS2ur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FuQs3qHB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 338DD1F799;
	Thu,  8 Oct 2026 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791442886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdUhKWglyOJlEjxltVwov626EhVkyCueNw5irqO7AGY=;
	b=KtHzrvNLkHow6HafrhK+IzN6TS9PNRGF3ZiIKp+SfnWScat8tlOrc6RtdjcFHCqrO//q2P
	DBHG6JBit3hUJ9MYMPrprBgrnpFimF7Wtj4djOKDkLDE+a14mtF8hSJJddpu4uFbyNOmzi
	rBA5Ogp73RgI5j/zUUiJsv6t1iPOhFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791442886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdUhKWglyOJlEjxltVwov626EhVkyCueNw5irqO7AGY=;
	b=la++t47TG8FMUGChhk3gSVEK+hC13pjqjrQXlTMP91JPqX45RzZabikQW9qEr961tOw4Ku
	MdbX+2cp9oSxBvAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791442885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdUhKWglyOJlEjxltVwov626EhVkyCueNw5irqO7AGY=;
	b=u6wYS2urMzX14qurIKP4K4muwPqsusP0y/vNDe3IATsurTKGqBzq9ziNyEdm8UatO17y64
	ZGwco6TfTUb9fAa3HuW6lVleOiF/3HeJtFFwhZkX4TwQU+z2ZJlZ18LmEn3tuCDStcPuwE
	HSfX0Y4Pg1JhfWnhgysnLPyEzuUEX/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791442885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UdUhKWglyOJlEjxltVwov626EhVkyCueNw5irqO7AGY=;
	b=FuQs3qHBNkIvL5B7spPvZd8PzA1j01JOonyq7dqA5H9tUWGFsaGy9BGjZY2nuu5/PnOCRf
	j80OKhXOlxSS/0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB65F13354;
	Thu,  8 Oct 2026 07:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lB90MMQ/x2ozXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Oct 2026 07:01:24 +0000
Date: Thu, 08 Oct 2026 09:01:24 +0200
Message-ID: <87v77c65h7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Matej Sochan <matej.sochan@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Eric Naim <dnaim@cachyos.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix silent speakers on Lenovo Legion S7 15IMH05
In-Reply-To: <20261007-legion-s7-v1-1-8ea7fb7ee766@gmail.com>
References: <20261007-legion-s7-v1-1-8ea7fb7ee766@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 07 Oct 2026 22:37:46 +0200,
Matej Sochan wrote:
> 
> The speakers on the Legion S7 15IMH05 (PCI SSID 17aa:3811, ALC287) stay
> silent after a cold boot with the current quirk, which applies
> ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS. They only start working after a
> suspend/resume cycle.
> 
> The amplifier setup is sent through COEF 0x24/0x26 on NID 0x20. On this
> machine the first pass of that sequence appears to only wake the
> amplifiers. Sending the identical sequence a second time makes both
> speakers work, provided the second write comes a few milliseconds after
> the first: back-to-back writes leave the speakers silent, a 7 ms gap
> makes only the right speaker work, and 8 ms or more is reliable. A dump
> of all COEF registers of NID 0x20 taken before and after the second
> write shows no difference.
> 
> Add a dedicated fixup that writes the sequence, waits 20 ms to keep a
> margin over the measured minimum, and writes it again on every codec
> init. It chains to the same AUTOMUTE fixup as before. To share the
> sequence, move the verbs of ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS into a
> named array; this has no functional change for the other users of that
> fixup.
> 
> Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
> Cc: stable@vger.kernel.org
> Link: https://github.com/CachyOS/linux-cachyos/issues/792
> Signed-off-by: Matej Sochan <matej.sochan@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi
