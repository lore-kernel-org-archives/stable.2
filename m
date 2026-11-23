Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424263;
	b=oozqNWUffY2fzfR4J/stDW3QPuFVj0o61OY/K3A0e2CURSGbWv7oLEIVzxxklLwfXW+i
	 S7zGcCDt5I6N+sJ+3t5g9lwOVpY+67n0mVWKHyR2P5g4KgA1s+Gn5fB/n2vlK2XkGH4ox
	 w341qd2rj4ESUufgNkbBwgPaAkVrGbw6dcPoiRWeJ+o2wEl9JyHiqGJCGWMCVnqqvvhiW
	 A3QWbyJJsH1zZIYz7rN6NUPPBJf8JtUyTaJsts1AYwhiJGLBj1HxQzVQ6lwfPEyyWEQX3
	 lrYUZW2SMEIPmSgszNYsNHV99yZus8v/ufeGPPf262TEoI/fZDRr5/SL727NVkpNhGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424263;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=97L5FdV4LjZSM+ya3zic+y5X9JdtVKSVVEwdBTZDztY=;
	b=iwu98jY3pPgMe/VCUy7ZOFyfGWqF8KTSxMhcftWGsh0FAuJwjDE5J8HITtA4LmICE0Xd
	 ZW6FxE1W4WASPG7pYJA6o1WiyVOKMdN022iydVbs7mRuk8zWLPSeugqZD3Escz9r28keI
	 clhm3DGeDW3hqxHMs0IKfaz/1kBwhZo/FdfyeKgAdnHAVRDfsrOsUmGR0AWOTgKzZO15E
	 4LQdwJpHN8J/exPH52wB7gEKHN6VIQgW/bAYJfvKH+SV8IzTI5HscqD/H4bXO4Wm0yU+t
	 auNixDptOvDbYaJiiJCHs+cthpQKUJdPbWjb9NtrJdUjM9nn8jMvsVi3u2Z8/XJmFDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aAICWo4f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tkaylyGC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aAICWo4f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tkaylyGC;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B06606A32C;
	Mon, 23 Nov 2026 08:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B06606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aAICWo4f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tkaylyGC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aAICWo4f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tkaylyGC
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2208B21BD0;
	Mon, 23 Nov 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97L5FdV4LjZSM+ya3zic+y5X9JdtVKSVVEwdBTZDztY=;
	b=aAICWo4fvpUAUp3JFrhV6R3xiQ3pJTQ4ytMPOay7zx3E3ws1S73ttJOE3ONzgZQjBdN36V
	hcil4pnMFmTaZJ7BX1ERaBC+vQ6fRQbOe9N87G5w7irvZqSUH1Cuh4d5NTFWYp41eHyr23
	2fSuQKc02bg/KrYzPHGy7fCWZ+7N+Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97L5FdV4LjZSM+ya3zic+y5X9JdtVKSVVEwdBTZDztY=;
	b=tkaylyGCghp4J7rbyxu3aj27QboXw7D2b5J9NvSqkIJc41l4Xa+h7YauleOZVu2Rm/qlI9
	3/KYRGC3D4qEXDBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795424261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97L5FdV4LjZSM+ya3zic+y5X9JdtVKSVVEwdBTZDztY=;
	b=aAICWo4fvpUAUp3JFrhV6R3xiQ3pJTQ4ytMPOay7zx3E3ws1S73ttJOE3ONzgZQjBdN36V
	hcil4pnMFmTaZJ7BX1ERaBC+vQ6fRQbOe9N87G5w7irvZqSUH1Cuh4d5NTFWYp41eHyr23
	2fSuQKc02bg/KrYzPHGy7fCWZ+7N+Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795424261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97L5FdV4LjZSM+ya3zic+y5X9JdtVKSVVEwdBTZDztY=;
	b=tkaylyGCghp4J7rbyxu3aj27QboXw7D2b5J9NvSqkIJc41l4Xa+h7YauleOZVu2Rm/qlI9
	3/KYRGC3D4qEXDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE9C1352B;
	Mon, 23 Nov 2026 08:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jBzwIAQABGsAAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Nov 2026 08:57:40 +0000
Date: Mon, 23 Nov 2026 09:57:40 +0100
Message-ID: <875wxnexh7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alexandre Becholey <alex@becholey.ch>
Cc: Daniel Mack <zonque@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Karsten Wiese <fzu@wemgehoertderstaat.de>,
	stable@vger.kernel.org,
	Daniel Mack <daniel@caiaq.org>,
	Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@suse.cz>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: caiaq: stop the iso packet parsers before a partial block
In-Reply-To: <20261119131632.650637-1-alex@becholey.ch>
References: <20261119131632.650637-1-alex@becholey.ch>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,wemgehoertderstaat.de,vger.kernel.org,caiaq.org,suse.de,suse.cz];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 19 Nov 2026 14:16:55 +0100,
Alexandre Becholey wrote:
> 
> The iso packet parsers in audio.c walk a packet in blocks of one sample
> per stream, but only compare the start of each block with the packet
> length. The block size follows from the channel counts the device
> reports, so it need not divide the packet length, and the last block of
> a packet runs past its end. A device reporting e.g. 62 channels can make
> the driver read and write up to 232 bytes past the capture and playback
> URB buffers in URB completion context.
> 
> Make each parser round the packet length down to a multiple of its own
> block size, which depends only on n_streams and not on
> spec.data_alignment (the device can change that at any time), and zero
> the unused tail of a playback packet.
> 
> The bug was found, and the reproducer and this fix were written, by AI
> agents (Claude Mythos and Claude Opus models). The analysis and the
> patch were reviewed by a human.
> 
> Fixes: 523f1dce3743 ("[ALSA] Add Native Instrument usb audio device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Becholey <alex@becholey.ch>
> ---
> An emulated caiaq device on QEMU xHCI reporting 62 channels and sending
> 512-byte iso packets triggers KASAN slab-out-of-bounds in
> read_completed() on v7.3.1 and master 9d66f26fefac, as do 3- and
> 12-stream variants in modes 0, 2 and 3, also with the device switching
> data_alignment mid-stream. With the fix: no report in 85 boots (20 on
> master); a well-behaved 4-stream device streams as before in modes 0, 2
> and 3. Not tested on real hardware. Reproducer available on request.

OK, I applied now to for-next branch, and let's hope this works on the
actual device, too.


thanks,

Takashi
