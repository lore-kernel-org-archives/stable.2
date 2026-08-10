Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3CA3F23BF
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376319; cv=none; b=hX9Vsk88ycz/zE6OHx3GwzC4B14w7QxNIneyHbIazTGO6XWtDxm70k7Yon8l7RmHNgqCks4o+Bp7vkaLPggMXfeuiWWIhMaLUGhF8FbcoCAbYZrNfgXlrxVtZ93b+i5nZBXJ/S1GtAGp3+Mfui6ZEN3vZ/JZYWUZlE8dEfpdqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376319; c=relaxed/simple;
	bh=mDszcMsWC0B6Nkf3PYyOxCVREEHShMdcB6sP5kCLmy4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A20pCfQh2dZp/uZFQCEwK94LKHMBSW6lgHpc63U5fJvnBx0M7Wlq08IgF/ceEEp3ViZUaKvpHFap0II0Jcit/9Dbj0fZHbjL6ihfVijujkoH2ahnVaK56HnY9daugjvywGLRyL0Vgi/ztZOiEEuBg2Uku7rAo7FUf9x7xwimXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oGZlBRLV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bcv3F5Kj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mVbCvnID; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vIwft7uj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oGZlBRLV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bcv3F5Kj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mVbCvnID";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vIwft7uj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FDFF3E05;
	Mon, 10 Aug 2026 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786376300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=072trYjiCwvTLREEYLn/y7Q28nhRp8AIFJ1WXCcOtmA=;
	b=oGZlBRLVZwQMLgqUizxI1Y8032/jy1tGAkYJ99ZsPyCeqiLtjly1Ks7EeGw5VUdm24kdVG
	P/g/IpCsFE8Eg4cZCLNWSkKmKFdsnDTQr9zqqaclPhXHMJwuK9D6VemH2aSzY4E3rfzwfJ
	/SR0w2A1yycAm/SBIHMCslwWkbT7NwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786376300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=072trYjiCwvTLREEYLn/y7Q28nhRp8AIFJ1WXCcOtmA=;
	b=bcv3F5Kji+EMhTuhgSTjZTprGBunfgMmLIUf5pQdpKuaM8By9XbIkqcvMJC/9Y/sp01y3D
	os7kOKLLDphU/rDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786376296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=072trYjiCwvTLREEYLn/y7Q28nhRp8AIFJ1WXCcOtmA=;
	b=mVbCvnIDvxdDnT7NvwsPt7/GIb1xfFUTorCr30LKsso92yg2dt5xM9eMhdKMqllFOePxdi
	wxLkP+NYHVatMVKtcYy6JkHugZ9mQga5ADD/ZbuA9cGDlnrJz07I4Yt4NL19ZHwe5MIxxD
	ipGjZ7vWjR7aURBy1wh/chp4dqgVuaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786376296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=072trYjiCwvTLREEYLn/y7Q28nhRp8AIFJ1WXCcOtmA=;
	b=vIwft7uj9cO9MDK9JrapnP81M0KcoPYXxAcXNJHkc+ywvZXbF7E3+kDyjC0ktd5woC7RUW
	7z8rYAvdlAKTiBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FDB5779B2;
	Mon, 10 Aug 2026 15:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T2KjGWjweWqoFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Aug 2026 15:38:16 +0000
Date: Mon, 10 Aug 2026 17:38:16 +0200
Message-ID: <87tsp2asuv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
In-Reply-To: <20260810151440.2306217-2-ii343hbka@gmail.com>
References: <20260810151440.2306217-2-ii343hbka@gmail.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On Mon, 10 Aug 2026 17:14:41 +0200,
Denis Batishchev wrote:
> 
> The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
> Without a quirk no fixup is selected and the mic-mute LED stays off.
> It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
> already-supported 14" variant (SSID 103c:8dfb), so add it.
> 
> Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2: fix indentation (per Takashi Iwai <tiwai@suse.de>)
> v3: fix indentation, 2nd trial (per Takashi Iwai <tiwai@suse.de>)
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 6b36c730c..bcbdafb42 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7544,6 +7544,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),

The table is sorted in PCI SSID order, so it should have been put at
the one entry below; for saving the internet bandwidth, I corrected
locally at applying now :)

Applied to for-next branch.  Thanks.


Takashi
