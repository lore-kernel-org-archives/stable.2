Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AB4E66DA
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610083; cv=none; b=UPQZ1sfEPrlzlmygNLnw+umf9D7l21zw2UPLgAroBYgYqIUyAqOZUgSSJl9Q8E2HBNaehO1min0/k/v1j99ullP4rxD0v+cVM345RQrKfE0MTD7/2NoRfClPPfBRO7+HVlhujfKDD64L/VQ3cC60Zgvmb3j5J3zGUo7MMaZiVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610083; c=relaxed/simple;
	bh=QRO3DN4KaQTwPY9IOxx+3qmtMveFw1+laRuapbTz3F0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8pf2jKbFS+57xgMRfLK1q0qkBPIG8/1yaUgXD94BTl2h/6eDwOU9gSYQuSCbkQ+TzLTuIftBwE35vC+VFRaqJE1wZdVMJCwT8CMTl+NPyz9rxdQB1zVjZTdKgZ4XfVYMVamJWqWalQdqjZTSUYhcsFnxkCA3Dv4NvDF7mxnUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T3gpHts0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pq3dmK+1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XSch0PvK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sWXMiUU1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T3gpHts0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pq3dmK+1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XSch0PvK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sWXMiUU1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7ACD21F8C4;
	Mon, 28 Sep 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790610066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py2s2VRIiFsIoYMQW83njGSmY+DTeNJ2XEePPUef2Qo=;
	b=T3gpHts0LGkRDEOF1VyUDyj3qpBmuwiIvx4vD/wC8sg2ZmGswC+XDEm52mif/Kzxj9OQEX
	sEMwOcFuMavnhQQlmopuWlh40fVI9TqRA+qv5wYmxBfy+s02TKTJSyW+LOfkVsPL2ASDNj
	KrES2OEG4hiDC1NXgv26tAsz9Jf79vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790610066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py2s2VRIiFsIoYMQW83njGSmY+DTeNJ2XEePPUef2Qo=;
	b=pq3dmK+1bccwWRHYAt9aOfX3RBJk9Yw0cYMklyZcYyAofz6aa6gqippDqEE59TlxqEd2y0
	B3D/BytScj3b8HDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790610062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py2s2VRIiFsIoYMQW83njGSmY+DTeNJ2XEePPUef2Qo=;
	b=XSch0PvKGWcZ7xa+/QpU5h0415KJHCNPeU+QKTSlwr9X8EX4Gw458DgHrvyfEI8l01FoVG
	1YBJ5KXAN9yN6WIYpT0Txz+z4ZkgZe7d3AAzQSumGdDtAsYhxtDwxYjPrQZAayuDB1FS5O
	A9h7n+c5hL4ZY8zQKIXRmNNRNerIPGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790610062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py2s2VRIiFsIoYMQW83njGSmY+DTeNJ2XEePPUef2Qo=;
	b=sWXMiUU1mJa4Fx076XoFt8f2nl/NUpEaCeTO3QxFDl40mmLZVFi/U5cBM9L+nZ5xicioI8
	myfTeNFZ1Mt1kOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F781340F;
	Mon, 28 Sep 2026 15:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C7bXAY6KumoxSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 15:41:02 +0000
Date: Mon, 28 Sep 2026 17:41:01 +0200
Message-ID: <87cxtx4c4y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE
In-Reply-To: <20260928152925.69032-1-jwuerz@gmail.com>
References: <20260928152925.69032-1-jwuerz@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On Mon, 28 Sep 2026 17:29:25 +0200,
Jared Wuerzburger wrote:
> 
> On the Minisforum V3 and V3 SE (ALC245, PCI SSID 1f4c:e001) the
> internal digital microphone array never produces any audio. The DMIC
> pin 0x12 is parsed correctly ("Internal Mic=0x12"), but the headset mic
> jack pin 0x19 (BIOS pin config 0x04a19050, jack detect enabled) has no
> presence detect wired on these boards: reading GET_PIN_SENSE on 0x19
> always returns "present" (as it does on the unused, unconnected pin
> 0x18), while the headphone jack 0x21 reports correctly.
> 
> The generic parser therefore sets up auto-mic switching and, believing
> an external mic is always plugged in, permanently routes the ADC to the
> empty jack (mixer 0x23 input 0x19 unmuted, input 0x12 muted). The
> "Mic Jack" kcontrol reports "on" with nothing plugged in.
> 
> Mark pin 0x19 as having no presence detect. The parser then stops
> auto-switching and exposes a normal "Capture Source" (Internal Mic /
> Mic) control, which desktop audio stacks drive from their Internal
> Microphone / Microphone ports. The existing bass speaker DAC routing is
> kept by chaining to ALC245_FIXUP_BASS_HP_DAC.
> 
> Tested on both models with the same pin config applied through a
> snd-hda-intel patch firmware ([pincfg] 0x19 0x04a19150):
>  - V3 SE (Ryzen 7 7735U, BIOS 1.03), kernel 7.2.6
>  - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7
> Both boards report the same codec SSID and the same 0x19 default. On
> both, the internal mic records at a normal level, headphone jack
> detection on 0x21 still switches output, and the bass routing is
> retained (DAC1/DAC2 Playback Volume controls present). A headset mic
> on the combo jack was not tested (none available); with this change it
> has to be selected manually. V3 users already report that the jack mic
> gets no input [1], which is the other symptom of the same broken
> presence detect.
> 
> The patched alc269.c was build-tested with W=1 on tiwai/sound.git
> for-linus (7.3-rc3) without new warnings.
> 
> The diagnosis, the fixup and this changelog were written with the help
> of an AI coding assistant; I reviewed them and tested the change on the
> hardware listed above.
> 
> Fixes: e34743018249 ("ALSA: hda/realtek: Add quirk for Minisforum V3 SE")
> Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
> ---
> Changes in v2:
> - Drop the alc269_fixup_models[] entry (Takashi)
> - Add Fixes: tag for the commit that added the V3 (SE) quirk (Takashi)
> - Assisted-by: LLM (Takashi)
> - v1: https://lore.kernel.org/linux-sound/20260927173237.339476-1-jwuerz@gmail.com/

Applied now to for-next branch.  Thanks.


Takashi
