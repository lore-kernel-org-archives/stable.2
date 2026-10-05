Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9697484230
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206236; cv=none; b=sBklO3n0rry/hw6qSsdAaLz7tj2LfJOxArX0LYccIGi6upiXIgvvGZSam1uSzaWw4zXn9xbKVIGxzX1yoeSWlrjLhUiP0M9X1vHlnAihSvnWlA1swqSVCMtW8VfAkQs9DBOefGldd0HU1f11K6d3S3nBCfDt6L8o6e7LCfO2i8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206236; c=relaxed/simple;
	bh=P6IGElh6kFtoXv1emGbGUJWNbtNEuPGdok+9aqFhD0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTtq5urK4YvRmMOFzkEQMnvYAC1NQR7XekPcSzsODsoa/Oz/AN3zRh5tG0nnuDnxjPSkgYD62BA8osc8VtyveiNIBJWYFc65VSg+QPc/Wt/yvDNWttu6hWtnkBKyKD3VUqUavbR002YabEYiTQ21ZI/cpvy0hmEUXA61HsXQsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yJILtgrq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Z8Dk8de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qp5iBxqX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EGwxNYH4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yJILtgrq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Z8Dk8de";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qp5iBxqX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EGwxNYH4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17D241F7A6;
	Mon,  5 Oct 2026 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791206226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YirFXrB3/axx4LXgRf1WgGDUJIcJw0oyIncfU4JOb14=;
	b=yJILtgrqKVJBrRcEqy4vi6Gz8dUNcdhr6wFuG1UyH40ffNZG8fYk0aZ8ga0jRcYLf2pSsC
	LtYl7TKoL9QK26vtWlvS5ruaMG/hUjnxv3cFSnuVMrMAc/e4JzUcOmGPgRhPlvjea3XD0O
	kcWNMu5+wXU1KNUcHA5a6mPc3LK9nwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791206226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YirFXrB3/axx4LXgRf1WgGDUJIcJw0oyIncfU4JOb14=;
	b=4Z8Dk8defp3EQcdwNI20VuOYRTxpUQZ1mWxobpEpWT2jMYaUeVFxmBBMe/AIxxPnQPxWwi
	TjZQWBlqVH+OVEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qp5iBxqX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EGwxNYH4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791206222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YirFXrB3/axx4LXgRf1WgGDUJIcJw0oyIncfU4JOb14=;
	b=Qp5iBxqXrtUVWNbxT9LHJLwK9rLsnjZ3Yzb8GoNJkMoR3LLKNvEWraimmufx75c2Y7IrFn
	F0p3q68Mp1jfCISCqonypiKo1QoZ5yQYl0dsHHuk7QQfvAE1M7L7cvawTJmgPYLbiuxH/b
	c4VkLweUkjPSB8vGW1DImFNPOPy5nwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791206222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YirFXrB3/axx4LXgRf1WgGDUJIcJw0oyIncfU4JOb14=;
	b=EGwxNYH4UCU7B3HnFszkk3yNVNDEXlKqGGCORi5fk1bFMAJkehNkkFueY8Adt6bA7O3CQM
	5TXwS1Q4I+8C5ODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDEC113688;
	Mon,  5 Oct 2026 13:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2T6TLU2jw2qdYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Oct 2026 13:17:01 +0000
Date: Mon, 05 Oct 2026 15:16:57 +0200
Message-ID: <87fqyks2wm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Prateek Yadav" <fyw21nur@rptu.de>
Cc: alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for LG gram 16 (16Z90SP)
In-Reply-To: <ximss-325891667@mail1.uni-kl.de>
References: <ximss-325891667@mail1.uni-kl.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 17D241F7A6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Mon, 05 Oct 2026 14:35:25 +0200,
Prateek Yadav wrote:
> 
> The LG gram 16 (16Z90SP, SSID 1854:053b) drives its internal speakers
> through Samsung-style smart amplifiers on an ALC298. Nothing
> initialises them, so the internal speakers are silent after a cold
> boot, while headphones, HDMI and the microphones work. A warm reboot
> masks the problem, as the amps stay initialised.
> 
> Evidence (kernel 7.2.5-3-omarchy, sof-firmware 2025.12.2-1,
> PipeWire 1.6.8):
> - aplay -D plughw:0,0 completes with exit 0 but no audible output.
> - During playback the codec shows Node 0x03 Converter stream=1,
>   Amp-Out vals [0x69 0x69] unmuted, and Pin 0x17 OUT with EAPD on —
>   the digital path is correct, the amps simply never start.
> - Headphone Jack reports off, Speaker Phantom Jack reports on.
> - Running the known 4-amp hda-verb init sequence
>   (amps 0x38/0x39/0x3C/0x3D, cf. joshuagrisham/galaxy-book2-pro-linux
>   necessary-verbs.sh) restores speaker output immediately.
> - Machine dual-boots Windows, which explains cold-boot-only silence.
> 
> This mirrors the 16Z90TR (1854:0554) case fixed with
> ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS, and the 16" 16Z90R-A (1854:0489)
> which uses the 4-amp variant. I verified the 4-amp init works on this
> machine; please adjust to _2_AMPS if COEF 0x22 indicates two amps.
> 
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c
> b/sound/hda/codecs/realtek/alc269.c
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -8114,6 +8114,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>      SND_PCI_QUIRK(0x1854, 0x0489, "LG gram 16 (16Z90R-A)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>      SND_PCI_QUIRK(0x1854, 0x048a, "LG gram 17 (17ZD90R)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>      SND_PCI_QUIRK(0x1854, 0x0490, "LG Gram Style 14 (14Z90RS)",
> ALC298_FIXUP_LG_GRAM_STYLE_14),
> +    SND_PCI_QUIRK(0x1854, 0x053b, "LG gram 16 (16Z90SP)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
>      SND_PCI_QUIRK(0x1854, 0x0554, "LG gram 16 (16Z90TR)",
> ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
> 
> Hardware: LG 16Z90SP-A.AD7BG, Intel Meteor Lake-P HD Audio [8086:7e28],
> Realtek ALC298 [10ec:0298] rev 0x100103, SSID 1854:053b.
> ALSA info:
> https://alsa-project.org/db/?f=7e8c49270f1b902ebb9fa76a4695f8301db040cf
> 
> 
> Signed-off-by: Prateek prateek.yadav@edu.rptu.de

That patch seems wrongly written, and your mailer also broke the
spaces and tabs that makes the patch not applicable, unfortunately.

The whole description up to Signed-off-by must be in a patch
description, and put the diff after that with separation of '---'
line.

Last but not least, fill a full name with the address quoted with '<>'
in Signed-off-by tag (also From tag).

At best, try to resubmit via git send-email, which organizes all above
nicely.


thanks,

Takashi
