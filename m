Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AA344DB9
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362065; cv=none; b=aX2k/G4c/dctcrXdK1zzQ7+DAH5QnBJspJVqs8cM4hyDNVgnaQQI6q4V26i/khckL20KUSE0N8gVDJvyRwz0p0iCBGMRd7awRaeaStVHXpxVZcSAdg9/EHLDjwATgnc0ygZy3wbtqywkH9yHerLiuBIXWAZkFm9PxeihuT5ZvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362065; c=relaxed/simple;
	bh=mVqI6Pz1vVJ0I3QfoFXE/NLq9/aeaM8MmzJjg80mk9w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSFkTZdAn5/OYQAsv7Qqx0IKgCRM7qvlzygBrLRzGK/ijCau1rabpDIOSRX3zBbytzkBakecY9YhtCLF7peAQhEHugcJt4ATLe70PCYQC245SxhhavD4Gl89fnxf9tmX2HSW8FeTwBhEMSHygvcF8E1imWT2Lni2mn7knrrTTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cdo0sgkS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nnwKj0BE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xXrxDVu/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LkxxNh5a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cdo0sgkS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nnwKj0BE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xXrxDVu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LkxxNh5a"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44EAC3DF6;
	Mon, 10 Aug 2026 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786362047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mqieHPBKf8hwXfEzJENbzQSqAwbDI0I8thE5CGBTzY=;
	b=Cdo0sgkSirGruPXmn/1uNv4zKS5AmjUNwsgL2UXzb9RckicjPvOKIx+rzE8u0uBkr6TITA
	z6Isd1vxYMpbPh/gk3QcwFk5aLkilZwm5fYfT7vOh7WkzI8NkCAVjlANn2WojfEKGYfeLO
	cv8nVnyb3Aqx18cYMCoxdH0tJ8NVJXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786362047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mqieHPBKf8hwXfEzJENbzQSqAwbDI0I8thE5CGBTzY=;
	b=nnwKj0BEHFO8u44MkO++wjOlX7RZ8al0Uh74987AiTwnI1r3+4foyQyx2aRRODimuGuglU
	HGt6QM41HU9779Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xXrxDVu/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LkxxNh5a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786362043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mqieHPBKf8hwXfEzJENbzQSqAwbDI0I8thE5CGBTzY=;
	b=xXrxDVu/ZHMnLohLvu25G21pWHqPDIuPn/wYh7Gop5ObJ0ZIPxm6ZkDyO6PcFG6SkecndG
	/MAv3xKtmPzGHjGoBGlgIlt9wsK6gwNkd+YLBYsf4gNJYccBUpYsFrv1txJG8Gv4D+gyXL
	uUlZFSR5WXTnoKn7XzAVbuosm/5kdqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786362043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mqieHPBKf8hwXfEzJENbzQSqAwbDI0I8thE5CGBTzY=;
	b=LkxxNh5a3hK3FRsqXF1/rEkMFqkXSUTMTcFXIKjpvYIaSPAOXcvD4DcbCKmtE/UCyLLaXL
	jav2rHWZi3mYjMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 145C7779B2;
	Mon, 10 Aug 2026 11:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1f+UA7u4eWrHKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Aug 2026 11:40:43 +0000
Date: Mon, 10 Aug 2026 13:40:42 +0200
Message-ID: <87v79i8apx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
In-Reply-To: <20260810061154.1575447-1-ii343hbka@gmail.com>
References: <20260810061154.1575447-1-ii343hbka@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 44EAC3DF6
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, 10 Aug 2026 08:11:54 +0200,
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
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 6b36c730c..ef8beb928 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7542,6 +7542,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +        SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),

The indent looks wrong; it needs to use hard-tabs.
Please resubmit the corrected patch.


thanks,

Takashi
