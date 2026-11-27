Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801093;
	b=V7w8ZrccPd9+anXmfU/BvDnKgFOthBBJOAXSIP12ZZCEjDvfTwalkHXL1ug7RoqY4QF1
	 RdyNsYBdyqnWDajqjfBmnKQKPsbfIf9FmeO1BBaaD1ZcwpzltembWoRYxWAEthxNRgEAH
	 mTC3frFiqc5fchoe6briabB4EUTP4XcXXY4qu3lR7/kuVzZLVPddGwj/Y2n8/SlXN2K1z
	 zXcRupfBWtLHIFTtLH8kma3WB0LfhbicMgZVXLMfEVYUfLbErD2uoI6MRxxtK1Dmxyouz
	 5loGR/ulN3ces3OHenQCr5H6z4zAb/ezUiWVcuqfeWWVfjFksVziJ6NJ+v1I4mZGBxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801093;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=cN4RZLULD5IcC6A6+YA3uTFCFgzGpLrwot8O38KuX6Y=;
	b=ffHVLARioMjoJUV47Hwa+ZZzD+LWnGurrYXZqbEMMPx8/J6zERYd6yWFho3vmTZvigIM
	 Nt7QzLjQyZfwzWTDvd6/Qm4PFqlRHuurGEu6pqw4OwoECyaA8K7UJsNZLYVeaXAVjvid2
	 CtfzmE2ErOBZCq3gQu4AJvMhQaDJHPhwGRRl+NVkdxHBH0aH7elJmbPuAhnQbc5AdcVTa
	 +SYq4qM1mGVLKBKEJE0camgACkt2fzXsvVX2mOqunpBQHhwl5zbhn3/+LIb0S6mJsu+n2
	 sMQeOZHRQrRqEpgB622VGtAGANxslS4RGm1/OlxG3HKAih+KywbXnM4AiDyVQvqaC1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MIRyChMu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lS8y0xNd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MIRyChMu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lS8y0xNd;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8D606A685
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F8D606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MIRyChMu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lS8y0xNd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MIRyChMu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lS8y0xNd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3973A229B6;
	Fri, 27 Nov 2026 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795801081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cN4RZLULD5IcC6A6+YA3uTFCFgzGpLrwot8O38KuX6Y=;
	b=MIRyChMukUfc+PK/+tNp4Em3lqfg7DQXp4Bo86SRMbg4Q6dHrjv5tivpHe0AAg8hGnd1/S
	CtWuUFsG3vt1lZ2yWtByn9ATuVIWwYjI//yAnw8ejX3fQnA0swCw4o6bK7qHvlNLipjV5h
	lQQOt5UI7ldtrtCbtib2Swv5G4dYNQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795801081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cN4RZLULD5IcC6A6+YA3uTFCFgzGpLrwot8O38KuX6Y=;
	b=lS8y0xNdsmaBCDJNArxaGLoWuopxj5wonROoGQQjWhBqQ9EbTKuOwF1fifgTdz3Ux/4LY2
	Z64Xm8MNy3bwKNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MIRyChMu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lS8y0xNd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795801081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cN4RZLULD5IcC6A6+YA3uTFCFgzGpLrwot8O38KuX6Y=;
	b=MIRyChMukUfc+PK/+tNp4Em3lqfg7DQXp4Bo86SRMbg4Q6dHrjv5tivpHe0AAg8hGnd1/S
	CtWuUFsG3vt1lZ2yWtByn9ATuVIWwYjI//yAnw8ejX3fQnA0swCw4o6bK7qHvlNLipjV5h
	lQQOt5UI7ldtrtCbtib2Swv5G4dYNQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795801081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cN4RZLULD5IcC6A6+YA3uTFCFgzGpLrwot8O38KuX6Y=;
	b=lS8y0xNdsmaBCDJNArxaGLoWuopxj5wonROoGQQjWhBqQ9EbTKuOwF1fifgTdz3Ux/4LY2
	Z64Xm8MNy3bwKNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D42F8134E8;
	Fri, 27 Nov 2026 17:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HApQKvi/CWu9FgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Nov 2026 17:38:00 +0000
Date: Fri, 27 Nov 2026 18:38:00 +0100
Message-ID: <877bhymayv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Carl Egbert <egbertcarl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Eric Naim <dnaim@cachyos.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix mute LED regression on ThinkPad T440/T450 family
In-Reply-To: <20261127171241.1619113-1-egbertcarl@gmail.com>
References: <20261127171241.1619113-1-egbertcarl@gmail.com>
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
X-Rspamd-Queue-Id: 3973A229B6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.51

On Fri, 27 Nov 2026 18:12:41 +0100,
Carl Egbert wrote:
> 
> Since commit 8a889cce1c6d ("ALSA: hda/realtek: Unchain
> ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST"),
> ThinkPads whose fixup chain goes through ALC292_FIXUP_TPT440_DOCK or
> ALC283_FIXUP_INT_MIC no longer get their mute LEDs set up. On a ThinkPad
> T450 (SSID 17aa:5034), the speaker mute LED no longer follows the mute
> state: no mixer control gets the speaker LED access flag, so snd-ctl-led
> is not loaded automatically and
> /sys/class/sound/ctl-led/speaker/card1/list stays empty.
> 
> Commit b2d447288fa7 ("ALSA: hda/realtek: Add
> ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST quirk") added a ThinkPad
> variant of ALC269_FIXUP_LIMIT_INT_MIC_BOOST and switched the quirk table
> entries that selected the plain fixup directly. Then
> commit 8a889cce1c6d ("ALSA: hda/realtek: Unchain
> ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST")
> removed the chain to ALC269_FIXUP_THINKPAD_ACPI from the plain fixup.
> However, two fixups reach the plain fixup through their own chain_id and
> were not converted:
> 
>   - ALC292_FIXUP_TPT440_DOCK, used by the ThinkPad T440, T440p, T440s
>     (via ALC292_FIXUP_TPT440), T540p, W541, X240, X1 Carbon 2nd, T550,
>     X250, L440, T450, T450s, L450 and X260
>   - ALC283_FIXUP_INT_MIC, used by a ThinkPad (17aa:501a), the IdeaPad
>     S210 and the Lenovo 145 (via ALC236_FIXUP_LENOVO_INV_DMIC)
> 
> Their chains now end before alc_fixup_thinkpad_acpi(), so these machines
> no longer get the mute LED setup for thinkpad_acpi, nor no_shutup_pins.
> 
> Point both fixups at ALC269_FIXUP_THINKPAD_LIMIT_INT_MIC_BOOST, which
> restores the fixup chains these machines had before 8a889cce1c6d. On
> the IdeaPad S210 and Lenovo 145, is_thinkpad() is false, so they only
> get no_shutup_pins back, as before the regression.
> 
> Tested on a ThinkPad T450 on top of sound.git for-linus (e79163b531ec):
> with this patch, snd-ctl-led is loaded automatically at boot, and the
> speaker and mic mute LEDs follow the playback and capture mute state
> again. Not tested on the machines using ALC283_FIXUP_INT_MIC.
> 
> The regression was bisected on the affected T450. An AI assistant
> (Claude Code, using Claude Opus 5.5) was used throughout: it helped
> diagnose the problem, plan the bisection and write the scripts used for
> it, identify the cause, and drafted this patch and changelog. I ran the
> bisection and the tests on the hardware and reviewed the change.
> 
> Fixes: 8a889cce1c6d ("ALSA: hda/realtek: Unchain ALC269_FIXUP_THINKPAD_ACPI from ALC269_FIXUP_LIMIT_INT_MIC_BOOST")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carl Egbert <egbertcarl@gmail.com>

Applied now.  Thanks.


Takashi
