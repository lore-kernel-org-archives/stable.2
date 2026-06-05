Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC437AA72
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640493; cv=none; b=ocQEE6rxl5Z5hOqzTWNo7JEe3+s3xg31Baah9gvW2hYHFtQrwnhI5Iwo5IwYQXNrK1PGDWS8dgy0MOucc8G5meVaPWEGNNAEb9zhezl/MTItVYvVP0tVi8xMBuEKZ/EczC/7Ksx9MeY9M3G2YB2jx+ylrT1FhQ+0Xxmcer8w/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640493; c=relaxed/simple;
	bh=vJuN75ePJNdAimTAtBXvVWkWYNf3JzdqYu+jhWczq+A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eoq9v1/poLN/9296FaJsLQPYgMYzJ8uZKAxBnBT9c4wnlPsobfDAz6CUc5dsmcvpFWYHhtd/xf28xh2df4bDg4EBZgp4weql+5RwOU8kHfho72KPD+RsXe5iZ70J0EccA/fSC0AeJyDQHXJi+k4Cy8ksIQoI6a0XsOU6jOlZueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y7CVpmY+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q+XDvNR6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PterZcNA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H9Rx3nfN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y7CVpmY+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q+XDvNR6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PterZcNA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H9Rx3nfN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E54975812;
	Fri,  5 Jun 2026 06:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780640489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlzsNd4cfcjbhN1BWnI0HecRK1ibNVBbmVHx+I2mxbo=;
	b=Y7CVpmY+bQ9+9hDYsyILKg6+9hcwbNKRhpvl3Aejk4NKVPOC9OgF/WsI5o1W4T6IO4Dmnl
	gFmhu8aC6PSuKE/fucduIJCyUNPnYCmp1RFJh3Uf9ZIebYZcz+Oc22F2aW7RTybjyu6227
	4rxOPb1uDOQzkLV98XK/bjT1ezczReo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780640489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlzsNd4cfcjbhN1BWnI0HecRK1ibNVBbmVHx+I2mxbo=;
	b=q+XDvNR6N+JclcapgRi5gQXGhcWCb+CRODZX4ylzkl7yEUBeIzhNmUD+6+UCEdMBhtKg2U
	AWC6PmsIaAzPe3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780640488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlzsNd4cfcjbhN1BWnI0HecRK1ibNVBbmVHx+I2mxbo=;
	b=PterZcNA7PyWryeW8bzWtLrKU89CpfYjRt0rmA5xXsNIUQ58AJruwCzQaIa57vJ8Y142aP
	3Sz0kxvPEcmo8M0o8bhuZPAxQEVd95kh5ZcZ0rKzh2oXpwJCUANezajIQEzzoNSd4Bo9zp
	MEZESWYP0Ej7Lu5ojhJCxI2dFDHhgDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780640488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlzsNd4cfcjbhN1BWnI0HecRK1ibNVBbmVHx+I2mxbo=;
	b=H9Rx3nfNV/qVbv6lgFFIqRRgqmrGHtT4VGtDaLCnQ4C+k05o99Yzl/8I2gzJC8avdXDblr
	RV5AGCZi0mhxvbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1B5F779A8;
	Fri,  5 Jun 2026 06:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mXAALudqImolbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 05 Jun 2026 06:21:27 +0000
Date: Fri, 05 Jun 2026 08:21:27 +0200
Message-ID: <87o6hpv76g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a
In-Reply-To: <CA+W-NrXBVkm6bvTT8+Ri=1y11A0zBK7fFVmb5m_nKHjTu9O51g@mail.gmail.com>
References: <20260604131518.45993-1-ii343hbka@gmail.com>
	<87wlweuy69.wl-tiwai@suse.de>
	<CA+W-NrXBVkm6bvTT8+Ri=1y11A0zBK7fFVmb5m_nKHjTu9O51g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.777];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Level: 
X-Spam-Score: -3.26

On Thu, 04 Jun 2026 21:52:41 +0200,
Denis Batishchev wrote:
> 
> 
> This patch fixes the mic-mute led at HP Elitebook 6 g1a.

Ah, so you mean there is another LED for the audio-mute and it's not
covered by this patch?  Please make the description a bit more
clearer.


thanks,

Takashi


> On Thu, Jun 4, 2026, 17:23 Takashi Iwai <tiwai@suse.de> wrote:
> 
>     On Thu, 04 Jun 2026 15:15:18 +0200,
>     Denis Batishchev wrote:
>     >
>     > The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
>     > Without a quirk no fixup is selected and the mic-mute LED stays off.
>     > It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
>     > already-supported 14" variant (SSID 103c:8dfb), so add it.
>     >
>     > Note: I don't know how to fix sound-mute LED though.
>    
>     What does this mean?š Is this patch confirmed to work or not?
>    
>     > Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
>     > Cc: <stable@vger.kernel.org>
>     > ---
>     >š sound/hda/codecs/realtek/alc269.c | 1 +
>     >š 1 file changed, 1 insertion(+)
>     >
>     > diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/
>     realtek/alc269.c
>     > index 78a865709..8eebf9159 100644
>     > --- a/sound/hda/codecs/realtek/alc269.c
>     > +++ b/sound/hda/codecs/realtek/alc269.c
>     > @@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
>     {
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12",
>     ALC236_FIXUP_HP_GPIO_LED),
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6",
>     ALC236_FIXUP_HP_GPIO_LED),
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14",
>     ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>     > +š š šSND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14",
>     ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12",
>     ALC236_FIXUP_HP_GPIO_LED),
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16",
>     ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>     >š š š šSND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12",
>     ALC236_FIXUP_HP_GPIO_LED),
>    
>     The table is sorted in PCI SSID order.š Please try to put the entry at
>     the right position.
> 
>     thanks,
>    
>     Takashi
> 
> -- äÅÎÉÓ
> 
