Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906619;
	b=X1F+PiZzL290VBOzgArVE7pBw4CLYJCjWsanWNlG+iBmda1oKdZl7h8bAVvV/rJJ3Tb6
	 M4tc8Kzo6AJOGdWERMt1RgB6monRZZcOMjobezfRjTylS49/ggFYlAoma+8zJwM7haow/
	 oRZjH2vbN/CvJk96AQdzOqzVuvDtSJ8wRgHSOdSIdzXVIqejiay2qiSCiZ4vUHtdVStG2
	 vC83wCB9yJbz9zS44Q2J/86osEP1bzoOPkNq3TwXSSTpKgIZI7NO/IkybbbUs30QXKW+F
	 ZzgFAt44y806TDAgpwR0fXfloI/w5jQGZP9FqIF6xzQ3y3elqW02bysoEjhjo3MfGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906619;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=4tee6l7ESYr5A3tZZUCvQ3/54SAkf97IqRnfqX5jFlk=;
	b=uh9GNy+eJHkarN0nBcxsXzoawJRfQqc8uMMKkwMgLvkA85fDDOYE8J/oQ1VWYhJJ92/r
	 QKMX5vELsNXTskHZ83IUZNZqmtiw1W4iTBrl8Nr+htE8ANuUpZkhq5CfXQw3iJLkpJreS
	 fBXQsGScd6kk7anUyVKUnQqbaoYT5YFD/xG3Y2PfWU/oiaeTHBthKENzQ9OiiDyFTSYHX
	 glj6E/clFQy9uDd3QfQ/RA8NpPwhkca02tiIlniAxtIvVzjTwzzoRToON1CpbqPtX3WUq
	 hjP9ulUBlfPFkFevtLrRWssBrqa9HyqyRuoT8K6LYxDfikvNt/ygkUIrVfeIuKum5iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ilTn0leg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eXtwup+L;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ilTn0leg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eXtwup+L;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326D606A329;
	Tue, 17 Nov 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0326D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ilTn0leg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eXtwup+L;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ilTn0leg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eXtwup+L
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B5181FA8F;
	Tue, 17 Nov 2026 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794906617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4tee6l7ESYr5A3tZZUCvQ3/54SAkf97IqRnfqX5jFlk=;
	b=ilTn0legoSzL/5MrcpyPA0rTED28vcAew0PIClz+VDRvLDMYn/LN8DA4c8c1W9s0d4glgG
	4RUUVZcMHqWweY7oZGC16Nj1OIIh12scE3X351wi3c+sfZ366xMSbA0lgvmmp11/7gWcOd
	HJsUaTIXJj7ixuLcUVL8oSh2zZr4Q6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794906617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4tee6l7ESYr5A3tZZUCvQ3/54SAkf97IqRnfqX5jFlk=;
	b=eXtwup+LdxiLJAz7cRNuZoYVVuI+eluVWO20lWsnFOQNs5ho4GY21omaI0+vZrNUwsc+nQ
	ogw6GlrlpxeBzsAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794906617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4tee6l7ESYr5A3tZZUCvQ3/54SAkf97IqRnfqX5jFlk=;
	b=ilTn0legoSzL/5MrcpyPA0rTED28vcAew0PIClz+VDRvLDMYn/LN8DA4c8c1W9s0d4glgG
	4RUUVZcMHqWweY7oZGC16Nj1OIIh12scE3X351wi3c+sfZ366xMSbA0lgvmmp11/7gWcOd
	HJsUaTIXJj7ixuLcUVL8oSh2zZr4Q6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794906617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4tee6l7ESYr5A3tZZUCvQ3/54SAkf97IqRnfqX5jFlk=;
	b=eXtwup+LdxiLJAz7cRNuZoYVVuI+eluVWO20lWsnFOQNs5ho4GY21omaI0+vZrNUwsc+nQ
	ogw6GlrlpxeBzsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0C01334C;
	Tue, 17 Nov 2026 09:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p9qRIvgZ/Gq8awAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 17 Nov 2026 09:10:16 +0000
Date: Tue, 17 Nov 2026 10:10:16 +0100
Message-ID: <87v75vzuvb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: william <assassinshalo29@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.de,
	evgeny@devduty.com,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] ALSA: hda/realtek: no speaker sound on Lenovo Legion 16IRX9H since f2293e7b2ddd (PCI SSID 17aa:3842 shared with ThinkBook X G2 IAH)
In-Reply-To: <CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com>
References: <CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Mon, 16 Nov 2026 02:24:00 +0100,
william wrote:
> 
> Hi,
> Commit f2293e7b2ddd ("ALSA: hda/realtek: Enable all four speaker amps on Lenovo
> ThinkBook X G2 IAH", Cc: stable) matches the laptop by PCI SSID
> 17aa:3842, on the
> assumption that this SSID had no quirk entry. The Lenovo Legion 16IRX9H (83DE)
> has the same PCI SSID, so its internal speakers are silent on kernels that carry
> this commit. Headphones work.
> Hardware
> Lenovo Legion 16IRX9H, product 83DE, BIOS N2CN32WW
> Codec: Realtek ALC287, codec SSID 17aa:38cd, PCI SSID 17aa:3842
> Amplifier: ACPI TIAS2781:00 (i2c-TIAS2781:00 on i2c_designware.2),
> driver snd_hda_scodec_tas2781_i2c
> Kernels
> Works: 7.2.10-200.nobara.fc44, 7.1.6-1-cachyos (live ISO)
> Fails: 7.3.4-201.nobara.fc44, 7.3.4-1-cachyos
> The 3842 entry is absent from v7.2 and v7.3, present in v7.3.4, and still
> present in v7.4-rc1 and master as of 2026-11-15 (checked via the GitHub mirror).
> Analysis
> snd_hda_pick_fixup() walks the table and matches PCI-SSID entries before the
> codec-SSID fallback. Before the commit, 17aa:3842 had no entry, so this machine
> fell through to the existing codec-SSID entry
> SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
> which works. With the commit, the 3842 entry wins and chains to
> cs35l41_fixup_i2c_four(), so the codec master waits for four CS35L41 components
> that do not exist on this machine.
> Evidence on 7.3.4
> dmesg: "ALC287: picked fixup for PCI SSID 17aa:3842"; no "bound i2c-TIAS2781:00"
> line (on 7.2.10 that line is present).
> /sys/kernel/debug/device_component/hdaudioC0D0: master "not bound",
> four entries "(unknown) not registered".
> With dyndbg, after "echo 1 > /sys/class/sound/hwC0D0/reconfig":
> hdaudioC0D0: trying to bring up adev
> hdaudioC0D0: Looking for component 0
> hdaudioC0D0: master has incomplete components
> After unbinding/binding i2c-TIAS2781:00, tas2781-hda logs "adding component"
> but the master still reports incomplete components.
> Workaround confirmed
> Booting with snd_hda_intel.model=17aa:38cd (alias SSID, handled first by the
> picker) gives:
> ALC287: picked fixup for alias SSID 17aa:38cd
> bound i2c-TIAS2781:00 (ops tas2781_hda_comp_ops [snd_hda_scodec_tas2781_i2c])
> and the speakers work.
> Possible direction
> Since both laptops share the PCI SSID, the ThinkBook entry cannot be fixed by
> PCI SSID alone. One option is a codec-SSID entry for this machine placed before
> the 0x3842 line, e.g.
> HDA_CODEC_QUIRK(0x17aa, 0x38cd, "Legion 16IRX9H / Y790 VECO DUAL",
> ALC287_FIXUP_TAS2781_I2C),
> I have not compiled or tested a patch, only the model= alias above. I am happy
> to test patches on this hardware.
> Separate observation
> After the workaround, speakers still stopped after some idle time. It went away
> with snd_hda_intel power_save=0 power_save_controller=N and keeping
> i2c-TIAS2781:00 power/control at "on". I applied both at once, so I do not know
> which is required. This looks unrelated to the regression above.
> 
> I'd really appreciate it if the issue is fixed, as I'm now having the
> same problem when the laptop is turned on after being suspended for a
> while, and I haven't been able to solve it.

Thanks for the report.  Could you verify whether the patch below is
what you've tested?  I left Y790 entry as is because it's not 100%
sure whether it has also the same codec SSID.


thanks,

Takashi

-- 8< --
Subject: [PATCH] ALSA: hda/realtek: Fix regression on Lenovo Legion 16IRX9H

Lenovo Legion 16IRX9H has the very same PCI SSID (17aa:3842) as the
recently added quirk for Lenovo Thinkpad X G2 IAH, but it needs a
different qurik.  Although the quirk for Legion 16IRX9H is present,
it's not applied because the PCI SSID 17aa:3842 matches at first and
the new quirk for Thinkpad X G2 is taken instead.

As a workaround, put the codec SSID matching (17aa:38cd) for Legion
before the conflicting PCI SSID quirk entry.

Fixes: f2293e7b2ddd ("ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH")
Cc: <stable@vger.kernel.org>
Reported-by: william <assassinshalo29@gmail.com>
Closes: https://lore.kernel.org/CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 2c541c68ff5b..1d609584e778 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8542,6 +8542,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
+	/* Legion 16IRX9H shares PCI SSID 17aa:3842 with Thinkpad X G2 below */
+	HDA_CODEC_QUIRK(0x17aa, 0x38cd, "Lenovo Legion 16IRX9H", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3842, "ThinkBook X G2 IAH", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_4_THINKPAD),
 	/* IdeaPad Pro 5 14IAH10 shares PCI SSID 17aa:3843 with Yoga Book 9i;
 	 * use codec SSID to distinguish them
-- 
2.53.0

