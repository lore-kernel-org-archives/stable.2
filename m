Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717077;
	b=aUQS/0xNUq2BmoJ6TstOx3sucVaJAyW7UTiHf0C++Vnr14NW1K+tYEcXKDX/mv04RIsm
	 1m/LPHjZqJ3H4g8aCSYCgYCtDbBVhAndLsChzdiyBFr5ySHZrxe6J/xBk0d2KkC8KYTdO
	 pqEkOaXH5l5Rulkd3FxarQrL/JStmziegT45WhaexPTBJT3wSKUTvSSVitMy6RInZDjeA
	 Da99Ug4MDsr/U0fpP1sWyV4LWA/jGp4hn5+7Is1r9Tz0PcKuD9ekctsiwLNNhzOB9OCzl
	 OlySkEUcdvSNvwMWTG64jhzo1eS458FlgOEgDp/ysJsjIrOEC1xobsMiZQLpK5w3MKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717077;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=MOx8F45uSrWJfrvKQQ9bd2fIwgZx3o0QDqg7GBPLn0o=;
	b=oRkF3QM5HZ1dFqRX+umxt5U0Ol9O2+ynd3R2xwt9ZcWuljFOjtH0b05kL3wKVP80B00q
	 TpAsrakFBuCUorZZwArRSwU5oYmKgGEGycAmmQHfUTp4PYRf+H8ub4hgMnta1s9gFx/pR
	 hzpE20V0ujh5xMZElC1iu9jgOeRdCHjrMZrJENQCPtvtA+/8meiFxMUmtdnpdR/7qjmCy
	 stZzc46iBqkSKoHAnjwpich2j3upDIgqWGor80nH9uEXZVar1b8PDNy878GOXTMgzR1zR
	 tkohAPsx6+vsQFA9DOaaqqindB43bLrDbHAyRbVllIwfqcbWpWinH83xJMcBAxwTVsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vYWHbTwJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pjH1LFEK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=veVd1VnK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fu55teLJ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABE606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9ABE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vYWHbTwJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pjH1LFEK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=veVd1VnK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fu55teLJ
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7D21F769;
	Tue,  3 Nov 2026 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOx8F45uSrWJfrvKQQ9bd2fIwgZx3o0QDqg7GBPLn0o=;
	b=vYWHbTwJHrx+bHm+iJSZc6M+BPrBQ1uiG0X2WcWxr9Ywc3IJUIaVreUwNhEZD7ACKnfJLq
	dOhDoBO91elMkKglnlJ90JB8x11tihfknKPFDfBdrzhJ8SYPgy8SK3k/ERgpjYhUWqNymX
	FTy6GYatUJuYJnMDOC0rit9qJizcuWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOx8F45uSrWJfrvKQQ9bd2fIwgZx3o0QDqg7GBPLn0o=;
	b=pjH1LFEKtGfIYJVjgCfyO5KqKO18HTqb9IT1qxFpuYvsJ0NO62EGJg3kGPXqiGQM0cqKPV
	VETySZIi1J+zKLAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=veVd1VnK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fu55teLJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793717066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOx8F45uSrWJfrvKQQ9bd2fIwgZx3o0QDqg7GBPLn0o=;
	b=veVd1VnKzGi9ou7E8al/Z1MNeqbcEe/7BsP67W0o6YroWdAuLP992JtUXxwvYAiAN+acfR
	HBcWpUd5bXtRX5ZZj0Wt6jo9PYmCyitAO2imwYLjlP+J5vnQPNA2IHMMEoSleV5gz6Mu1o
	jfGnKnJjo3PdwWSPKZxBPpC9MJUnoPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793717066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOx8F45uSrWJfrvKQQ9bd2fIwgZx3o0QDqg7GBPLn0o=;
	b=fu55teLJdDMP1BP90SMNi97wx4SaHkG4InEwNntbU/TjzrUGx7Dk9TMzB+DTCdFoAbHdC3
	xIidlfHPPx7kPJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D76C134B8;
	Tue,  3 Nov 2026 14:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mz1DCkrz6WrwDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Nov 2026 14:44:26 +0000
Date: Tue, 03 Nov 2026 15:44:25 +0100
Message-ID: <871p92x9di.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Slaton Christie <slatonchristie@gmail.com>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: Add DSD properties for ASUS UX582Z (1043:1a8f)
In-Reply-To: <20261030170354.7427-1-slatonchristie@gmail.com>
References: <20261030170354.7427-1-slatonchristie@gmail.com>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 8E7D21F769

On Fri, 30 Oct 2026 18:03:54 +0100,
Slaton Christie wrote:
> 
> The ASUS Zenbook Pro Duo 15 UX582Z with PCI SSID 1043:1a8f has two
> CS35L41 amplifiers on SPI (CSC3551), but its BIOS provides no _DSD
> properties for them, so the amps fail to probe and the internal
> speakers are silent:
> 
>   cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Failed property cirrus,dev-index: -22
>   cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: error -EINVAL: Platform not supported
> 
> The Realtek codec quirk for this SSID already exists
> (ALC245_FIXUP_CS35L41_SPI_2), and linux-firmware already ships the
> tuned cs35l41-dsp1-spk-prot-10431a8f-* files. Only the property table
> entry is missing.
> 
> Add an entry using the same configuration as the sibling UX582ZS
> (1043:12af): internal boost, CS/reset/speaker-ID GPIOs at indices
> 0/1/2, 1000nH inductor, 4500mA peak, 24uF capacitor.
> 
> Tested on a UX582Z running 7.3.0 (CachyOS) with the change built as a
> DKMS module: both amps probe, load the spk-prot firmware, apply the
> EFI calibration (R0=10611 / 10708) and the speakers play audio.
> 
>   cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 17
>   cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - SSID: 10431A8F, BST: 0, VSPK: 0, CH: L, FW EN: 1, SPKID: 0
>   cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - SSID: 10431A8F, BST: 0, VSPK: 0, CH: R, FW EN: 1, SPKID: 0
> 
> The boost values are copied from the 1043:12af entry, not taken from
> ASUS or Cirrus documentation; confirmation of the boost parameters by
> Cirrus would be appreciated.
> 
> The diagnosis and the patch were prepared with the help of an AI
> assistant (Claude, Anthropic), from the dmesg output above and the
> existing 1043:12af table entry; testing was done on real hardware by
> the submitter.
> 
> Cc: stable@vger.kernel.org

You forgot Signed-off-by tag?  Please resubmit with it.


thanks,

Takashi
