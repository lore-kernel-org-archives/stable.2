Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D136F917;
	Sat, 10 Oct 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619190; cv=none; b=ILn/FwCU5qkf/cbIHnZ0vZGNDlVGL8tqOgw7OTXGCPGVAJIxC8xVQNCOMvvc68Vmuw4Nm5mLHWBMtWNiuRZkZvmB1rRXRdcjs3OYB3keA7ZBGHCAz+wlaQfbNbLOVldRSUKAqfYwp2BDjZldnuPq0I4u1iv8rDg+zZDn3VLeoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619190; c=relaxed/simple;
	bh=bj+1MemPbrEwXXsNGmi4hA5OV4s0cXLx4StQ2a1tb1c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPHzQNOy1W6Q8tbWrWZyVu6ScCDTR7n98n+CJhTZDjpqh8IvKfq5WwW9jN7dkchgn16fgDqL6kRCBTO/eCCrZNgw9/o5oxIEtvM0m6sJbm9FczlH3/SBaD9wiRdqL9L9B6TTjCzw/u6Ol/KU/gy2yL+haXZQCM3j1mhTyv1eROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K/ZhhESR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQ1SbkGq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K/ZhhESR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQ1SbkGq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K/ZhhESR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQ1SbkGq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K/ZhhESR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQ1SbkGq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DCC621C3E;
	Sat, 10 Oct 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791619187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLc6TxrMOMGLPStSkbO9Vc/GX6rpx7z4Sfi6yCQKdIc=;
	b=K/ZhhESRIAz8vhbDsbbo8Yj8Ez5CTh7MihXwkFdSAh2qvyx5hY+tZhuu6FBpjKfj1xZPgM
	tTrMaCYAQxVTbsF9QPiDIR6yXPtjJ1tvpaRb8sAR8kpXekVRFoGfvBNJ7icIYToOQmgMnE
	tako3x5kGD4DlWmqT4NL34ZYx0FviTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791619187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLc6TxrMOMGLPStSkbO9Vc/GX6rpx7z4Sfi6yCQKdIc=;
	b=hQ1SbkGq1IQzxVrxWzGJ+E6af0xL5sAFXO4jLBgu6cYr1xdz9hu27fn5aNdbM9vEMMjTdH
	l+Ll0ZjZ4zJ/SlDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="K/ZhhESR";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hQ1SbkGq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791619187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLc6TxrMOMGLPStSkbO9Vc/GX6rpx7z4Sfi6yCQKdIc=;
	b=K/ZhhESRIAz8vhbDsbbo8Yj8Ez5CTh7MihXwkFdSAh2qvyx5hY+tZhuu6FBpjKfj1xZPgM
	tTrMaCYAQxVTbsF9QPiDIR6yXPtjJ1tvpaRb8sAR8kpXekVRFoGfvBNJ7icIYToOQmgMnE
	tako3x5kGD4DlWmqT4NL34ZYx0FviTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791619187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLc6TxrMOMGLPStSkbO9Vc/GX6rpx7z4Sfi6yCQKdIc=;
	b=hQ1SbkGq1IQzxVrxWzGJ+E6af0xL5sAFXO4jLBgu6cYr1xdz9hu27fn5aNdbM9vEMMjTdH
	l+Ll0ZjZ4zJ/SlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9C00133F6;
	Sat, 10 Oct 2026 07:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PiMeMHLwyWowSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Oct 2026 07:59:46 +0000
Date: Sat, 10 Oct 2026 09:59:46 +0200
Message-ID: <87pkxij899.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: evgeny@devduty.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH
In-Reply-To: <20261009-thinkbook-x-g2-iah-v1-1-56012188aee0@devduty.com>
References: <20261009-thinkbook-x-g2-iah-v1-1-56012188aee0@devduty.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DCC621C3E
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Fri, 09 Oct 2026 18:02:37 +0200,
Evgeny Akhtimirov via B4 Relay wrote:
> 
> From: Evgeny Akhtimirov <evgeny@devduty.com>
> 
> The Lenovo ThinkBook X G2 IAH (MTM 21TU) has an ALC287 codec with four
> CS35L41 amplifiers on I2C (CSC3551). It reports codec SSID 17aa:3929,
> which it shares with the ThinkBook 13x Gen 5, and PCI SSID 17aa:3842.
> 
> Since PCI SSID 17aa:3842 has no quirk entry, the codec SSID matches
> ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD. That fixup binds only
> two amps (cs35l41-hda.0 and .1), while the CS35L41 configuration table
> describes four for 17AA3929. Amps .2 and .3 probe and load firmware,
> but they are never bound to the codec, so half of the speakers stay
> silent.
> 
> Add a ThinkPad-style fixup chain that binds four I2C amps, and match the
> laptop by its PCI SSID so the ThinkBook 13x Gen 5 is not affected.
> 
> Tested with hda_model=1028:0c4d (alias to ALC287_FIXUP_CS35L41_I2C_4):
> all four amps bind, apply their calibration and are runtime-active
> during playback.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Evgeny Akhtimirov <evgeny@devduty.com>

Thanks, applied now.


Takashi
