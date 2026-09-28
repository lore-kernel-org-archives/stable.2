Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507C3D16FC
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598597; cv=none; b=IoULtGWT1u31h54FsrzEDGqRNiTNH9ysf6Cw1w/JKvJcfcBRKWWIlI7wSTCy3tO3QM1tfdcWJMkg93boA0RCZIJfDu37o98k1AZOE7YTl0sn3+vaJQPBakNpvWQR+4051nVPvTvdngN+b9p71BSCGScgf93ThZm9O87b8zOv8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598597; c=relaxed/simple;
	bh=op89+ZScDK45ZM/MqsArAmHRw609uQCZI0HYVALP0Mk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4paPnq2vpCbr4V67CooPpDxyuR+2LGSM+YK/TvKYv7npGtYeP9uE+tmizCilXaBaVm+GoehQ/RqSt+JN9b6NxRiILlxwdImW1visbX9dFyITlES1rbAWJyhSrwY8ccg2RkLeYKwbw0Nhkx83PV9w74LRplrejwQbRnaWMWPI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ULm6qVx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hkbpztlc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MihcKZa4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IO9VdcBK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ULm6qVx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hkbpztlc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MihcKZa4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IO9VdcBK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D72E71FB68;
	Mon, 28 Sep 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790598581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/Z7nkODf7QbjYm9KVa0w/NPFgqtLB07eKXTBzj1Igk=;
	b=ULm6qVx/2mSj7XK1k95Yfs2e7GbIKiPUsZ6js+DXpx9OiCvvklih18dzaEqaZVFEmgvhxI
	9xUGKQRt6uKG2PcTcWvK6BsHImb6bapWL4V7pQV/w92prQe8ckHZXHqnBZg3RTni1S/pC6
	IYKDB0XfJ9nw/8zbNEokPVU8Na/R80s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/Z7nkODf7QbjYm9KVa0w/NPFgqtLB07eKXTBzj1Igk=;
	b=hkbpztlcJwAkYQc0AVSrdcl12/RvzHP5rcivy+UrWQt8H42S3zGHikjkLA3zj2hlR9nDmL
	ryuofTyHnqj0xpDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790598576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/Z7nkODf7QbjYm9KVa0w/NPFgqtLB07eKXTBzj1Igk=;
	b=MihcKZa48mr7b8sbHqQPIdIQ0oGH70lhHLwzIlTueIyvY3/L2vBpyNHGuzSpvXJ21yttqs
	eNBVEvq5whCArDK9GrCA6B5qZMRGaysk6psLNwAdYCoBKKufeZfun3yHTyclXA06wIsewA
	oGF4o6Wzv1WuF8Y+arotqQ/Jy2UOL8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790598576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/Z7nkODf7QbjYm9KVa0w/NPFgqtLB07eKXTBzj1Igk=;
	b=IO9VdcBKTZhDkgoGTXZu+lDsO+NDhHUvibHrYVXA4xnN9YUBNhr84QlYNZMaF7D3pGkpGm
	qQk2Rquin0JTVEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56FF0133F1;
	Mon, 28 Sep 2026 12:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m4//CbBdumoaewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 28 Sep 2026 12:29:36 +0000
Date: Mon, 28 Sep 2026 14:29:35 +0200
Message-ID: <87fqyt5zkg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix internal mic on Minisforum V3 and V3 SE
In-Reply-To: <20260927173237.339476-1-jwuerz@gmail.com>
References: <20260927173237.339476-1-jwuerz@gmail.com>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO

On Sun, 27 Sep 2026 19:32:37 +0200,
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
> Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/14 [1]
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
> ---
>  sound/hda/codecs/realtek/alc269.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 5127a111c..2de91431f 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -4384,6 +4384,7 @@ enum {
>  	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN_HEADSET,
>  	ALC285_LENOVO_DAC_RENAME,
>  	ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1,
> +	ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE,
>  };
>  
>  /* A special fixup for Lenovo C940 and Yoga Duet 7;
> @@ -7136,6 +7137,15 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC287_FIXUP_TXNW2781_I2C,
>  	},
> +	[ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x19, 0x04a19150 }, /* headset mic jack, no presence detect */
> +			{ }
> +		},
> +		.chained = true,
> +		.chain_id = ALC245_FIXUP_BASS_HP_DAC
> +	},
>  };
>  
>  static const struct hda_quirk alc269_fixup_tbl[] = {
> @@ -8349,7 +8359,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1ee7, 0x2081, "HONOR MRB-XXX M1020", ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO),
>  	SND_PCI_QUIRK(0x1f4c, 0xb020, "Minisforum AI X1 Pro",
>  		      ALC245_FIXUP_MINISFORUM_JACK_DETECT),
> -	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)", ALC245_FIXUP_BASS_HP_DAC),
> +	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)",
> +		      ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>  	SND_PCI_QUIRK(0x2039, 0x0001, "Inspur S14-G1", ALC295_FIXUP_CHROME_BOOK),
> @@ -8579,6 +8590,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
>  	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
>  	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
>  	{.id = ALC245_FIXUP_BASS_HP_DAC, .name = "alc245-fixup-bass-hp-dac"},
> +	{.id = ALC245_FIXUP_MINISFORUM_V3_MIC_NO_PRESENCE, .name = "alc245-minisforum-v3-mic"},
>  	{.id = ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO, .name = "alc256-honor-mrb-xxx-m1020-audio"},
>  	{.id = ALC287_FIXUP_LENOVO_LEGION_AW88399, .name = "alc287-lenovo-legion-aw88399"},
>  	{}

The addition to alc269_fixup_models[] is nowadays superfluous.  Unless
you need the addition inevitably, try to avoid it.

The Assisted-by tag doesn't need to be specific, just telling
"Assisted-by: LLM" is the preferred.

Last but not least, as this is correcting the existing quirk, please
point out the commit via Fixes tag, too.

Could you resubmit with those corrections?


thanks,

Takashi
