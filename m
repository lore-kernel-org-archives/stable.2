Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630617;
	b=Cy+SjVvPbF355xg2mgC0dr9RegvPW/bDX6ktZQq1TENiBgndJAj6GKAtD1m/ickuU33j
	 EG+H37fHr/0995n3jv6K18VVTI6r2lgzztm/O3QQM0fAa8KPKVC3FqGADXD29sPtMR7p0
	 nAYnUONR/C4KmHt9BDL9z7Pj/oP5SEHAHRKqIIHypo8SmvefJdYJ0pA9DEGHUA4Vsz0ML
	 9UliMJcoXZuXfj+YkyRKdVoWOMWriMZfgiOZCtamDRFwi4Y35emPiFlZIF8FaFzkN9Q0V
	 qq2Brd19ixsYPAXyYb28DRN9w0UKO8olnUVDGcgsgaz8+TCJMxHw22+BzJ9fFdwK1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630617;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=dqrhTQQDpv23O21fI5VeTjhzLmHKOHPLiUInUnOspmc=;
	b=mGgLG93/u6QdHzSqXtF9sti08WXud2qSNgSN8XaN4gYpo6qWaaJgVx+BX5VTfKYA3stt
	 6zalLe433Wyao21EW0BvvDAwBNZb4RayTEP9u5jhBAhyE8zWoaMKibUb1v2kpK6nG9mch
	 boyGxINJ6IcywbTgmP512KVqFq4+zWf0GoL3PZdjY2io64MJ1wrM2Eh/TxhWKR0kqcPxe
	 zzsonaWJ6lFvXAHmQmcpp6iIj1KqFcqFc3JApDPHvm354DDWrImoT+Ab11BolcijwYZ96
	 Pv1o3/3D+6PllZSoWL4q0m5YgqWV683bz39qfrU/uuGjSJJWALRBgGZ7NUTnm4/8fOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VxnjuGo8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TV5SnKzJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VxnjuGo8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TV5SnKzJ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A4606A5BC;
	Mon,  2 Nov 2026 14:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524A4606A5BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VxnjuGo8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TV5SnKzJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VxnjuGo8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TV5SnKzJ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74E1B1F7D7;
	Mon,  2 Nov 2026 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793630613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqrhTQQDpv23O21fI5VeTjhzLmHKOHPLiUInUnOspmc=;
	b=VxnjuGo87h5jl6EdaQow8WW/Us/0xK1EpIl3sDcHoYBqeWoEa3dDKbOkEX6gZGlT/QSF1s
	27LaeDGufghMINuVKY/bN2ysJy/1Nhm5/BbtpsV0/07Iu3jOvthTjCLsdIIxJoZgBSyD+c
	zrCDyk9u5mGt4DHvSWwqAjxdZdfGhQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793630613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqrhTQQDpv23O21fI5VeTjhzLmHKOHPLiUInUnOspmc=;
	b=TV5SnKzJT7FZD2mUi7xZCdLvXEid6zb9/7JSMijKGKdTps5OcmQnoraI46YBL1oSsh1w8v
	WYTp9R5llo/Qo4Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VxnjuGo8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TV5SnKzJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793630613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqrhTQQDpv23O21fI5VeTjhzLmHKOHPLiUInUnOspmc=;
	b=VxnjuGo87h5jl6EdaQow8WW/Us/0xK1EpIl3sDcHoYBqeWoEa3dDKbOkEX6gZGlT/QSF1s
	27LaeDGufghMINuVKY/bN2ysJy/1Nhm5/BbtpsV0/07Iu3jOvthTjCLsdIIxJoZgBSyD+c
	zrCDyk9u5mGt4DHvSWwqAjxdZdfGhQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793630613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqrhTQQDpv23O21fI5VeTjhzLmHKOHPLiUInUnOspmc=;
	b=TV5SnKzJT7FZD2mUi7xZCdLvXEid6zb9/7JSMijKGKdTps5OcmQnoraI46YBL1oSsh1w8v
	WYTp9R5llo/Qo4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 227F8134B8;
	Mon,  2 Nov 2026 14:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEfROpSh6GqsSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Nov 2026 14:43:33 +0000
Date: Mon, 02 Nov 2026 15:43:32 +0100
Message-ID: <87se1j8faj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cristian Castellano <cristian.castellano@icloud.com>
Cc: med.jebabli@gmail.com,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] ALSA: hda/tas2781: divide error on playback open after accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
In-Reply-To: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com>
References: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74E1B1F7D7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -11.01

On Tue, 27 Oct 2026 23:21:57 +0100,
Cristian Castellano wrote:
> 
> Hello, since I updated to 7.2.11 (and then to 7.3), opening a playback stream on my Lenovo Yoga Pro 9
> 16IRP8 (83BY, subsystem 17aa:3835, BIOS KVCN44WW) triggers a divide error in snd_soc_tas2781_fmwlib and audio stops working. 7.2.9 just works.
> 
> The only tas2781 change between the two I found is:
> c1b708f712f5 ("ALSA: hda/tas2781: Accept V1 calibration data without CRC") (upstream 408249089c48).
> 
> At boot the driver now logs:
> 
>   tas2781-hda i2c-TIAS2781:00: tas2781_apply_calib: V1 data without CRC, accepting
> 
> Before that commit the data was rejected and the amplifiers worked with
> default parameters. On this machine the CALI_DATA EFI variable
> (CALI_DATA-1f52d2a1-bb3a-457d-bc09-43a3f4310a92) contains two non-zero
> device entries followed by zeros, with TimeStamp and CRC zeroed:
> 
>   0000000 07 00 00 00 5c c8 20 1d 28 b5 27 23 2a 79 42 16
>   0000016 f2 07 c5 00 00 00 e0 2e 01 f7 2a 1d 72 6f 1b 23
>   0000032 2a 41 4a 16 c4 0a c3 00 00 00 e0 2e 00 00 00 00
>   0000048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   *
>   0000128 00 00 00 00
> 
> (the first 4 bytes are the EFI attributes)
> 
> Oops:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   CPU: 10 UID: 1000 PID: 1533 Comm: wireplumber Tainted: G        W  O        7.3.0-4-cachyos #1 PREEMPT(full)
>   Hardware name: LENOVO 83BY/LNVNB161216, BIOS KVCN44WW 03/05/2025
>   RIP: 0010:tasdevice_select_tuningprm_cfg+0x8c2/0xa90 [snd_soc_tas2781_fmwlib]
>   Code: 4c 89 f7 41 b8 04 00 00 00 2e 2e 2e 41 ff d3 85 c0 0f 88 97 01 00 00 48 8b 4c 24 10 66 0f 38 f0 01 0f b7 c0 0f af 44 24 18 99 <f7> 7c 24 24 88 21 88 41 01 c6 41 08 01 48 8b 4c 24 08 48 8b 44 24
>   RAX: 0000000000000000 RBX: 000000000000002a RCX: ffff8d36ca8af218
>   RDX: 0000000000000000 RSI: 0000000000000db8 RDI: ffff8d36ca8af21b
>   RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000000000a
>   R10: 0000000000000100 R11: ffffffff87559290 R12: ffff8d3684e350df
>   R13: ffff8d36a861d9b8 R14: ffff8d3684e35038 R15: 0000000000000002
>   Call Trace:
>    <TASK>
>    tasdevice_tuning_switch+0x71/0x80 [snd_soc_tas2781_fmwlib]
>    tas2781_hda_playback_hook+0x4c/0x110 [snd_hda_scodec_tas2781_i2c]
>    hda_component_manager_playback_hook+0xb5/0x370 [snd_hda_scodec_component]
>    playback_pcm_open+0x79/0xa0 [snd_hda_codec_generic]
>    hdac_hda_dai_open+0x5c/0x90 [snd_soc_hdac_hda]
>    snd_soc_dai_startup+0x52/0x90 [snd_soc_core]
>    __soc_pcm_open+0x108/0x6c0 [snd_soc_core]
>    dpcm_be_dai_startup+0x153/0x3c0 [snd_soc_core]
>    dpcm_fe_dai_open+0x109/0xc00 [snd_soc_core]
>    snd_pcm_open_substream+0x604/0x920 [snd_pcm]
>    snd_pcm_open+0xeb/0x220 [snd_pcm]
>    snd_pcm_playback_open+0x39/0x60 [snd_pcm]
>    chrdev_open+0xbf/0x230
>    vfs_open+0x3f8/0x520
>    path_openat+0x4f4/0xc50
>    do_file_open+0xd7/0x150
>    do_syscall_64+0x8f/0x380
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> The kernel is  linux-cachyos 7.3 (taint O is from the NVIDIA module);
> CachyOS does not patch the tas2781 driver, and its LTS, 6.18.55  works. If it is needed, I can test patches.
> 
> #regzbot introduced: 408249089c48
> 
> Thank you,
> Cristian Castellano

I guess the following oneliner would prevent the zero-division.
But I'm not sure whether the whole calibration there would make sense
and works properly.  Could you verify it?

Maybe we should make the check of V1 CRC error more restrictive.


thanks,

Takashi

--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2579,7 +2579,7 @@ static int tas2781_cali_preproc(struct tasdevice_priv *priv, int i)
 		 */
 		re_org = r0_deflt[0] << 8 | r0_deflt[1];
 		re_cal = data[k + 1] << 8 | data[k + 2];
-		if (re_org > re_cal) {
+		if (re_cal && re_org > re_cal) {
 			rc = tasdevice_dev_read(priv, i, TAS2781_PG_REG,
 						 &pg_id);
 			if (rc < 0) {
