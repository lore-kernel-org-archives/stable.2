Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EE3033E1
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369189; cv=none; b=P9GrHWtDvvSJlKo0UEzGcxQDl9x70a6WvD60mFVMhOXWwR/xxS1uCFuahzSR/vYisu3EmMBzQeRLJCqIeyemrxpJpeUAtKWfzpS8kIPG9Oa+1CL0sSC9qDXhqoSmn/S4cpNjbHqn+53BLObumLXP+extE+naTFZhPYP8NfHI2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369189; c=relaxed/simple;
	bh=rJr3G0XswjMFjgKhPXxeOIVg34Xt23MrpkConhugBkY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC+5YyRRpKp9BTpI7E2DGA8gDe/CisnD6v2JTpOlsNt5u22X2BVN3Qh7WbE6vhHOvku14I6jR7R4TQ8qIOkNSiQBtaIrDjdVZ/yCKcQBCCN4d2xSCGI5nmnK/TcbajyNdelqa3BEdsNk1I0w4PKw7qW1YzU6xJy5oPNyzOsvQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e4lR+ENk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V4f02wnM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dJc/gDjJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DU3wncMo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e4lR+ENk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V4f02wnM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dJc/gDjJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DU3wncMo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CADE13E11;
	Mon, 10 Aug 2026 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786369170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CisBn1B6kkigmvzWeDZSGLTZq31XjYHc6dh/+tbquP8=;
	b=e4lR+ENkh2rTPLqPZzuL11tQco669cGIaLnrBz+mxlpgNDqSm7meHn+VZ3/Bk+UkvTBtkF
	thP5wFmsoet11Pu6R0mnNKTFy0ymbHq//1Exm6gSelnsk1G0JNArNdujwp5ZXzy5iB/Lyp
	PL1/gGGCwMsFxxZZmcJV4TSAyCfS/JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786369170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CisBn1B6kkigmvzWeDZSGLTZq31XjYHc6dh/+tbquP8=;
	b=V4f02wnM69usU06cf0ymx3WVKV5MDi6uBs+X7iWox1DMNgsbDlAphs8GS5rzVSPu5S83e0
	CgE4mlmO+MN2zSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786369166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CisBn1B6kkigmvzWeDZSGLTZq31XjYHc6dh/+tbquP8=;
	b=dJc/gDjJCWrTbA/kx2thFVusrKkVNyHjHvcu7UCTxHck+uF7Bm3tSZQJ20KXIIxpMyQItU
	tItvQPYLRNab5td1jL9eJOQ+iFAugTLRCPrdSlp9K+b/YnLKo6vnHP4MEEITltXJosPwEi
	zGMNGLIgtZzJQ3vppVOVPbFa8YHpZVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786369166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CisBn1B6kkigmvzWeDZSGLTZq31XjYHc6dh/+tbquP8=;
	b=DU3wncMoDHzSKxCWfIHXOW6YAshly/ItvioZrHkmUYY90YpJ6laopfF6rxWFtHEAiyLhY4
	vwPnPYXECHj0dVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1702779B6;
	Mon, 10 Aug 2026 13:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YBkFMoHUeWoXIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 10 Aug 2026 13:39:13 +0000
Date: Mon, 10 Aug 2026 15:39:13 +0200
Message-ID: <877blyccxq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a p/n: AD3Q9ET#UUG
In-Reply-To: <20260810125209.2014042-1-ii343hbka@gmail.com>
References: <20260810125209.2014042-1-ii343hbka@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On Mon, 10 Aug 2026 14:52:09 +0200,
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

Hmm, it's still with spaces instead of tabs?


Takashi
